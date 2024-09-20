import os
import uuid
from django.contrib.auth.models import User
from django.db import models
from django.urls import reverse
from uuslug import uuslug


def article_upload_to(instance, filename=None):
    ext = os.path.splitext(filename)[1]
    new_filename = f'{uuid.uuid4().hex}{ext}'
    return f'article/file/{new_filename}'


class Category(models.Model):
    """文章类别模型"""

    name = models.CharField('分类名称', max_length=10)
    slug = models.SlugField('地址缩写', max_length=120, unique=True, null=True, blank=True)
    desc = models.TextField('分类描述', blank=True, null=True)
    order = models.IntegerField('级别', default=0)
    create_time = models.DateTimeField('创建时间', auto_now_add=True)
    update_time = models.DateTimeField('更新时间', auto_now=True)

    def __str__(self):
        return self.name

    def get_detail_url(self):
        return reverse('category', args=[self.slug, ])

    def save(self, *args, **kwargs):
        if not self.slug:
            self.slug = uuslug(self.name, instance=self)
        super(Category, self).save(*args, **kwargs)

    class Meta:
        ordering = ('-order', 'id')
        verbose_name = '文章分类'
        verbose_name_plural = '文章分类'


class Article(models.Model):
    """食品文章模型"""

    STATUS_CHOICE = (
        ('d', '草稿'),
        ('r', '审核中'),
        ('p', '已发表'),
    )
    title = models.CharField('标题', max_length=250)
    author = models.ForeignKey(User, on_delete=models.CASCADE, related_name='articles', verbose_name='作者')
    slug = models.SlugField('地址缩写', max_length=120, null=True, blank=True, unique=True)
    img = models.ImageField('图片', upload_to=article_upload_to, null=True)
    summary = models.TextField('摘要', null=True)
    body = models.TextField('正文')
    views = models.IntegerField('浏览量', default=0, null=True, blank=True)
    voted_by = models.ManyToManyField(to=User, related_name='voted_articles', null=True, blank=True,
                                      verbose_name='点赞')
    liked_by = models.ManyToManyField(to=User, related_name='liked_articles', null=True, blank=True,
                                      verbose_name='收藏')
    status = models.CharField('状态', max_length=1, choices=STATUS_CHOICE, default='d', null=True, blank=True)
    is_top = models.BooleanField('热门', default=False, null=True, blank=True)
    category = models.ForeignKey(Category, on_delete=models.CASCADE, related_name="articles", null=True, blank=True,
                                 verbose_name='分类')
    update_time = models.DateTimeField('更新时间', auto_now=True)
    create_time = models.DateTimeField('创建时间', auto_now_add=True)

    def get_detail_url(self):
        """获取当前文章详情页地址"""
        return reverse('forum:article_detail', args=[self.slug, ])

    def __str__(self):
        return self.title

    def save(self, *args, **kwargs):
        if not self.slug:
            self.slug = uuslug(self.title, instance=self)
        super(Article, self).save(*args, **kwargs)

    class Meta:
        ordering = ('-create_time', '-update_time')
        verbose_name = '食品文章'
        verbose_name_plural = '食品文章'


class Comment(models.Model):
    """文章评论模型"""

    body = models.TextField('正文')
    ip = models.CharField('IP', max_length=50, blank=True, null=True)
    article = models.ForeignKey(Article, on_delete=models.CASCADE, related_name="comments", verbose_name='文章')
    author = models.ForeignKey(User, on_delete=models.CASCADE, related_name="comments", verbose_name='评论者')
    create_time = models.DateTimeField('创建时间', auto_now_add=True)
    parent = models.ForeignKey('self', on_delete=models.CASCADE, related_name="replies", null=True, blank=True,
                               verbose_name='父级评论')
    active = models.BooleanField('有效', default=True)

    def __str__(self):
        return f"<{self.author.username}>针对<<{self.article}>>的评论"

    class Meta:
        ordering = ('create_time',)
        verbose_name = '文章评论'
        verbose_name_plural = '文章评论'

    # def get_all_replies(self):
    #     """
    #     获取这个评论的所有子评论，包括子评论的子评论。
    #     """
    #     replies = []
    #
    #     def get_replies(comment):
    #         for reply in comment.replies.all():
    #             replies.append(reply)
    #             get_replies(reply)
    #
    #     get_replies(self)
    #     return replies
