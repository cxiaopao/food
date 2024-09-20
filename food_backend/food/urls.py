from django.urls import path

from food import views

urlpatterns = [
    path('all/', views.get_foods, name='get_foods'),
    path('<int:pk>', views.get_food, name='get_food'),
    path('top/', views.get_top_food, name='get_top_food'),
    path('liked/', views.liked_food, name='liked_food'),
    path('likes/', views.get_liked, name='get_liked'),

    path('reviews/', views.get_food_reviews, name='get_food_reviews'),
    path('review/add/', views.post_food_review, name='post_food_review'),
    path('review/delete/', views.delete_food_review, name='delete_food_review'),

    path('prices/', views.get_food_prices, name='get_food_prices'),

    path('categories/', views.get_food_categories, name='get_food_categories'),
    path('manufacturers/', views.get_food_manufacturers, name='get_food_manufacturers'),

    path('export-food/', views.export_food_to_excel, name='export_food_to_excel'),
]
