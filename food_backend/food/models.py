import os
import uuid
from django.contrib.auth.models import User
from django.db import models
from django.db.models import Avg
from django.urls import reverse
from uuslug import uuslug


def food_upload_to(instance, filename=None):
    ext = os.path.splitext(filename)[1]
    new_filename = f'{uuid.uuid4().hex}{ext}'
    return f'food/file/{new_filename}'


class Food(models.Model):
    """食品信息"""
    name = models.CharField('食品名称', max_length=50)
    slug = models.SlugField('地址缩写', max_length=120, unique=True, null=True, blank=True)
    img = models.ImageField('食品图片', upload_to=food_upload_to, null=True)
    desc = models.TextField('食品描述', blank=True, null=True)
    shelf_life = models.CharField('保质期', null=True, blank=True, max_length=20)
    storage_conditions = models.TextField('存储条件', null=True, blank=True)
    order = models.IntegerField('排序', default=0)
    liked_by = models.ManyToManyField(to=User, related_name='liked_foods', blank=True)
    create_time = models.DateTimeField('创建时间', auto_now_add=True)
    update_time = models.DateTimeField('更新时间', auto_now=True)
    category = models.ForeignKey('Category', on_delete=models.CASCADE, related_name='foods', verbose_name='分类',
                                 null=True, blank=True)
    manufacturer = models.ForeignKey('Manufacturer', on_delete=models.CASCADE, related_name='foods',
                                     verbose_name='所属厂商', null=True, blank=True)
    nutrition = models.OneToOneField('Nutrition', on_delete=models.CASCADE, related_name='foods', null=True, blank=True,
                                     verbose_name='食物营养信息')

    def __str__(self):
        return self.name

    def get_detail_url(self):
        """获取当前食品的详情地址"""
        return reverse('food:detail', args=[self.slug, ])

    def save(self, *args, **kwargs):
        """保存时存储slug"""
        if not self.slug:
            self.slug = uuslug(self.name, instance=self)
        super(Food, self).save(*args, **kwargs)

    def get_average_rating(self):
        """获取食品的平均评分"""
        reviews = self.review.all()
        if reviews:
            average = reviews.aggregate(Avg('rating'))['rating__avg']
            return average if average else None
        return None

    def get_latest_price_info(self):
        """最新时间食品价格"""
        latest_price = self.prices.order_by('-create_time').first()
        if latest_price:
            return {'price': latest_price.price, 'discount': latest_price.discount}
        return {'price': None, 'discount': None}

    class Meta:
        ordering = ('-order', '-create_time',)
        verbose_name = '食品信息'
        verbose_name_plural = '食品信息'


class Category(models.Model):
    """食品分类"""

    name = models.CharField('分类名称', max_length=50)
    slug = models.SlugField('地址缩写', max_length=120, unique=True, null=True, blank=True)
    desc = models.TextField('分类描述', blank=True, null=True)
    order = models.IntegerField('排序', default=0)
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
        verbose_name = '食品分类'
        verbose_name_plural = '食品分类'


class Nutrition(models.Model):
    """食品营养信息"""
    name = models.CharField('食品名称', null=True, blank=True, unique=True, max_length=50)
    ingredient_name = models.TextField('食品原料', null=True, blank=True)
    calories = models.FloatField('卡路里', null=True, blank=True)
    protein = models.FloatField('蛋白质', null=True, blank=True)
    fat = models.FloatField('脂肪', null=True, blank=True)
    carbohydrates = models.FloatField('碳水化合物', null=True, blank=True)
    fiber = models.FloatField('纤维素', null=True, blank=True)
    update_time = models.DateTimeField('更新时间', auto_now=True)

    def __str__(self):
        return f"{self.name}的营养信息"

    class Meta:
        ordering = ('id', 'update_time')
        verbose_name = '食品营养'
        verbose_name_plural = '食品营养'


class Review(models.Model):
    """食品评价"""

    food = models.ForeignKey(Food, on_delete=models.CASCADE, related_name='review', null=True, blank=False,
                             verbose_name='食物名称')
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='review', null=True, blank=False,
                             verbose_name='评论作者')
    rating = models.FloatField('评分', null=True, blank=False)
    body = models.TextField('评价', null=True, blank=False)
    create_time = models.DateTimeField('更新时间', auto_now=True)

    def __str__(self):
        return f"<{self.user.username}>针对<<{self.food.name}>>的评论"

    def star_ratings(self):
        """返回每条评价的星级表示。"""
        full_stars = round(self.rating) if self.rating else 0
        empty_stars = 5 - full_stars
        return {'full_stars': full_stars, 'empty_stars': empty_stars}

    class Meta:
        ordering = ('-create_time', 'id')
        verbose_name = '食品评价'
        verbose_name_plural = '食品评价'


class Price(models.Model):
    """食品价格"""
    food = models.ForeignKey(Food, on_delete=models.CASCADE, related_name='prices', null=True,
                             blank=True, verbose_name="食物名称")
    price = models.FloatField('原价', null=True, blank=True)
    discount = models.FloatField('折扣价', null=True, blank=True)
    create_time = models.DateField('日期')

    class Meta:
        ordering = ('id', 'create_time')
        verbose_name = '食品价格'
        verbose_name_plural = '食品价格'

    def __str__(self):
        return f"<{self.food.name}><{self.create_time}>的价格"


class Manufacturer(models.Model):
    """食品厂商信息"""
    name = models.CharField('厂商名称', max_length=255, null=True, blank=True)
    desc = models.TextField('厂商描述', null=True, blank=True)
    website = models.URLField('官方网站', null=True, blank=True)
    address = models.CharField('厂商地址', max_length=255, null=True, blank=True)
    phone = models.CharField('联系电话', max_length=20, null=True, blank=True)
    email = models.EmailField('电子邮箱', null=True, blank=True)

    def __str__(self):
        return self.name

    class Meta:
        ordering = ('id',)
        verbose_name = '食品厂商'
        verbose_name_plural = '食品厂商'
