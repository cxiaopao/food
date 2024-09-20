import random
from django.core.mail import send_mail
from django.conf import settings
from django.http import JsonResponse
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger


# def custom_response(code=0, message='查询成功', data=None, total=0):
#     # 错误响应
#     if code != 0:
#         return JsonResponse({
#             'msg': message,
#             'code': code
#         }, status=400)
#
#     #  正确响应
#     response = {
#         'code': code,
#         'msg': message,
#         'data': data,
#     }
#     if total > 0:
#         response['total'] = total
#     return JsonResponse(response)


def custom_response(code=0, message='查询成功', data=None, total=0):
    from django.http import JsonResponse
    if code != 0:
        return JsonResponse({
            'msg': message,
            'code': code
        }, status=400)
    response = {
        'code': code,
        'msg': message,
        'data': data,
    }
    if total > 0:
        response['total'] = total
    return JsonResponse(response)


def get_pagination_params(request):
    page_num = int(request.GET.get('pageNum', 1))
    page_size = int(request.GET.get('pageSize', 10))
    return page_num, page_size


def paginate_queryset(queryset, request):
    page_num, page_size = get_pagination_params(request)
    paginator = Paginator(queryset, page_size)

    try:
        page = paginator.page(page_num)
        return page.object_list
    except PageNotAnInteger:
        page = paginator.page(1)
        return page.object_list
    except EmptyPage:
        return []


def generate_verification_code():
    return ''.join(random.choices('0123456789', k=6))


def send_verification_email(email, code):
    subject = '食品信息系统用户注册'
    message = f'您的验证码是: {code}'
    from_email = settings.EMAIL_HOST_USER
    send_mail(subject, message, from_email, [email])
