import json

from django.db.models import Count
from django.views.decorators.http import require_http_methods
from forum.models import Article, Category, Comment
from utils import custom_response, paginate_queryset
from django.utils.dateformat import format


# 返回文章的数据格式
def article_to_dict(article, request):
    data = {
        'id': article.id,
        'title': article.title,
        'img': request.build_absolute_uri(article.img.url) if article.img else None,
        'summary': article.summary,
        'body': article.body,
        'status': article.status,
        'views': article.views,
        'createTime': format(article.create_time, 'Y-m-d H:i:s'),
        'updateTime': format(article.update_time, 'Y-m-d H:i:s'),
        'category': {
            'id': article.category.id,
            'name': article.category.name,
        } if article.category else None,
        'likedCount': article.liked_by.count(),
        'votedCount': article.voted_by.count(),
        'author': {
            'id': article.author.id,
            'username': article.author.username,
            'avatar': request.build_absolute_uri(
                article.author.profile.avatar.url) if article.author.profile.avatar else None,
        }
    }
    user = request.user
    if user.is_authenticated:
        data['isLiked'] = user in article.liked_by.all()
        data['isVoted'] = user in article.voted_by.all()

    return data


# 返回类别的数据格式
def article_category_to_dict(category, request):
    data = {
        'id': category.id,
        'name': category.name,
        'desc': category.desc,
        'create_time': format(category.create_time, 'Y-m-d H:i:s'),
        'update_time': format(category.update_time, 'Y-m-d H:i:s'),
    }
    return data


# 获取文章
@require_http_methods(["GET"])
def get_articles(request):
    try:
        category_id = request.GET.get('category', None)
        search = request.GET.get('search', None)
        articles = Article.objects.filter(status='p').order_by('-create_time', '-update_time')
        if category_id:
            articles = articles.filter(category_id=category_id)
            if articles.count() == 0:
                return custom_response(code=0, message='分类结果为空', data=[])
        if search:
            articles = articles.filter(title__icontains=search)
            if articles.count() == 0:
                return custom_response(code=0, message='查询结果为空', data=[])
        paginated_articles = paginate_queryset(articles, request)
        articles_data = [article_to_dict(article, request) for article in paginated_articles]
        return custom_response(data=articles_data, total=articles.count())
    except Exception as e:
        return custom_response(code=400, message=str(e))


# 获取文章类别
@require_http_methods(["GET"])
def get_categories(request):
    try:
        categories = Category.objects.all().order_by('order', '-update_time', '-create_time')[:6]
        paginated_categories = paginate_queryset(categories, request)
        categories_data = [
            article_category_to_dict(category, request)
            for category in paginated_categories
        ]
        return custom_response(data=categories_data, total=categories.count())
    except Exception as e:
        return custom_response(code=400, message=str(e))


# 获取文章的详情信息
@require_http_methods(["GET"])
def get_article_detail(request, pk):
    try:
        if not pk:
            return custom_response(400, message='缺少必要的参数')
        article = Article.objects.get(id=pk)
        if article.status == 'p':
            article.views += 1
            article.save()
            article_data = article_to_dict(article, request)
            return custom_response(data=article_data)
        else:
            article_data = {
                'id': article.id,
                'title': article.title,
                'summary': article.summary,
                'status': article.status,
                'body': article.body,
                'img': request.build_absolute_uri(article.img.url) if article.img else None,
            }
            return custom_response(data=article_data)
    except Article.DoesNotExist:
        return custom_response(404, message='文章不存在')
    except Exception as e:
        return custom_response(400, message=str(e))


# 获取文章的所有评论，包括子评论
@require_http_methods(["GET"])
def get_article_comments(request):
    try:
        article_id = request.GET.get('articleId', None)
        if not article_id:
            return custom_response(400, message='缺少必要的参数')

        article = Article.objects.get(id=article_id)
        comments = article.comments.filter(parent=None).order_by('-create_time')

        paginated_comments = paginate_queryset(comments, request)

        def get_comment_data(comment):
            parent_data = None
            if comment.parent:
                parent_data = {
                    'id': comment.parent.id,
                    'author': {
                        'id': comment.parent.author.id,
                        'username': comment.parent.author.username,
                        'avatar': request.build_absolute_uri(
                            comment.parent.author.profile.avatar.url) if comment.parent.author.profile.avatar else None
                    }
                }
            return {
                'id': comment.id,
                'ip': comment.ip,
                'author': {
                    'id': comment.author.id,
                    'username': comment.author.username,
                    'avatar': request.build_absolute_uri(
                        comment.author.profile.avatar.url) if comment.author.profile.avatar else None
                },
                'body': comment.body,
                'createTime': format(comment.create_time, 'Y-m-d H:i:s'),
                'parent': parent_data,
                'replies': []  # 平面化结构，不在这里返回嵌套的回复
            }

        def flatten_replies(comment):
            all_replies = []
            for reply in comment.replies.all().order_by('-create_time'):
                all_replies.append(get_comment_data(reply))
                all_replies.extend(flatten_replies(reply))
            return all_replies

        comments_data = []
        for comment in paginated_comments:
            comment_data = get_comment_data(comment)
            comment_data['replies'] = flatten_replies(comment)
            comments_data.append(comment_data)

        return custom_response(data=comments_data, total=comments.count())
    except Article.DoesNotExist:
        return custom_response(404, message='文章不存在')
    except Exception as e:
        return custom_response(400, message=str(e))


# 获取排行榜的文章
@require_http_methods(["GET"])
def get_top_articles(request):
    try:
        top = request.GET.get('top', None)
        single = request.GET.get('single', None)

        if not top and not single:
            return custom_response(400, message='缺少必要参数')

        if top and single:
            return custom_response(400, message='top和single参数不能同时存在')

        if top:
            if top == '1':
                condition = 'liked_by'
                articles = Article.objects.annotate(liked_count=Count(condition)).order_by('-liked_count',
                                                                                           '-update_time')
            elif top == '2':
                condition = 'voted_by'
                articles = Article.objects.annotate(voted_count=Count(condition)).order_by('-voted_count',
                                                                                           '-update_time')
            else:
                return custom_response(400, message='无效的top参数')

            articles_data = [article_to_dict(article, request) for article in articles[:3]]
            return custom_response(data=articles_data)

        if single:
            if single == '1':
                condition = 'liked_by'
                article = Article.objects.annotate(liked_count=Count(condition)).order_by('-liked_count',
                                                                                          '-update_time').first()
            elif single == '2':
                condition = 'voted_by'
                article = Article.objects.annotate(voted_count=Count(condition)).order_by('-voted_count',
                                                                                          '-update_time').first()
            else:
                return custom_response(400, message='无效的single参数')

            if not article:
                return custom_response(400, message='未找到文章')

            article_data = article_to_dict(article, request)
            return custom_response(data=article_data)

    except Exception as e:
        return custom_response(400, message=str(e))


# 获取最新时间的文章
@require_http_methods(["GET"])
def get_latest_articles(request):
    try:
        limit = int(request.GET.get('limit', 3))
        if not limit:
            return custom_response(400, 'limit没有携带参数')
        articles = Article.objects.order_by('-update_time')[:limit]
        articles_data = [article_to_dict(article, request) for article in articles]
        return custom_response(data=articles_data)
    except Exception as e:
        return custom_response(400, message=str(e))


# 收藏文章
@require_http_methods(['PATCH'])
def liked_article(request):
    try:
        article_id = request.GET.get('articleId', None)
        if not article_id:
            return custom_response(400, '缺少必要的参数')
        user = request.user
        if not user.id:
            return custom_response(401, '请先登录')
        article = Article.objects.get(id=article_id)
        if article.status is not 'p':
            return custom_response(400, '请求错误')
        if user in article.liked_by.all():
            article.liked_by.remove(user)
            message = '取消收藏成功'
        else:
            article.liked_by.add(user)
            message = '收藏成功'
        article.save()
        data = {
            'id': article.id,
            'name': article.title,
        }
        return custom_response(message=message, data=data)
    except Article.DoesNotExist:
        return custom_response(404, message='文章不存在')
    except Exception as e:
        return custom_response(400, message=str(e))


# 点赞文章
@require_http_methods(['PATCH'])
def voted_article(request):
    try:

        user = request.user
        if not user.id:
            return custom_response(401, '请先登录')
        article_id = request.GET.get('articleId')
        if not article_id:
            return custom_response(400, '缺少必要的参数')
        article = Article.objects.get(id=article_id)
        if article.status is not 'p':
            return custom_response(400, '请求错误')
        if user in article.voted_by.all():
            article.voted_by.remove(user)
            message = '取消点赞成功'
        else:
            article.voted_by.add(user)
            message = '点赞成功'
        article.save()
        article_data = {
            'id': article.id,
            'name': article.title,
        }
        return custom_response(message=message, data=article_data)
    except Article.DoesNotExist:
        return custom_response(404, message='文章不存在')
    except Exception as e:
        return custom_response(400, message=str(e))


# 获取收藏的文章
@require_http_methods(['GET'])
def get_liked(request):
    try:
        user = request.user
        if not user.id:
            return custom_response(401, message='请先登录')
        articles = user.liked_articles.all()
        if not articles:
            return custom_response(data=[])
        articles_data = [article_to_dict(article, request) for article in articles]
        return custom_response(data=articles_data)
    except Exception as e:
        return custom_response(400, message=str(e))


# 提交文章
@require_http_methods(['POST'])
def write_article(request):
    try:
        user = request.user
        if not user.id:
            return custom_response(code=401, message='请先登录')
        data = request.POST
        article_id = data.get('id')
        title = data.get('title')
        summary = data.get('summary')
        body = data.get('body')
        status = data.get('status')
        if status == 'd':
            status = 'd'
        else:
            status = 'r'

        if article_id:
            # 更新文章
            article = Article.objects.get(id=article_id, author=user)
            article.title = title
            article.summary = summary
            article.body = body
            article.status = status
        else:
            if not title:
                return custom_response(code=400, message='文章缺少标题')
            if not summary:
                return custom_response(code=400, message='文章缺少摘要')
            if not body:
                return custom_response(code=400, message='文章缺少正文')
            if 'img' not in request.FILES:
                return custom_response(code=400, message='请上传文章封面图')
            article = Article(title=title, summary=summary, body=body, author=user, status=status)

        if 'img' in request.FILES:
            img = request.FILES['img']
            article.img.save(img.name, img)

        article.save()

        article_data = {
            'id': article.id,
            'title': article.title,
            'summary': article.summary,
            'status': article.status,
            'img': request.build_absolute_uri(article.img.url) if article.img else None
        }
        return custom_response(data=article_data, message='提交成功')
    except Exception as e:
        return custom_response(400, message=str(e))


# 删除文章
@require_http_methods(['DELETE'])
def delete_article(request):
    try:
        user = request.user
        id = request.GET.get('id', None)
        article = Article.objects.get(id=id)
        if article.author.id is not user.id:
            return custom_response(code=400, message='您没有权限操作')
        article.delete()
        return custom_response(data={'articleId': id}, message='删除成功')
    except Exception as e:
        return custom_response(code=400, message=str(e))


# 文章的评论
@require_http_methods(['POST'])
def post_comment(request):
    try:
        user = request.user
        if user.id is None:
            return custom_response(code=401, message='请先登录')

        data = json.loads(request.body)
        article_id = data.get('articleId')
        body = data.get('body')
        parent_id = data.get('parentId')

        if article_id is None:
            return custom_response(400, '缺少必要的参数')

        if not body:
            return custom_response(400, message='缺少评论内容')

        article = Article.objects.get(id=article_id)

        comment = Comment.objects.create(
            author=user,
            article=article,
            body=body,
            ip=get_client_ip(request)
        )

        if parent_id:
            comment.parent = Comment.objects.get(id=parent_id)
            comment.save()

        comment_data = {
            'id': comment.id,
            'author': {
                'id': user.id,
                'username': user.username,
                'avatar': request.build_absolute_uri(
                    comment.author.profile.avatar.url) if comment.author.profile.avatar else None
            },
            'body': comment.body,
            'ip': comment.ip,
            'create_time': comment.create_time.strftime('%Y-%m-%d %H:%M:%S'),
        }

        return custom_response(0, '评论成功', data=comment_data)

    except json.JSONDecodeError:
        return custom_response(400, '请求体不是有效的JSON')
    except Exception as e:
        return custom_response(400, message=str(e))


# 获取ip
def get_client_ip(request):
    """获取IP"""
    x_forwarded_for = request.META.get('HTTP_X_FORWARDED_FOR')
    if x_forwarded_for:
        ip = x_forwarded_for.split(',')[0]
    else:
        ip = request.META.get('REMOTE_ADDR')
    return ip


# 删除评论
@require_http_methods(['DELETE'])
def delete_article_comment(request):
    try:
        user = request.user

        if not user.id:
            return custom_response(401, '请先登录')

        comment_id = request.GET.get('id')

        comment = Comment.objects.get(id=comment_id)

        if comment.author.id is not user.id:
            return custom_response(400, '您没有权限删除')

        # 删除该评论
        comment.delete()
        return custom_response(0, '评论删除成功')
    except Exception as e:
        return custom_response(400, message=str(e))
