import os
import uuid
from django.contrib.auth.models import User
from django.db import models


def user_upload_to(instance, filename=None):
    ext = os.path.splitext(filename)[1]
    new_filename = f'{uuid.uuid4().hex}{ext}'
    return f'user/file/{new_filename}'


class Profile(models.Model):
    """个人资料"""

    user = models.OneToOneField(User, on_delete=models.CASCADE, related_name="profile", verbose_name="用户")
    title = models.CharField("头衔", max_length=120, blank=True, null=True, default='')
    phone = models.CharField("手机", max_length=50, blank=True, null=True, default='')
    wechat = models.CharField("微信", max_length=50, blank=True, null=True, default='')
    qq = models.CharField("QQ", max_length=50, blank=True, null=True, default='')
    bio = models.TextField("简介", blank=True, null=True, default='这个人很懒，什么都没有留下')
    avatar = models.ImageField("头像", upload_to=user_upload_to, null=True, blank=True,
                               default='user/avatar.png')
    update_time = models.DateTimeField('更新时间', auto_now=True)

    def __str__(self):
        return f"{self.user.username}的个人资料"

    class Meta:
        verbose_name = '个人资料'
        verbose_name_plural = '个人资料'
        ordering = ('id',)
