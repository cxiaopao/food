from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from django.contrib.auth.models import User
from django.utils.safestring import mark_safe
from user.models import Profile

admin.site.site_title = "食品信息后台系统"
admin.site.site_header = "食品信息后台系统"
admin.site.index_title = "食品信息后台系统"


class NewUserAdmin(UserAdmin):
    list_display = ('username', 'is_staff', 'is_active', 'is_superuser',
                    'last_login', 'date_joined',)
    search_fields = ('username', 'email', 'first_name', 'last_name')
    list_filter = ('is_staff', 'is_superuser', 'is_active', 'date_joined',)
    fieldsets = (
        (None, {'fields': ('username', 'password')}),
        ('权限管理', {'fields': ('is_active', 'is_staff', 'is_superuser', 'user_permissions',  'groups')}),
        ('时间管理', {'fields': ('last_login', 'date_joined')}),
    )
    sortable_by = ('is_superuser', 'date_joined', 'last_login',)
    ordering = ('-is_superuser',)
    list_per_page = 10


# 取消原有的User模型注册
admin.site.unregister(User)
admin.site.register(User, NewUserAdmin)


@admin.register(Profile)
class ProfileAdmin(admin.ModelAdmin):
    list_display = ('user', 'display_avatar', 'title', 'phone', 'wechat', 'qq', 'bio', 'update_time')
    list_per_page = 10
    search_fields = ('user__username', 'phone', 'wechat', 'qq',)
    list_filter = ('title', 'update_time')
    ordering = ('-update_time',)
    sortable_by = ('update_time',)
    autocomplete_fields = ('user',)

    @admin.display(description='头像')
    def display_avatar(self, obj):
        if obj.avatar:
            html_img = """  
                             <div onclick='$(".my_set_image_img").hide();$(this).next().show();'>
                             <img src='/media/{}' style='width:50px;height:50px;' title='点击可看大图'>
                             <br/>
                             </div>

                             <div class='my_set_image_img' onclick="$('.my_set_image_img').hide()" style="z-index:9999;position:fixed; left: 100px; top:100px;display:none;">
                             <img src='/media/{}' style='width: 502px;height:500px;margin-left: 200px;' title='点击关闭'>
                             </div>
                             """.format(obj.avatar, obj.avatar)
            return mark_safe(html_img)
        return '-'
