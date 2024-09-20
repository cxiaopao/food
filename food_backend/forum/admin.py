from django.contrib import admin
from django.utils.safestring import mark_safe
from django_summernote.admin import SummernoteModelAdmin
from forum.models import Article, Comment, Category


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


@admin.register(Article)
class ArticleAdmin(SummernoteModelAdmin, admin.ModelAdmin):
    summernote_fields = ('body',)
    list_display = (
        'title', 'display_img', 'author', 'category', 'status', 'views', 'get_voted_count', 'get_liked_count',
        'update_time',
        'create_time',)
    list_editable = ('status',)
    list_per_page = 7
    search_fields = ('title', 'category')
    list_filter = ('status', 'is_top', 'create_time')
    ordering = ('-create_time',)

    fieldsets = (
        ('文章操作', {'fields': ('author', 'title', 'category', 'summary', 'body', 'img',)}),
        ('更多操作', {'fields': ('slug', 'views', 'status', 'is_top', 'voted_by', 'liked_by',)}),
    )
    autocomplete_fields = ['author', 'category']
    filter_horizontal = ('liked_by', 'voted_by')

    @admin.display(description='图片')
    def display_img(self, obj):
        return display_img(obj)

    @admin.display(description='收藏数', ordering='-liked_by')
    def get_liked_count(self, obj):
        return obj.liked_by.count()

    @admin.display(description='点赞数', ordering='-voted_by')
    def get_voted_count(self, obj):
        return obj.voted_by.count()


@admin.register(Comment)
class CommentAdmin(admin.ModelAdmin):
    list_display = ('article', 'body', 'author', 'ip', 'parent', 'active', 'create_time')
    ordering = ('create_time',)
    list_per_page = 7
    search_fields = ('author__username', 'ip')
    list_filter = ('active', 'create_time')

    autocomplete_fields = ['author', 'article', 'parent']


@admin.register(Category)
class CategoryAdmin(admin.ModelAdmin):
    list_display = ('name', 'desc', 'order', 'update_time', 'create_time')
    search_fields = ('name',)
    ordering = ('create_time',)
    list_per_page = 7
    list_editable = ('order',)
    list_filter = ('create_time', 'update_time',)
