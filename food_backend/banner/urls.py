from django.urls import path
from banner import views

urlpatterns = [
    path('ads/', views.get_ads, name='get_ads'),
]