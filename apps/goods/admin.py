# coding=utf-8
from django.contrib import admin
from django.core.cache import cache
from goods.models import GoodsType, GoodsSKU, Goods, GoodsImage, IndexPromotionBanner, IndexGoodsBanner, IndexTypeGoodsBanner

# Register your models here.


# 只要管理员通过后台修改首页信息对应的表格中的数据的时候,就需要使用此类重新生成首页静态页，并更新首页的缓存数据
class BaseModelAdmin(admin.ModelAdmin):
    def save_model(self, request, obj, form, change):
        '''新增或更新表中的数据时调用'''
        super().save_model(request, obj, form, change)

        # 发出任务，让celery worker重新生成首页静态页
        from celery_tasks.tasks import generate_static_index_html
        generate_static_index_html.delay()

        # 清除首页的缓存数据
        cache.delete('index_page_data')

    def delete_model(self, request, obj):
        '''删除表中的数据时调用'''
        super().delete_model(request, obj)
        # 发出任务，让celery worker重新生成首页静态页
        from celery_tasks.tasks import generate_static_index_html
        generate_static_index_html.delay()

        # 清除首页的缓存数据
        cache.delete('index_page_data')

class GoodsTypeAdmin(BaseModelAdmin):
    pass

class IndexGoodsBannerAdmin(BaseModelAdmin):
    pass

class IndexTypeGoodsBannerAdmin(BaseModelAdmin):
    pass

class IndexPromotionBannerAdmin(BaseModelAdmin):
    pass


admin.site.register(GoodsType, GoodsTypeAdmin)  # '商品种类'
#
admin.site.register(GoodsSKU)  # '商品'
admin.site.register(Goods)  # '商品SPU'
admin.site.register(GoodsImage)  # '商品图片'

# 什么时候首页的静态页面需要重新生成？
#       当管理员通过后台修改首页信息对应的表格中的数据的时候,需要重新生成首页静态页
# 在后台修改IndexPromotionBanner表中数据的时候，就会去调用save_model方法
# 当修改save_model的时候，需要重新通过celery生成index.html，所以需要重写save_model方法
admin.site.register(IndexGoodsBanner, IndexGoodsBannerAdmin)  # '首页轮播商品'

admin.site.register(IndexTypeGoodsBanner, IndexTypeGoodsBannerAdmin)  # "主页分类展示商品"

admin.site.register(IndexPromotionBanner, IndexPromotionBannerAdmin)  # "主页促销活动"



