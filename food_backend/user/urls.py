from django.urls import path

from user import views

urlpatterns = [
    path('login/', views.login, name='login'),
    path('logout/', views.my_logout, name='my_logout'),
    path('update/', views.update_profile, name='update_profile'),
    path('password/', views.update_password, name='update_password'),
    path('', views.get_user, name='get_user'),
    path('register/', views.register, name='register'),
    path('send/code/', views.send_verification_code, name='send_verification_code'),
]
