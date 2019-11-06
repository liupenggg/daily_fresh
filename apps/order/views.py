# coding=utf-8
from django.shortcuts import render, redirect
from django.urls import reverse
from django.views.generic import View
from django.http import JsonResponse
from datetime import datetime
from django_redis import get_redis_connection
# mysql数据库的事务操作
from django.db import transaction
# 导入支付宝接口
from alipay import AliPay
# 拼接文件路径
from django.conf import settings
import os
#
from user.models import Address
from goods.models import GoodsSKU
from utils.mixin import LoginRequiredMixin
from order.models import OrderInfo, OrderGoods

# Create your views here.


# /order/place/
class OrderPlaceView(LoginRequiredMixin, View):
    '''提交订单页面显示'''
    def post(self, request):
        '''提交订单页面显示'''
        # 获取登录的用户
        user = request.user
        # 获取参数sku_ids，request.POST.get()针对的是name属性的值
        sku_ids = request.POST.getlist('sku_ids')  # 用getlist是因为一个名字对应多个值

        # 校验参数
        if not sku_ids:
            # 跳转到购物车页面
            return redirect(reverse('cart:show'))

        # 获取用户购物车中商品的信息
        conn = get_redis_connection('default')
        cart_key = 'cart_%d' % user.id

        skus = []
        # 保存用户购物车中商品的总数目和总价格
        total_count = 0
        total_price = 0
        # 遍历sku_ids获取用户要购买的商品的信息
        for sku_id in sku_ids:
            # 根据商品的id获取商品的信息
            sku = GoodsSKU.objects.get(id=sku_id)

            # 通过redis获取用户所要购买的商品的数量->{'商品id':商品数量}
            count = conn.hget(cart_key, sku_id)
            # 计算商品的小计
            amount = sku.price * int(count)
            # 动态给sku对象增加一个属性amount, 保存商品的小计
            sku.amount = amount
            # 动态给sku对象增加一个属性count, 保存购物车中对应商品的数量
            sku.count = int(count)

            # 累计添加
            skus.append(sku)

            # 累加计算商品的总件数和总价格
            total_count += int(count)
            total_price += amount
        # 运费：实际开发的时候，属于一个子系统，专门计算运费的系统，可以灵活的做一个表把它弄出来
        transit_price = 10  # 写死

        # 实付款
        total_pay = total_price + transit_price

        # 获取用户的收件地址
        addrs = Address.objects.filter(user=user)

        # 组织上下文
        sku_ids = ','.join(sku_ids)  # [1,26]->1,25
        context = {'skus': skus,
                   'total_count': total_count,
                   'total_price': total_price,
                   'transit_price': transit_price,
                   'total_pay': total_pay,
                   'addrs': addrs,
                   'sku_ids': sku_ids}

        # 使用模板
        return render(request, 'place_order.html', context)


# /order/commit/
# 悲观锁
# 前端传递的参数:地址id(addr_id) 支付方式(pay_method) 用户要购买的商品id字符串(sku_ids)
# mysql事务：一组sql操作，要么都成功，要么都失败
# 事务概念：一组mysql语句，要么执行，要么全部不执行
# 高并发：秒杀
# 支付宝支付
class OrderCommitView1(View):
    '''订单创建'''
    # atomic对post函数进行一个装饰，里面涉及到的数据库操作他就在一个事务里面，要么都成功，要么都撤销
    @transaction.atomic
    def post(self, request):
        '''订单创建'''
        # 判断用户是否登录
        user = request.user
        if not user.is_authenticated:
            # 用户未登录
            return JsonResponse({'res': 0, 'errmsg': '请先登录'})

        # 接收参数
        addr_id = request.POST.get('addr_id')
        pay_method = request.POST.get('pay_method')
        sku_ids = request.POST.get('sku_ids')

        # 校验参数
        if not all([addr_id, pay_method, sku_ids]):
            # 参数不完整
            return JsonResponse({'res': 1, 'errmsg': '参数不完整'})

        # 校验支付方式
        if pay_method not in OrderInfo.PAY_METHODS.keys():
            # 非法的支付方式
            return JsonResponse({'res': 2, 'errmsg': '非法的支付方式'})

        # 校验地址
        try:
            addr = Address.objects.get(id=addr_id)
        except Address.DoesNotExist:
            return JsonResponse({'res': 3, 'errmsg': '地址非法'})

        # todo:创建订单核心业务

        # 组织参数
        # 订单id：20191028131930+用户id
        order_id = datetime.now().strftime('%Y%m%d%H%M%S')+str(user.id)

        # 运费
        transit_price = 10

        total_count = 0  # 总数目
        total_price = 0  # 总金额

        # 设置事务保存点
        save_id = transaction.savepoint()
        try:
            # todo:向df_order_info表中添加一条记录
            order = OrderInfo.objects.create(order_id=order_id,
                                             user=user,
                                             addr=addr,
                                             pay_method=pay_method,
                                             total_count=total_count,
                                             total_price=total_price,
                                             transit_price=transit_price)

            # todo:用户的订单中有几个商品，需要向df_order_goods表中加入几条记录
            conn = get_redis_connection('default')
            cart_key = 'cart_%d' % user.id

            sku_ids = sku_ids.split(',')
            for sku_id in sku_ids:
                # 获取商品信息
                try:
                    # select * from df_goods_sku where id=sku_id for update;
                    # 实现悲观锁
                    sku = GoodsSKU.objects.select_for_update().get(id=sku_id)
                except:
                    # 商品不存在
                    transaction.savepoint_rollback(save_id)  # 进行事务回滚
                    return JsonResponse({'res': 4, 'errmsg': '商品不存在'})

                # 实现悲观锁
                print('user:%d stock:%d'%(user.id, sku.stock))
                import time
                time.sleep(10)

                # 从redis中获取用户所要购买的商品的数量
                count = conn.hget(cart_key, sku_id)

                # todo: 判断商品的库存
                if int(count) > sku.stock:
                    transaction.savepoint_rollback(save_id)  # 库存不足也要进行一个回滚
                    return JsonResponse({'res': 6, 'errmsg': '商品库存不足'})

                # todo: 向df_order_goods表中添加一条记录
                OrderGoods.objects.create(order=order,
                                          sku=sku,
                                          count=count,
                                          price=sku.price)

                # todo: 更新商品的库存和销量
                sku.stock -= int(count)
                sku.sales += int(count)
                sku.save()

                # todo: 累加计算订单商品的总数量和总价格
                amount = sku.price*int(count)  # 小计
                total_count += int(count)
                total_price += amount

            # todo:更新订单信息表中商品的总数量和总价格
            order.total_count = total_count
            order.total_price = total_price
            order.save()
        except Exception as e:
            transaction.savepoint_rollback(save_id)  # 如果出错就进行回滚
            return JsonResponse({'res': 7, 'errmsg': '下单失败'})

        # 提交事务
        transaction.savepoint_commit(save_id)  # 把从save_id到这一句的所有sql语句对它进行一个提交

        # todo: 清除用户购物车中对应的记录 [1,3]
        conn.hdel(cart_key, *sku_ids)

        return JsonResponse({'res': 5, 'errmsg': '创建成功'})


# /order/commit/
# 实现乐观锁
class OrderCommitView(View):
    '''订单创建'''

    # atomic对post函数进行一个装饰，里面涉及到的数据库操作他就在一个事务里面，要么都成功，要么都撤销
    @transaction.atomic
    def post(self, request):
        '''订单创建'''
        # 判断用户是否登录
        user = request.user
        if not user.is_authenticated:
            # 用户未登录
            return JsonResponse({'res': 0, 'errmsg': '请先登录'})

        # 接收参数
        addr_id = request.POST.get('addr_id')
        pay_method = request.POST.get('pay_method')
        sku_ids = request.POST.get('sku_ids')

        # 校验参数
        if not all([addr_id, pay_method, sku_ids]):
            # 参数不完整
            return JsonResponse({'res': 1, 'errmsg': '参数不完整'})

        # 校验支付方式
        if pay_method not in OrderInfo.PAY_METHODS.keys():
            #
            return JsonResponse({'res': 2, 'errmsg': '非法的支付方式'})

        # 校验地址
        try:
            addr = Address.objects.get(id=addr_id)
        except Address.DoesNotExist:
            return JsonResponse({'res': 3, 'errmsg': '地址非法'})

        # todo:创建订单核心业务

        # 组织参数
        # 订单id：20191028131930+用户id
        order_id = datetime.now().strftime('%Y%m%d%H%M%S') + str(user.id)

        # 运费
        transit_price = 10

        total_count = 0  # 总数目
        total_price = 0  # 总金额

        # 设置事务保存点
        save_id = transaction.savepoint()
        try:
            # todo:向df_order_info表中添加一条记录
            order = OrderInfo.objects.create(order_id=order_id,
                                             user=user,
                                             addr=addr,
                                             pay_method=pay_method,
                                             total_count=total_count,
                                             total_price=total_price,
                                             transit_price=transit_price)

            # todo:用户的订单中有几个商品，需要向df_order_goods表中加入几条记录
            conn = get_redis_connection('default')
            cart_key = 'cart_%d' % user.id

            sku_ids = sku_ids.split(',')
            for sku_id in sku_ids:
                # 尝试三次
                for i in range(3):
                    # 获取商品信息
                    try:
                        # 查的时候正常查，不去加锁，在后面更新的时候判断
                        sku = GoodsSKU.objects.get(id=sku_id)
                    except:
                        # 商品不存在
                        transaction.savepoint_rollback(save_id)  # 进行事务回滚
                        return JsonResponse({'res': 4, 'errmsg': '商品不存在'})

                    # 从redis中获取用户所要购买的商品的数量
                    count = conn.hget(cart_key, sku_id)

                    # todo: 判断商品的库存
                    if int(count) > sku.stock:
                        transaction.savepoint_rollback(save_id)  # 库存不足也要进行一个回滚
                        return JsonResponse({'res': 6, 'errmsg': '商品库存不足'})

                    # todo: 更新商品的库存和销量，实现乐观锁
                    origin_stock = sku.stock  # 原始库存
                    new_stock = origin_stock - int(count)
                    new_sales = sku.sales + int(count)

                    # 实现乐观锁
                    # print('user:%d times:%d stock:%d' % (user.id, i, sku.stock))
                    # import time
                    # time.sleep(10)

                    # update df_goods_sku set stock=new_stock, sales=new_sales where id=sku_id and stock=origin_stock
                    # 返回受影响的行数，乐观锁解决高并发问题(查询的时候不加锁，更新的时候做一个判断)
                    # ********************记得设置mysql事务的隔离级别********************
                    # 设置为Read Committed(读取已经提交的数据)，django2.0连数据库的时候直接把级别改成读已提交
                    res = GoodsSKU.objects.filter(id=sku_id, stock=origin_stock).update(stock=new_stock, sales=new_sales)
                    if res == 0:  # 如果更新数据失败
                        # 如果判断跟之前的信息不一样的话，说明有人把他改掉，就会更新失败
                        # 但是即使更新失败，不代表这个商品的库存他是不足的，所以我们要多去尝试几次
                        # 一般尝试三次，如果还不成功，这种概率是微乎其微的
                        if i == 2:
                            # 当尝试的第三次都没有成功，就让你下单失败
                            transaction.savepoint_rollback(save_id)
                            return JsonResponse({'res': 7, 'errmsg': '下单失败2'})
                        continue

                    # sku.stock -= int(count)
                    # sku.sales += int(count)
                    # sku.save()

                    # todo: 向df_order_goods表中添加一条记录
                    OrderGoods.objects.create(order=order,
                                              sku=sku,
                                              count=count,
                                              price=sku.price)

                    # todo: 累加计算订单商品的总数量和总价格
                    amount = sku.price * int(count)  # 小计
                    total_count += int(count)
                    total_price += amount

                    # 一次就下单成功了，就需要跳出我们的循环
                    break

            # todo:更新订单信息表中商品的总数量和总价格
            order.total_count = total_count
            order.total_price = total_price
            order.save()
        except Exception as e:
            transaction.savepoint_rollback(save_id)  # 如果出错就进行回滚
            return JsonResponse({'res': 7, 'errmsg': '下单失败'})

        # 提交事务
        transaction.savepoint_commit(save_id)  # 把从save_id到这一句的所有sql语句对它进行一个提交

        # todo: 清除用户购物车中对应的记录 [1,3]
        conn.hdel(cart_key, *sku_ids)

        return JsonResponse({'res': 5, 'errmsg': '创建成功'})


# ajax post
# 前端传递的参数：订单id(order_id)
# /order/pay/
class OrderPayView(View):
    '''订单支付'''
    def post(self, request):
        '''订单支付'''
        # 判断用户是否登录
        user = request.user
        if not user.is_authenticated:
            # 用户未登录
            return JsonResponse({'res': 0, 'errmsg': '请先登录'})
        # 接收参数
        order_id = request.POST.get('order_id')

        # 校验参数
        if not order_id:
            return JsonResponse({'res': 1, 'errmsg': '无效的订单id'})

        try:
            # 查询满足以下四个条件的订单信息
            order = OrderInfo.objects.get(order_id=order_id,
                                          user=user,
                                          pay_method=3,
                                          order_status=1)
        except OrderInfo.DoesNotExist:
            return JsonResponse({'res': 2, 'errmsg': '订单错误'})
        # 业务处理：使用python sdk调用支付宝的支付接口
        # 初始化
        alipay = AliPay(
            appid="2016101600703285",  # 应用沙箱id
            app_notify_url=None,  # the default notify path
            app_private_key_path=os.path.join(settings.BASE_DIR, 'apps/order/app_private_key.pem'),
            # alipay public key, do not use your own public key!
            alipay_public_key_path=os.path.join(settings.BASE_DIR, 'apps/order/alipay_public_key.pem'),
            sign_type="RSA2",  # RSA or RSA2
            # 如果是沙箱应该改为True
            debug=True  # False by default，改为True之后是访问沙箱里面的地址
        )
        # 调用支付接口
        # 电脑网站支付
        total_pay = order.total_price+order.transit_price  # Decimal
        #
        order_string = alipay.api_alipay_trade_page_pay(
            out_trade_no=str(order_id),  # 订单 id
            total_amount=str(total_pay),  # 支付总金额
            subject='天天生鲜%s' % order_id,
            return_url=None,
            notify_url=None  # 可以不填
        )

        # 返回应答
        pay_url = 'https://openapi.alipaydev.com/gateway.do?' + order_string
        return JsonResponse({'res': 3, 'pay_url': pay_url})


# ajax post
# 前端传递的参数：订单id(order_id)
# /order/check/
class OrderCheckView(View):
    '''检查订单是否支付成功'''
    def post(self, request):
        '''查看订单支付的结果'''
        # 判断用户是否登录
        user = request.user
        if not user.is_authenticated:
            # 用户未登录
            return JsonResponse({'res': 0, 'errmsg': '请先登录'})
        # 接收参数
        order_id = request.POST.get('order_id')

        # 校验参数
        if not order_id:
            return JsonResponse({'res': 1, 'errmsg': '无效的订单id'})

        try:
            # 查询满足以下四个条件的订单信息
            order = OrderInfo.objects.get(order_id=order_id,
                                          user=user,
                                          pay_method=3,
                                          order_status=1)
        except OrderInfo.DoesNotExist:
            return JsonResponse({'res': 2, 'errmsg': '订单错误'})
        # 业务处理：使用python sdk调用支付宝的支付接口
        # 初始化
        alipay = AliPay(
            appid="2016101600703285",  # 应用沙箱id
            app_notify_url=None,  # the default notify path
            app_private_key_path=os.path.join(settings.BASE_DIR, 'apps/order/app_private_key.pem'),
            # alipay public key, do not use your own public key!
            alipay_public_key_path=os.path.join(settings.BASE_DIR, 'apps/order/alipay_public_key.pem'),
            sign_type="RSA2",  # RSA or RSA2
            # 如果是沙箱应该改为True
            debug=True  # False by default，改为True之后是访问沙箱里面的地址
        )

        # 调用支付宝的交易查询接口  out_trade_no=订单id，trade_no=支付宝的交易号
        while True:

            # 调用alipay工具查询支付结果
            response = alipay.api_alipay_trade_query(order_id)

            # 判断支付结果
            code = response.get('code')  # 支付宝接口调用成功或者错误的标志
            trade_status = response.get("trade_status")  # 用户支付的情况

            # 调用查询接成功口和商品交易成功
            if code == '10000' and trade_status == "TRADE_SUCCESS":
                # 支付成功
                # 获取支付宝交易号
                trade_no = response.get('trade_no')
                # 更新订单状态
                order.trade_no = trade_no
                order.order_status = 4  # 改成待评价状态
                order.save()
                # 返回结果
                return JsonResponse({'res': 3, 'message': '支付成功'})
            # 调用查询接口成功，但是等待买家去付款，并不代表用户支付没有成功，还需要等待一段时间
            elif code == "40004" or (code == "10000" and trade_status == "WAIT_BUYER_PAY"):
                # 等待买家付款
                import time
                time.sleep(5)  # 休眠5秒，把查询的地方放入一个循环，过5秒之后再调用一次，用户就可能支付成功了
                continue
            else:
                # 支付出错
                return JsonResponse({'res': 4, 'errmsg': '支付失败'})


#
#
class OrderCommentView(LoginRequiredMixin, View):
    """订单评论"""
    def get(self, request, order_id):
        """提供评论页面"""
        user = request.user

        # 校验数据
        # 接收到订单id，进行订单id的一个校验
        if not order_id:
            return redirect(reverse('user:order'))

        try:
            order = OrderInfo.objects.get(order_id=order_id, user=user)
        except OrderInfo.DoesNotExist:
            return redirect(reverse("user:order"))

        # 根据订单的状态获取订单的状态标题
        order.status_name = OrderInfo.ORDER_STATUS[order.order_status]

        # 获取订单商品信息
        order_skus = OrderGoods.objects.filter(order_id=order_id)
        for order_sku in order_skus:
            # 计算商品的小计
            amount = order_sku.count*order_sku.price
            # 动态给order_sku增加属性amount,保存商品小计
            order_sku.amount = amount
        # 动态给order增加属性order_skus, 保存订单商品信息
        order.order_skus = order_skus

        # 使用模板
        return render(request, "order_comment.html", {"order": order})

    def post(self, request, order_id):
        """处理评论内容"""
        user = request.user
        # 校验数据
        if not order_id:
            return redirect(reverse('user:order'))

        try:
            order = OrderInfo.objects.get(order_id=order_id, user=user)
        except OrderInfo.DoesNotExist:
            return redirect(reverse("user:order"))

        # 获取评论条数，有几个商品就应该有几个评论
        total_count = request.POST.get("total_count")  # 从html的隐藏域中获取
        total_count = int(total_count)

        # 循环获取订单中商品的评论内容
        for i in range(1, total_count + 1):
            # 获取评论的商品的id，通过html里面的name属性获取值
            sku_id = request.POST.get("sku_%d" % i)  # sku_1 sku_2
            # 获取评论的商品的内容
            content = request.POST.get('content_%d' % i, '')  # cotent_1 content_2 content_3
            try:
                order_goods = OrderGoods.objects.get(order=order, sku_id=sku_id)
            except OrderGoods.DoesNotExist:
                continue  # 继续看下一个商品

            # 如果没有问题，就要把order_goods里面的评论给它改成我们接收到的评论，去做一个保存
            order_goods.comment = content
            order_goods.save()

        order.order_status = 5  # 已完成
        order.save()

        return redirect(reverse("user:order", kwargs={"index": 1}))

