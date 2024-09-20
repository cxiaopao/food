from django.contrib import admin
from django.utils.safestring import mark_safe

from banner.models import Ad


@admin.register(Ad)
class AdAdmin(admin.ModelAdmin):
    list_display = ('title', 'display_img', 'update_time', 'create_time', 'order')
    list_per_page = 10
    list_editable = ('order',)
    search_fields = ('title',)
    sortable_by = ('order', 'create_time')
    ordering = ('-order',)

    @admin.display(description='图片')
    def display_img(self, obj):
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
