from django.views.decorators.http import require_http_methods

from banner.models import Ad
from utils import custom_response


@require_http_methods(["GET"])
def get_ads(request):
    try:
        ads = Ad.objects.all().order_by('-order', 'id')[:4]
        ads_data = []
        for ad in ads:
            ad_info = {
                'id': ad.id,
                'title': ad.title,
                'img': request.build_absolute_uri(ad.img.url) if ad.img else None,
                'desc': ad.desc,
                'link': ad.link,
            }
            ads_data.append(ad_info)
        return custom_response(data=ads_data)
    except Exception as e:
        return custom_response(400, message=str(e))
