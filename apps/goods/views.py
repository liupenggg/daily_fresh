# coding=utf-8
from django.shortcuts import render, redirect
# 反向解析
from django.urls import reverse
# 类视图
from django.views.generic import View
# 导入缓存
from django.core.cache import cache
# 导入分页器
from django.core.paginator import Paginator
#
from goods.models import GoodsType, GoodsSKU, IndexGoodsBanner, IndexPromotionBanner, IndexTypeGoodsBanner
from django_redis import get_redis_connection
from order.models import OrderGoods
# Create your views here.


# 首页 http://127.0.0.1:8000/index
class IndexView(View):
    '''首页'''
    def get(self, request):
        '''显示首页'''
        # 首先尝试从缓存中获取数据
        # 把页面使用的数据存放在缓存中，当再次使用这些数据时，先从缓存中获取，
        # 如果获取不到，再去查询数据库。减少数据库查询的次数。
        context = cache.get('index_page_data')  # 如果拿不到数据就返回一个None
        if context is None:
            print('设置缓存')
            # 缓存中没有数据，就需要从数据库中查询

            # 获取商品的种类信息
            types = GoodsType.objects.all()

            # 获取首页轮播商品信息
            goods_banners = IndexGoodsBanner.objects.all().order_by('index')

            # 获取首页促销活动信息
            promotion_banners = IndexPromotionBanner.objects.all().order_by('index')

            # 获取首页分类商品展示信息
            for type in types:  # GoodsType
                # 获取type种类首页分类商品的图片展示信息，比如：猪牛羊肉里面的猪肉、牛肉是进行图片展示还是文字展示
                image_banners = IndexTypeGoodsBanner.objects.filter(type=type, display_type=1).order_by('index')
                # 获取type种类首页分类商品的文字展示信息
                title_banners = IndexTypeGoodsBanner.objects.filter(type=type, display_type=0).order_by('index')

                # 动态给type增加属性，分别保存首页分类商品的图片展示信息和文字展示信息
                type.image_banners = image_banners  # 首页分类商品的图片展示信息
                type.title_banners = title_banners  # 首页分类商品的文字展示信息

            context = {'types': types,
                       'goods_banners': goods_banners,
                       'promotion_banners': promotion_banners}
            # 上面获取的数据对于每个用户都是一样的，所以需要设置缓存
            # 设置缓存
            # 第一个参数是缓存数据的名称key，第二个参数是value，第三个参数是过期时间timeout
            cache.set('index_page_data', context, 3600)

        # 获取用户购物车中商品的数目
        user = request.user
        cart_count = 0
        if user.is_authenticated:
            # 用户已登录
            conn = get_redis_connection('default')
            cart_key = 'cart_%d' % user.id
            cart_count = conn.hlen(cart_key)

        # 组织模板上下文
        # 如果cart_count不存在，就代表一个添加，如果存在就代表更新
        context.update(cart_count=cart_count)

        # 使用模板
        return render(request, 'index.html', context)


# /goods/商品id
class DetailView(View):
    '''详情页'''
    def get(self, request, goods_id):
        '''显示详情页'''
        try:
            sku = GoodsSKU.objects.get(id=goods_id)
        except GoodsSKU.DoesNotExist:
            # 商品不存在
            return redirect(reverse('goods:index'))

        # 获取商品的分类信息
        types = GoodsType.objects.all()

        # 获取商品的评论信息，是从订单类里面去查
        sku_orders = OrderGoods.objects.filter(sku=sku).exclude(comment='')  # exclude返回不满足条件的数据，评论为空的就不要了

        # 获取新品信息，默认是按升序排列
        new_skus = GoodsSKU.objects.filter(type=sku.type).order_by('-create_time')[:2]

        # 获取同一个SPU的其他规格商品,并排除当前商品的id
        same_spu_skus = GoodsSKU.objects.filter(goods=sku.goods).exclude(id=goods_id)

        # 获取用户购物车中商品的数目
        user = request.user
        cart_count = 0
        if user.is_authenticated:
            # 用户已登录
            conn = get_redis_connection('default')
            cart_key = 'cart_%d' % user.id
            cart_count = conn.hlen(cart_key)

            # 添加用户的历史浏览记录
            conn = get_redis_connection('default')
            history_key = 'history_%d' % user.id
            # 移除列表中的goods_id,0代表移除所有goods_id
            conn.lrem(history_key, 0, goods_id)
            # 把goods_id插入到列表左侧
            conn.lpush(history_key, goods_id)
            # 只保存用户最新浏览的五条记录
            conn.ltrim(history_key, 0, 4)

        # 组织模板上下文
        context = {'sku': sku,
                   'types': types,
                   'sku_orders': sku_orders,  # 商品评论
                   'new_skus': new_skus,  # 新品信息
                   'same_spu_skus': same_spu_skus,  # 相似商品信息
                   'cart_count': cart_count}
        return render(request, 'detail.html', context)


# 种类id 页码 排序方式
#
# /list?type_id=种类_id&page=页码&sort=排序方式
# /list/种类id/页码/排序方式
# /list/种类id/页码？sort=排序方式  # 使用这种url地址，？后面的参数不参与url匹配的过程
class ListView(View):
    '''列表页'''
    def get(self, request, type_id, page_index):
        '''列表页显示'''
        # 获取该商品的种类信息
        try:
            type = GoodsType.objects.get(id=type_id)
        except GoodsType.DoesNoExist:
            # 说明商品种类不存在，跳转到首页
            return redirect(reverse('goods:index'))

        # 获取所有商品的分类信息
        types = GoodsType.objects.all()

        # 获取排序方式
        # sort=default 按照默认id排序
        # sort=price 按照商品价格排序
        # sort=hot 按照商品销量排序
        sort = request.GET.get('sort')

        if sort == 'price':  # 按照价格从高到低
            skus = GoodsSKU.objects.filter(type=type).order_by('-price')
        elif sort == 'hot':  # 按照销量从高到低
            skus = GoodsSKU.objects.filter(type=type).order_by('-sales')
        else:
            # 默认最新
            sort = 'default'
            skus = GoodsSKU.objects.filter(type=type).order_by('-id')

        # 对数据进行分页
        # 创建Paginator一个分页对象，每页显示10条数据
        paginator = Paginator(skus, 1)
        # 获取第page页的内容
        # 对页码做容错处理
        try:
            page = int(page_index)
        except Exception as e:
            page = 1

        # 如果传过来的页数大于总页数，也给你显示第1页
        if page > paginator.num_pages:
            page = 1

        # 获取第page页的Page实例对象，包含商品信息
        skus_page = paginator.page(page)

        # todo：进行页码的控制，页面上最多显示5个页码
        # 1.总页数小于5页，页面上显示所有页码
        # 2.如果当前页是前3页，显示1-5页
        # 3.如果当前页是后3页，显示后5页
        # 4.其他情况，显示当前页的前2页，当前页，当前页的后2页

        num_pages = paginator.num_pages
        # 如果总页数小于5页
        pages = []
        if num_pages < 5:
            pages = range(1, num_pages+1)
        elif page < 3:
            pages = range(1, 6)  # 产生1-5之间的列表
        elif num_pages-page <= 2:  # 只要你的总页码-当前页<=2的话，就属于后3三页
            pages = range(num_pages-4, num_pages+1)
        else:
            pages = range(page-2, page+3)  # []

        # 获取新品信息，默认是按升序排列
        new_skus = GoodsSKU.objects.filter(type=type).order_by('-create_time')[:2]

        # 获取用户购物车中商品的数目
        user = request.user
        cart_count = 0
        if user.is_authenticated:
            # 用户已登录
            conn = get_redis_connection('default')
            cart_key = 'cart_%d' % user.id
            cart_count = conn.hlen(cart_key)

        # 组织模板上下文
        context = {'types': types,
                   'type': type,  #
                   'skus_page': skus_page,  #
                   'new_skus': new_skus,  # 新品信息
                   'cart_count': cart_count,  # 购物车数目
                   'pages': pages,
                   'sort': sort}

        # 使用模板
        return render(request, 'list.html', context)