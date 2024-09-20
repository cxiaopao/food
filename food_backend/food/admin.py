from django.contrib import admin
from django.db.models import Count
from django.utils.html import format_html
from django.utils.safestring import mark_safe

from food.models import Food, Category, Nutrition, Review, Price, Manufacturer


def display_img(obj):
    if obj.img:
        html_img = """  
                         <div onclick='$(".my_set_image_img").hide();$(this).next().show();'>
                         <img src='/media/{}' style='width:50px;height:50px;' title='点击可看大图'>
                         <br/>
                         </div>

                         <div class='my_set_image_img' onclick="$('.my_set_image_img').hide()" style="z-index:9999;position:fixed; left: 100px; top:100px;display:none;">
                         <img src='/media/{}' style='width: 502px;height:500px;margin-left: 200px;' title='点击关闭'>
                         </div>
                         """.format(obj.img, obj.img)
        return mark_safe(html_img)
    return '-'


@admin.register(Category)
class CategoryAdmin(admin.ModelAdmin):
    list_display = ('name', 'desc', 'create_time', 'update_time', 'order',)
    list_editable = ('order',)
    list_per_page = 5
    search_fields = ('name',)


@admin.register(Manufacturer)
class ManufacturerAdmin(admin.ModelAdmin):
    list_display = ('name', 'desc', 'website', 'address', 'phone', 'email')
    list_per_page = 5
    search_fields = ('name',)
    ordering = ('name',)


@admin.register(Food)
class FoodAdmin(admin.ModelAdmin):
    list_display = (
        'name', 'display_img', 'like_count', 'shelf_life', 'category', 'get_nutrition_info')
    ordering = ('order',)

    list_per_page = 5
    search_fields = ('name',)
    list_filter = ('category__name', 'create_time',)

    fieldsets = (
        ('食品操作',
         {'fields': (
         'name', 'desc', 'shelf_life', 'storage_conditions', 'nutrition', 'category', 'manufacturer', 'img',)}),
        ('更多操作', {'fields': ('slug', 'order', 'liked_by',)}),
    )
    autocomplete_fields = ['category', 'manufacturer', 'nutrition']
    filter_horizontal = ('liked_by',)

    @admin.display(description='喜欢数量', ordering=('like_count'))
    def like_count(self, obj):
        return obj.liked_by.count()

    def get_queryset(self, request):
        queryset = super().get_queryset(request)
        queryset = queryset.annotate(like_count=Count('liked_by'))
        return queryset

    @admin.display(description='图片')
    def display_img(self, obj):
        return display_img(obj)

    def get_nutrition_info(self, obj):
        nutrition = obj.nutrition
        if nutrition:
            return format_html(
                '<strong>卡路里:</strong> {} kcal<br>'
                '<strong>蛋白质:</strong> {} g<br>'
                '<strong>脂肪:</strong> {} g<br>'
                '<strong>碳水化合物:</strong> {} g<br>'
                '<strong>纤维素:</strong> {} g',
                nutrition.calories or "N/A",
                nutrition.protein or "N/A",
                nutrition.fat or "N/A",
                nutrition.carbohydrates or "N/A",
                nutrition.fiber
            )
        return "暂无信息"

    get_nutrition_info.short_description = "营养信息"


@admin.register(Nutrition)
class NutritionAdmin(admin.ModelAdmin):
    list_display = ('name', 'ingredient_name', 'calories', 'protein', 'fat', 'carbohydrates', 'fiber', 'update_time')
    list_per_page = 5
    search_fields = ('name',)
    list_filter = ('update_time',)
    ordering = ('-update_time',)


@admin.register(Price)
class PriceAdmin(admin.ModelAdmin):
    list_display = ('food', 'display_img', 'price', 'discount', 'create_time')
    search_fields = ('food__name',)
    list_filter = ('create_time',)
    ordering = ('food__name',)
    list_per_page = 6

    autocomplete_fields = ('food',)

    @admin.display(description='图片')
    def display_img(selff, obj):
        if obj.food.img:
            html_img = """  
                             <div onclick='$(".my_set_image_img").hide();$(this).next().show();'>
                             <img src='/media/{}' style='width:50px;height:50px;' title='点击可看大图'>
                             <br/>
                             </div>

                             <div class='my_set_image_img' onclick="$('.my_set_image_img').hide()" style="z-index:9999;position:fixed; left: 100px; top:10  0px;display:none;">
                             <img src='/media/{}' style='width: 502px;height:500px;margin-left: 200px;' title='点击关闭'>
                             </div>
                             """.format(obj.food.img, obj.food.img)
            return mark_safe(html_img)
        return '-'


@admin.register(Review)
class ReviewAdmin(admin.ModelAdmin):
    list_display = ('food', 'user', 'rating', 'body', 'create_time')
    list_per_page = 5
    search_fields = ('food__name', 'user__username')
    list_filter = ('rating', 'create_time',)
    ordering = ('-create_time',)

    autocomplete_fields = ('food', 'user')
