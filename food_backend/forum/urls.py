from django.urls import path

from forum import views


urlpatterns = [
    path('articles/', views.get_articles, name='get_articles'),
    path('categories/', views.get_categories, name='get_categories'),
    path('article/<int:pk>/', views.get_article_detail, name='get_article_detail'),

    path('top/', views.get_top_articles, name='get_top_article'),
    path('latest/', views.get_latest_articles, name='get_latest_articles'),
    path('article/voted/', views.voted_article, name='voted_article'),
    path('article/liked/', views.liked_article, name='liked_article'),
    path('article/likes/', views.get_liked, name='get_liked'),
    path('article/write/', views.write_article, name='write_article'),
    path('article/delete/', views.delete_article, name='delete_article'),
    path('article/comments/', views.get_article_comments, name='get_article_comments'),
    path('article/add/comment/', views.post_comment, name='post_comment'),
    path('article/delete/comment/', views.delete_article_comment, name='delete_comment'),
]
