# coding=utf-8
from django.shortcuts import render, redirect
from django.urls import reverse
from django.http import HttpResponse
# 类视图
from django.views.generic import View
# 生成激活用户
from django.conf import settings  # 导入SECRET_KEY = '-^n&&#mr+t%&p6)f*d8y!0#e)7z&y!h-tt0q^b7ww#=gv+2ctr'
from celery_tasks.tasks import send_register_active_email  # 发送邮件功能
from itsdangerous import TimedJSONWebSignatureSerializer as Serializer  # 获取密钥
from itsdangerous import SignatureExpired  # 签名过期
# 登录认证,保存session信息
from django.contrib.auth import authenticate, login, logout
from utils.mixin import LoginRequiredMixin
# 分页
from django.core.paginator import Paginator
#
from django_redis import get_redis_connection
import re
from user.models import User, Address
from goods.models import GoodsSKU
# 导入订单类
from order.models import OrderInfo, OrderGoods
# Create your views here.


# /user/register/  打开注册页面和进行注册处理使用同一个函数
def register(request):
    '''注册'''
    if request.method == 'GET':
        # 显示注册页面
        return render(request, 'register.html')
    else:
        # 进行注册处理
        # 接收数据
        username = request.POST.get('user_name')
        password = request.POST.get('pwd')
        email = request.POST.get('email')
        allow = request.POST.get('allow')

        # 进行数据校验
        if not all([username, password, email]):
            # 数据不完整
            return render(request, 'register.html', {'errmsg': '数据不完整'})

        # 校验邮箱
        if not re.match(r'^[a-z0-9][\w.\-]*@[a-z0-9\-]+(\.[a-z]{2,5}){1,2}$', email):
            return render(request, 'register.html', {'errmsg': '邮箱格式不正确'})

        if allow != 'on':
            return render(request, 'register.html', {'errmsg': '请同意协议'})

        # 校验用户名是否重复
        try:
            user = User.objects.get(username=username)
        except User.DoesNotExist:
            # 用户名不存在
            user = None

        if user:
            # 用户名已存在
            return render(request, 'register.html', {'errmsg': '用户名已存在'})

        # 进行业务处理: 进行用户注册
        user = User.objects.create_user(username, email, password)
        user.is_active = 0
        user.save()

        # 返回应答, 跳转到首页
        return redirect(reverse('goods:index'))


# /user/register_handle/
def register_handle(request):
    '''进行注册处理'''
    # 接收数据
    username = request.POST.get('user_name')
    password = request.POST.get('pwd')
    email = request.POST.get('email')
    allow = request.POST.get('allow')

    # 进行数据校验
    if not all([username, password, email]):
        # 数据不完整
        return render(request, 'register.html', {'errmsg': '数据不完整'})

    # 校验邮箱
    if not re.match(r'^[a-z0-9][\w.\-]*@[a-z0-9\-]+(\.[a-z]{2,5}){1,2}$', email):
        return render(request, 'register.html', {'errmsg': '邮箱格式不正确'})

    if allow != 'on':
        return render(request, 'register.html', {'errmsg': '请同意协议'})

    # 校验用户名是否重复
    try:
        # 从数据库里面查询是否存在重复的用户名
        user = User.objects.get(username=username)
    except User.DoesNotExist:
        # 用户名不存在
        user = None

    if user:
        # 用户名已存在
        return render(request, 'register.html', {'errmsg': '用户名已存在'})

    # 进行业务处理: 进行用户注册
    user = User.objects.create_user(username, email, password)
    user.is_active = 0
    user.save()

    # 返回应答, 跳转到首页'goods:index'
    return redirect(reverse('goods:index'))


# /user/register 类视图使用
# GET POST
class RegisterView(View):
    '''注册'''
    def get(self, request):
        '''显示注册页面'''
        return render(request, 'register.html')

    def post(self, request):
        '''进行注册处理'''
        # 接收数据
        username = request.POST.get('user_name')
        password = request.POST.get('pwd')
        email = request.POST.get('email')
        allow = request.POST.get('allow')

        # 进行数据校验
        if not all([username, password, email]):
            # 数据不完整
            return render(request, 'register.html', {'errmsg': '数据不完整'})

        # 校验邮箱
        if not re.match(r'^[a-z0-9][\w.\-]*@[a-z0-9\-]+(\.[a-z]{2,5}){1,2}$', email):
            return render(request, 'register.html', {'errmsg': '邮箱格式不正确'})

        if allow != 'on':
            return render(request, 'register.html', {'errmsg': '请同意协议'})

        # 校验用户名是否重复
        try:
            user = User.objects.get(username=username)
        except User.DoesNotExist:
            # 用户名不存在
            user = None

        if user:
            # 用户名已存在
            return render(request, 'register.html', {'errmsg': '用户名已存在'})

        # 进行业务处理: 进行用户注册
        user = User.objects.create_user(username, email, password)
        user.is_active = 0
        user.save()

        # 发送激活邮件，包含激活链接: http://127.0.0.1/user/active/3
        # 激活链接中需要包含用户的身份信息, 并且要把身份信息进行加密

        # 加密用户的身份信息，生成激活token，3600代表加密过期时间，3600秒=一小时过期
        serializer = Serializer(settings.SECRET_KEY, 3600)
        info = {'confirm': user.id}
        token = serializer.dumps(info)  # dumps代表加密 #byte类型
        token = token.decode()  # 默认转成utf8

        # 发邮件 -- 使用celery异步发送，delay就代表发出
        send_register_active_email.delay(email, username, token)

        # 返回应答, 跳转到首页
        return redirect(reverse('goods:index'))


# /user/active/*
class ActiveView(View):
    '''用户激活'''
    def get(self, request, token):
        '''进行用户激活'''
        # 进行解密，获取要激活的用户信息
        serializer = Serializer(settings.SECRET_KEY, 3600)
        try:
            info = serializer.loads(token)
            # 获取待激活用户的id
            user_id = info['confirm']

            # 根据id获取用户信息
            user = User.objects.get(id=user_id)
            user.is_active = 1
            user.save()

            # 跳转到登录页面
            return redirect(reverse('user:login'))
        except SignatureExpired as e:
            # 激活链接已过期
            return HttpResponse('激活链接已过期')


# /user/login/
class LoginView(View):
    '''登录'''
    def get(self,request):
        '''显示登录页面'''
        # 判断是否记住了用户名
        if 'username' in request.COOKIES:
            username = request.COOKIES.get('username')
            checked = 'checked'
        else:
            username = ''
            checked = ''
        # 使用模板
        return render(request, 'login.html', {'username': username, 'checked': checked})

    def post(self, request):
        '''登录校验'''
        # 接收数据
        username = request.POST.get('username')
        password = request.POST.get('pwd')

        # 首先校验数据合法性
        # 检验用户名和密码是否都传了
        if not all([username, password]):
            return render(request, 'login.html', {'errmsg': '数据不完整'})
        # 业务处理：登录校验
        # 使用django自带的登录认证
        user = authenticate(username=username, password=password)
        if user is not None:
            # 用户名、密码正确
            if user.is_active:
                # 用户已激活
                # 记录用户的登录状态，如果你有一个认证了的用户，你想把它附带到当前的会话中，这可以通过login()函数完成
                # 这里的session存储会自动触发redis数据库进行存储
                login(request, user)  # 相当于request.session['user_name'] = uname
                # 获取登录后所要跳转到的地址
                # 默认跳转到首页 LOGIN_URL = '/user/login/'  # /accounts/login?next=/user
                # http://127.0.0.1:8000/user/login/?next=/user/
                next_url = request.GET.get('next', reverse('goods:index'))

                # 跳转到next_url
                response = redirect(next_url)  # HttpResponseRedirect

                # 判断是否需要记住用户名
                remember = request.POST.get('remember')

                if remember == 'on':
                    # 说明需要记住用户名，就把用户名存储到COOKIE中
                    response.set_cookie('username', username, max_age=7*24*3600)
                else:
                    # 删除记住的用户名
                    response.delete_cookie('username')
                # 返回response
                return response
            else:
                # 用户未激活
                return render(request, 'login.html', {'errmsg': '账户未激活'})
        else:
            # 用户名或密码错误
            return render(request, 'login.html', {'errmsg': '用户名或密码错误'})


# user/logout
class LogoutView(View):
    '''退出登录'''
    def get(self,request):
        '''退出登录'''
        # 清除用户的session信息
        logout(request)

        # 跳转到首页
        return redirect(reverse('goods:index'))


# /user/
class UserInfoView(LoginRequiredMixin, View):
    '''用户中心信息页'''
    def get(self, request):
        '''显示'''
        # page='user'
        # 一个请求过来以后，django框架本身会给request对象增加一个user属性
        # request.user
        # 如果用户未登录->AnonymousUser类的一个实例->返回False
        # 如果用户登录->User类的一个实例->返回True
        # request.user.is_authenticated()

        # 获取用户的个人信息
        user = request.user
        address = Address.objects.get_default_address(user)

        # 获取用户的历史浏览记录
        # from redis import StrictRedis
        # sr = StrictRedis(host='127.0.0.1', port=6379, db=1)
        con = get_redis_connection('default')  # 拿到连接到redis数据库的一个链接

        history_key = 'history_%d' % user.id  # 拼接出一个对应的浏览历史记录的key

        # 使用con传入一个key获取用户最新浏览的5个商品的id，作为列表给你返回
        sku_ids = con.lrange(history_key, 0, 4)  # [2,3,1]

        # 从数据库中查询用户浏览的商品具体信息
        # 遍历获取用户浏览的商品信息
        goods_li = []
        for id in sku_ids:
            goods = GoodsSKU.objects.get(id=id)
            goods_li.append(goods)

        # 组织上下文
        context = {'page': 'user',
                   'address': address,
                   'goods_li': goods_li}

        # 除了你给模板文件传递给的模板变量之外，django框架会把request.user也会传给模板文件
        return render(request, 'user_center_info.html', context)


# /user/order/
class UserOrderView(LoginRequiredMixin, View):
    def get(self, request, index):
        '''用户中心订单页'''
        # page='order'
        # 获取用户的订单信息
        user = request.user
        # 查询用户的所有订单
        orders = OrderInfo.objects.filter(user=user).order_by('-create_time')

        # 需要遍历orders，去查询每个订单里的商品信息
        for order in orders:
            # 根据order_id查询订单商品信息
            order_skus = OrderGoods.objects.filter(order_id=order.order_id)
            # 遍历order_skus计算商品的小计
            for order_sku in order_skus:
                # 计算小计
                amount = order_sku.count*order_sku.price
                # 动态给order_sku增加属性amount,保存订单商品的小计
                order_sku.amount = amount

            # 动态给order增加属性，保存订单状态标题
            order.status_name = OrderInfo.ORDER_STATUS[order.order_status]  # 根据对应的数字取出对应的状态
            # 动态给order增加属性，保存订单商品的信息
            order.order_skus = order_skus

        # 分页,对orders进行分页
        paginator = Paginator(orders, 2)

        # 对页码做容错处理
        try:
            page = int(index)
        except Exception as e:
            page = 1

        # 如果传过来的页数大于总页数，也给你显示第1页
        if page > paginator.num_pages:
            page = 1

        # 获取第page页的Page实例对象，包含商品信息
        order_page = paginator.page(page)

        # todo：进行页码的控制，页面上最多显示5个页码
        # 1.总页数小于5页，页面上显示所有页码
        # 2.如果当前页是前3页，显示1-5页
        # 3.如果当前页是后3页，显示后5页
        # 4.其他情况，显示当前页的前2页，当前页，当前页的后2页

        num_pages = paginator.num_pages
        # 如果总页数小于5页
        pages = []
        # 如果总页数小于5页
        if num_pages < 5:
            pages = range(1, num_pages + 1)
        # 如果当前页属于前3页
        elif page < 3:
            pages = range(1, 6)  # 产生1-5之间的列表
        # 如果当前页属于后3页
        elif num_pages - page <= 2:  # 只要你的总页码-当前页<=2的话，就属于后3三页
            pages = range(num_pages - 4, num_pages + 1)
        # 如果当前页既不属于前3页，也不属于后3页，就用下面这种情况
        else:
            pages = range(page - 2, page + 3)  # []

        # 组织上下文

        context = {'order_page': order_page,
                   'pages': pages,
                   # 显示用户中心的哪一个页面
                   'page': 'order'}

        # 使用模板
        return render(request, 'user_center_order.html', context)


# /user/address/
class AddressView(LoginRequiredMixin, View):
    def get(self, request):
        '''用户中心地址页'''
        # page='address'
        # 获取登录用户对应的User对象
        user = request.user
        # 获取用户的默认收获地址
        # try:
        #     address = Address.objects.get(user=user, is_default=True)
        # except Address.DoesNotExist:
        #     # 不存在默认收获地址
        #     address = None

        # 使用地址模型管理器类来获取用户地址
        address = Address.objects.get_default_address(user)
        # 使用模板
        return render(request, 'user_center_site.html', {'page': 'address', 'address': address})

    def post(self, request):
        '''地址的添加'''
        # 接收数据
        receiver = request.POST.get('receiver')
        addr = request.POST.get('addr')
        zip_code = request.POST.get('zip_code')
        phone = request.POST.get('phone')
        # 校验数据
        if not all([receiver, addr, phone]):
            return render(request, 'user_center_site.html', {'errmsg': '数据不完整'})
        # 校验手机号
        if not re.match(r'^1[3|4|5|7|8][0-9]{9}$', phone):
            return render(request, 'user_center_site.html', {'errmsg': '手机格式不正确'})

        # 业务处理
        # 如果用户已存在默认收货地址，添加的地址不作为默认收货地址，否则作为默认收货地址
        # 要查询一个用户的默认收货地址，就要获取当前登录的用户
        user = request.user
        # try:
        #     address = Address.objects.get(user=user, is_default=True)
        # except Address.DoesNotExist:
        #     # 不存在默认收获地址
        #     address = None
        address = Address.objects.get_default_address(user)

        if address:
            # 说明用户已经有了默认收货地址
            is_default = False
        else:
            is_default = True

        # 业务处理：地址添加
        Address.objects.create(user=user,
                               receiver=receiver,
                               addr=addr, zip_code=zip_code, phone=phone, is_default=is_default)

        # 返回应答,刷新地址页面 # 再以get请求方式访问用户中心-地址页
        return redirect(reverse('user:address'))
