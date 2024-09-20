import os
import uuid
from django.db import models


def banner_upload_to(instance, filename=None):
    ext = os.path.splitext(filename)[1]
    new_filename = f'{uuid.uuid4().hex}{ext}'
    return f'banner/file/{new_filename}'


class Ad(models.Model):
    """广告"""
    title = models.CharField('标题', max_length=200)
    desc = models.TextField('描述', blank=True, null=True)
    link = models.CharField('链接', max_length=200, blank=True, null=True)
    img = models.ImageField('图片', upload_to=banner_upload_to, null=True)
    order = models.IntegerField('排序', default=0)
    create_time = models.DateTimeField('创建时间', auto_now_add=True, null=True)
    update_time = models.DateTimeField('更新时间', auto_now=True, null=True)

    def __str__(self):
        return self.title

    class Meta:
        ordering = ('-order', 'id')
        verbose_name = '广告'
        verbose_name_plural = '广告'
