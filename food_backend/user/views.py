import json

from django.contrib.auth import authenticate, login as auth_login, logout, update_session_auth_hash
from django.contrib.auth.hashers import make_password
from django.contrib.auth.models import User
from django.core.cache import cache
from django.db.models import Count
from django.db.models.functions import TruncYear
from django.middleware.csrf import get_token
from django.views.decorators.http import require_http_methods

from forum.models import Article, Comment
from forum.views import article_to_dict
from user.models import Profile
from utils import custom_response, generate_verification_code, send_verification_email
from django.utils.dateformat import format


# 登录
@require_http_methods(["POST"])
def login(request):
    try:
        data = json.loads(request.body)
        username = data.get("username")
        password = data.get("password")
        user = authenticate(request, username=username, password=password)
        if not user.is_active:
            return custom_response(400, message='账户被禁用')
        if user is not None and user.is_active:
            auth_login(request, user)
            csrf_token = get_token(request)
            response_data = {
                'id': user.id,
                'username': user.username,
                'email': user.email,
                'phone': user.profile.phone,
                'wechat': user.profile.wechat,
                'qq': user.profile.qq,
                'bio': user.profile.bio,
                'avatar': request.build_absolute_uri(user.profile.avatar.url) if user.profile.avatar else None,
                'csrf_token': csrf_token,
                'session_id': request.session.session_key,
                'isStaff': user.is_staff,
                'isActive': user.is_active
            }
            return custom_response(data=response_data)
        else:
            return custom_response(400, message='用户名或者密码错误')
    except Exception as e:
        return custom_response(400, message=str(e))


# 注册
@require_http_methods(["POST"])
def register(request):
    try:
        data = json.loads(request.body)
        username = data.get("username")
        password1 = data.get("password1")
        password2 = data.get("password2")
        email = data.get("email")
        verification_code = data.get("code")

        if not all([username, password1, password2, email, verification_code]):
            return custom_response(400, message='缺少必要的参数')

        if password1 != password2:
            return custom_response(400, message='两次输入的密码不一致')

        cached_code = cache.get(email)
        if cached_code != verification_code:
            return custom_response(400, message='验证码不正确或已过期')

        if User.objects.filter(username=username).exists():
            return custom_response(400, message='用户名已存在')

        if User.objects.filter(email=email).exists():
            return custom_response(400, message='邮箱已注册')

        user = User.objects.create(
            username=username,
            password=make_password(password1),
            email=email
        )
        return custom_response(0, message='注册成功', data={'id': user.id, 'username': user.username})
    except Exception as e:
        return custom_response(500, message=str(e))


# 发送验证码
@require_http_methods(["POST"])
def send_verification_code(request):
    try:
        data = json.loads(request.body)
        email = data.get("email")

        if not email:
            return custom_response(400, message='缺少必要的参数')

        if User.objects.filter(email=email).exists():
            return custom_response(400, message='邮箱已注册')

        code = generate_verification_code()
        cache.set(email, code, timeout=120)  # 验证码有效期为2分钟
        send_verification_email(email, code)
        return custom_response(0, message='验证码已发送', data=code)
    except Exception as e:
        return custom_response(500, message=str(e))


# 退出登录
@require_http_methods(["GET"])
def my_logout(request):
    logout(request)
    return custom_response(message='退出登录成功')


# 更新我的个人资料
@require_http_methods(["POST"])
def update_profile(request):
    """更新信息页面"""
    try:
        user = request.user
        if not user.id:
            return custom_response(code=401, message='请先登录')
        data = request.POST
        email = data.get('email', user.email).strip()
        phone = data.get('phone', user.profile.phone).strip()
        wechat = data.get('wechat', user.profile.wechat).strip()
        qq = data.get('qq', user.profile.qq).strip()
        bio = data.get('bio', user.profile.bio).strip()

        if phone and Profile.objects.exclude(user=user).filter(phone=phone).exists():
            return custom_response(code=400, message="该电话已被他人占用")
        if wechat and Profile.objects.exclude(user=user).filter(wechat=wechat).exists():
            return custom_response(code=400, message="该微信号已被他人占用")
        if qq and Profile.objects.exclude(user=user).filter(qq=qq).exists():
            return custom_response(code=400, message="该QQ号已被他人占用")
        if email and User.objects.exclude(id=user.id).filter(email=email).exists():
            return custom_response(code=400, message="该邮箱已被他人占用")

        user.email = email
        user.profile.phone = phone
        user.profile.wechat = wechat
        user.profile.qq = qq
        user.profile.bio = bio

        # 处理头像文件
        if 'avatar' in request.FILES:
            avatar = request.FILES['avatar']
            user.profile.avatar.save(avatar.name, avatar)

        user.save()
        user.profile.save()

        response_data = {
            'email': user.email,
            'phone': user.profile.phone,
            'wechat': user.profile.wechat,
            'qq': user.profile.qq,
            'bio': user.profile.bio,
            'avatar': request.build_absolute_uri(user.profile.avatar.url) if user.profile.avatar else None,
        }
        return custom_response(message="更新成功", data=response_data)
    except Exception as e:
        return custom_response(code=400, message=str(e))


# 更新我的密码
@require_http_methods(["PATCH"])
def update_password(request):
    try:
        user = request.user
        if not user.id:
            return custom_response(message='请先登录', code=401)
        data = json.loads(request.body)
        password = data['password']
        new_password = data['newPassword']
        re_new_password = data['reNewPassword']
        if not user.check_password(password):
            return custom_response(message="当前密码错误", code=400)
        if new_password != re_new_password:
            return custom_response(message="确认密码不对", code=400)
        user.set_password(password)
        user.save()
        # 更新session，防止用户被登出
        update_session_auth_hash(request, user)
        return custom_response(message='密码更新成功，请重新登录')
    except Exception as e:
        return custom_response(message=str(e), code=400)


# 查看他人资料
@require_http_methods(["GET"])
def get_user(request):
    try:
        user_id = request.GET.get('userId')
        if not user_id:
            return custom_response(code=400, message='缺少必要参数')
        user = User.objects.get(id=user_id)
        if request.user.id != int(user_id):
            articles = user.articles.filter(status='p')
        else:
            articles = user.articles.all()

        # 总共获得多少次点赞
        total_votes = Article.objects.filter(author=user).aggregate(total_votes=Count('voted_by'))['total_votes']
        # 总共获得多少次收藏
        total_likes = Article.objects.filter(author=user).aggregate(total_likes=Count('liked_by'))['total_likes']
        # 总共获得的评论数
        total_comments = Comment.objects.filter(article__author=user).count()
        # 创作历程
        per_year_counts = Article.objects.filter(author=user, status='p') \
            .annotate(year=TruncYear('create_time')) \
            .values('year') \
            .annotate(count=Count('id')) \
            .order_by('year')
        per_year_created = [{'year': item['year'].year, 'count': item['count']} for item in per_year_counts]

        articles_data = [
            article_to_dict(article, request)
            for article in articles
        ]
        user_data = {
            'id': user.id,
            'username': user.username,
            'bio': user.profile.bio,
            'email': user.email,
            'wechat': user.profile.wechat,
            'qq': user.profile.qq,
            'avatar': request.build_absolute_uri(user.profile.avatar.url) if user.profile.avatar else None,
            'articles': articles_data,
            'totalLikes': total_likes,
            'totalVotes': total_votes,
            'totalComments': total_comments,
            'perYearCreated': per_year_created
        }
        return custom_response(data=user_data)
    except User.DoesNotExist:
        return custom_response(code=400, message='该用户不存在')
    except Exception as e:
        return custom_response(message=str(e), code=400)
