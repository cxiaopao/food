import json

from django.contrib.auth.models import User
from django.db.models import Count, OuterRef, Avg, Subquery
from django.views.decorators.http import require_http_methods
from django.utils.dateformat import format
from food.models import Food, Category, Manufacturer, Review, Price
from utils import custom_response, paginate_queryset


# 返回食品的数据形式
def food_to_dict(food, request):
    user = request.user
    data = {
        'id': food.id,
        'name': food.name,
        'img': request.build_absolute_uri(food.img.url) if food.img else None,
        'desc': food.desc,
        'shelf_life': food.shelf_life,
        'storage_conditions': food.storage_conditions,
        'rating': food.get_average_rating(),
        'likedCount': food.liked_by.count(),
        'create_time': format(food.create_time, 'Y-m-d H:i:s'),
        'update_time': format(food.update_time, 'Y-m-d H:i:s'),
        'commentCount': food.review.count(),
        'price': food.get_latest_price_info(),
        'category': {
            'id': food.category.id,
            'name': food.category.name,
        } if food.category else None,
        'manufacturer': {
            'id': food.manufacturer.id,
            'name': food.manufacturer.name,
            'website': food.manufacturer.website,
            'phone': food.manufacturer.phone,
            'email': food.manufacturer.email,
            'address': food.manufacturer.address,
            'desc': food.manufacturer.desc
        } if food.manufacturer else None,
        'nutrition': {
            'id': food.nutrition.id,
            'ingredient_name': food.nutrition.ingredient_name,
            'calories': food.nutrition.calories,
            'fat': food.nutrition.fat,
            'carbohydrates': food.nutrition.carbohydrates,
            'protein': food.nutrition.protein,
            'fiber': food.nutrition.fiber,
            'update_time': format(food.nutrition.update_time, 'Y-m-d H:i:s'),
        } if food.nutrition else None,
    }

    if user.is_authenticated:
        data['isLiked'] = user in food.liked_by.all()
        data['isCommented'] = Review.objects.filter(food=food, user=user).exists()
        data['user'] = {
            'id': user.id,
            'username': user.username,
        }

    return data


# 获取所有食品信息
@require_http_methods(["GET"])
def get_foods(request):
    try:
        category_id = request.GET.get('category', None)
        search = request.GET.get('search', None)
        foods = Food.objects.all().order_by('-order', '-update_time')
        if category_id:
            foods = foods.filter(category_id=category_id)
        if search:
            foods = foods.filter(name__icontains=search)
            if foods.count() == 0:
                return custom_response(code=400, message='暂未查询到结果')
        paginated_foods = paginate_queryset(foods, request)
        foods_data = [food_to_dict(food, request) for food in paginated_foods]
        return custom_response(data=foods_data, total=foods.count())
    except Exception as e:
        return custom_response(400, message=str(e))


# 获取食品详情信息
@require_http_methods(["GET"])
def get_food(request, pk):
    try:
        food = Food.objects.get(id=pk)
        food_data = food_to_dict(food, request)
        return custom_response(data=food_data)
    except Food.DoesNotExist:
        return custom_response(404, message='该食品不存在')
    except Exception as e:
        return custom_response(400, message=str(e))


# 根据食品名获取食品
# @require_http_methods(["GET"])
# def get_food_by_name(request):
#     try:
#         food_name = request.GET.get('name')
#         if not food_name:
#             return custom_response(400, message='缺少必要的参数')
#
#         foods = (Food.objects.filter(name__icontains=food_name).
#                  select_related('category', 'manufacturer', 'nutrition').prefetch_related('liked_by'))
#
#         foods_data = [food_to_dict(food, request) for food in foods]
#         return custom_response(data=foods_data, total=foods.count())
#     except Exception as e:
#         return custom_response(400, message=str(e))


# 获取排行榜的食品
@require_http_methods(["GET"])
def get_top_food(request):
    try:
        top = request.GET.get('top', None)
        if not top:
            return custom_response(400, message='缺少必要参数')
        if top == '1':
            foods = Food.objects.annotate(liked_count=Count('liked_by')).order_by('-liked_count', '-update_time')
        elif top == '2':
            reviews = Review.objects.filter(food=OuterRef('pk')).values('food')
            avg_rating = reviews.annotate(avg_rating=Avg('rating')).values('avg_rating')
            foods = Food.objects.annotate(average_rating=Subquery(avg_rating)).order_by('-average_rating',
                                                                                        '-update_time')
        else:
            return custom_response(400, message='无效的top参数')
        foods_data = [
            food_to_dict(food, request) for food in foods[:4]
        ]
        return custom_response(data=foods_data)
    except Exception as e:
        return custom_response(400, message=str(e))


# 喜爱或者取消喜爱食品
@require_http_methods(['PATCH'])
def liked_food(request):
    try:
        food_id = request.GET.get('foodId')
        if not food_id:
            return custom_response(400, '缺少必要的参数')
        user = request.user
        if not user.id:
            return custom_response(401, '请先登录')
        food = Food.objects.get(id=food_id)
        if user in food.liked_by.all():
            food.liked_by.remove(user)
            message = '您已取消喜爱'
        else:
            food.liked_by.add(user)
            message = '标记喜爱成功'
        food.save()
        food_data = {
            'id': food.id,
            'name': food.name,
        }
        return custom_response(message=message, data=food_data)
    except Food.DoesNotExist:
        return custom_response(404, message='该食品不存在')
    except Exception as e:
        return custom_response(400, message=str(e))


# 获取收藏的食品信息
@require_http_methods(["GET"])
def get_liked(request):
    try:
        user = request.user
        if not user.id:
            return custom_response(401, message='请先登录')
        foods = user.liked_foods.all()
        foods_data = [food_to_dict(food, request) for food in foods]
        return custom_response(data=foods_data)
    except Exception as e:
        return custom_response(400, message=str(e))


# 获取食品的所有评论
@require_http_methods(["GET"])
def get_food_reviews(request):
    try:
        food_id = request.GET.get('foodId')
        if not food_id:
            return custom_response(400, message='缺少必要的参数')

        food = Food.objects.get(id=food_id)
        reviews = food.review.all().order_by('-create_time')
        paginated_reviews = paginate_queryset(reviews, request)
        reviews_data = [
            {
                'id': review.id,
                'user': {
                    'id': review.user.id,
                    'username': review.user.username,
                    'avatar': request.build_absolute_uri(
                        review.user.profile.avatar.url) if review.user.profile.avatar else None
                },
                'rating': review.rating,
                'body': review.body,
                'createTime': format(review.create_time, 'Y-m-d H:i:s'),
            }
            for review in paginated_reviews
        ]
        return custom_response(data=reviews_data, total=reviews.count())
    except Food.DoesNotExist:
        return custom_response(404, message='该食品不存在')
    except Exception as e:
        return custom_response(400, message=str(e))


# 发表对食品的评价
@require_http_methods(["POST"])
def post_food_review(request):
    try:
        user = request.user
        if not user.is_authenticated:
            return custom_response(401, message='请先登录')

        data = json.loads(request.body)

        food_id = data.get('foodId')
        rating = data.get('rating')
        body = data.get('body')

        if body.strip() == '':
            return custom_response(400, '缺少评论内容')

        if not food_id or rating is None or body is None:
            return custom_response(400, '缺少必要的参数')

        food = Food.objects.get(id=food_id)

        review = Review.objects.create(
            user=user,
            food=food,
            rating=rating,
            body=body
        )

        review_data = {
            'id': review.id,
            'user': {
                'id': user.id,
                'username': user.username
            },
            'rating': review.rating,
            'body': review.body,
            'create_time': review.create_time.strftime('%Y-%m-%d %H:%M:%S'),
        }
        return custom_response(0, '评论成功', data=review_data)

    except Exception as e:
        return custom_response(400, message=str(e))


# 用户删除自己的评论
@require_http_methods(['DELETE'])
def delete_food_review(request):
    try:
        user_id = request.GET.get('userId')

        if not user_id:
            return custom_response(400, '缺少必要的参数')

        user = User.objects.get(id=user_id)

        if user != request.user:
            return custom_response(403, '您无权删除这些评论')

        reviews = Review.objects.filter(user=user)

        # 删除所有评论
        reviews.delete()

        return custom_response(0, '评论删除成功')
    except Exception as e:
        return custom_response(400, message=str(e))


# 获取食品的价格信息
@require_http_methods(['GET'])
def get_food_prices(request):
    try:
        food_id = request.GET.get('foodId')
        if not food_id:
            return custom_response(400, '缺少必要的参数')
        food = Food.objects.get(id=food_id)
        food_prices = Price.objects.filter(food=food)
        prices_data = [
            {
                'id': price.id,
                'price': price.price,
                'discount': price.discount,
                'create_time': price.create_time
            }
            for price in food_prices
        ]
        return custom_response(0, data=prices_data)
    except Food.DoesNotExist:
        return custom_response(400, message='该食品不存在')
    except Exception as e:
        return custom_response(400, message=str(e))


# 获取食品分类信息
@require_http_methods(["GET"])
def get_food_categories(request):
    try:
        categories = Category.objects.all().order_by('order', '-update_time', '-create_time')
        paginated_categories = paginate_queryset(categories, request)
        categories_data = [
            {
                'id': category.id,
                'name': category.name,
                'desc': category.desc,
                'create_time': format(category.create_time, 'Y-m-d H:i:s'),
                'update_time': format(category.update_time, 'Y-m-d H:i:s'),
            }
            for category in paginated_categories
        ]
        return custom_response(data=categories_data, total=categories.count())
    except Exception as e:
        return custom_response(code=400, message=str(e))


# 导出食品信息
@require_http_methods(["GET"])
def get_food_manufacturers(request):
    try:
        manufacturers = Manufacturer.objects.all()
        paginated_manufacturers = paginate_queryset(manufacturers, request)
        manufacturers_data = [
            {
                'id': manufacturer.id,
                'name': manufacturer.name,
                'desc': manufacturer.desc,
                'website': manufacturer.website,
                'address': manufacturer.address,
                'phone': manufacturer.phone,
                'email': manufacturer.email,
            }
            for manufacturer in paginated_manufacturers
        ]
        return custom_response(data=manufacturers_data, total=manufacturers.count())
    except Exception as e:
        return custom_response(code=400, message=str(e))


# 导出食品信息
import pandas as pd
from django.http import HttpResponse


@require_http_methods(["GET"])
def export_food_to_excel(request):
    food_name = request.GET.get('foodName', None)
    if not food_name:
        return custom_response(code=400, message="请提供食品名")

    try:
        food = Food.objects.get(name=food_name)

        data = {
            '序号': [i + 1 for i in range(food.review.count())],
            '食品名': [food.name] * food.review.count(),
            '类别': [food.category.name if food.category else ''] * food.review.count(),
            '营养信息': [food.nutrition.ingredient_name if food.nutrition else ''] * food.review.count(),
            '生产商名': [food.manufacturer.name if food.manufacturer else ''] * food.review.count(),
            '食品最新价格': [food.get_latest_price_info()['price']] * food.review.count(),
            '折扣价': [food.get_latest_price_info()['discount']] * food.review.count(),
            '评价内容': [review.body for review in food.review.all()],
            '评分': [review.rating for review in food.review.all()],
        }

        df = pd.DataFrame(data)

        response = HttpResponse(content_type='application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')
        response['Content-Disposition'] = f'attachment; filename="{food_name}_data.xlsx"'

        with pd.ExcelWriter(response, engine='openpyxl') as writer:
            df.to_excel(writer, sheet_name='Food Data', index=False)

        return response

    except Food.DoesNotExist:
        return custom_response(code=404, message='该食品不存在')
    except Exception as e:
        return custom_response(code=500, message=str(e))
