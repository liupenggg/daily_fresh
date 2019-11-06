# coding=utf-8
# 使用celery
from django.core.mail import send_mail
from django.conf import settings
from django.template import loader, RequestContext
from celery import Celery
import time

# 在任务处理者一端加这几句(Django 环境初始化)，任务处理者一般在Ubuntu环境
# 如果worker在另外一台机器是不需要加下面四句话的，处理者所在电脑必须有网
import os
import django
os.environ.setdefault("DJANGO_SETTINGS_MODULE", "daily_fresh.settings")
django.setup()  # django初始化

# 这几个类的导入要放在Django 环境初始化的下方，要不然你运行celery会找不到
from goods.models import GoodsType, GoodsSKU, IndexGoodsBanner, IndexPromotionBanner, IndexTypeGoodsBanner

# from django_redis import get_redis_connection

# 创建一个Celery类的实例对象，broker代表中间人，2代表要使用redis里面的2号数据库
app = Celery('celery_tasks.tasks', broker='redis://127.0.0.1:6379/2')

# 定义发邮件的任务函数，to_email:你要发给谁，username:用户名，token:激活链接里面的token信息
@app.task
def send_register_active_email(to_email, username, token):
    '''发送激活邮件'''
    # 组织邮件信息
    subject = '天天生鲜欢迎信息'
    message = ''
    sender = settings.EMAIL_FROM
    receiver = [to_email]
    html_message = '<h1>%s, 欢迎您成为天天生鲜注册会员</h1>请点击下面链接激活您的账户<br/><a href="http://127.0.0.1:80/user/active/%s">http://127.0.0.1:80/user/active/%s</a>' % (username, token, token)

    send_mail(subject, message, sender, receiver, html_message=html_message)
    time.sleep(5)


@app.task
def generate_static_index_html():
    '''产生首页静态页面'''
    # 获取商品的种类信息
    types = GoodsType.objects.all()

    # 获取首页轮播商品信息
    goods_banners = IndexGoodsBanner.objects.all().order_by('index')

    # 获取首页促销活动信息
    promotion_banners = IndexPromotionBanner.objects.all().order_by('index')

    # 获取首页分类商品展示信息
    for type in types:  # GoodsType
        # 获取type种类首页分类商品的图片展示信息
        image_banners = IndexTypeGoodsBanner.objects.filter(type=type, display_type=1).order_by('index')
        # 获取type种类首页分类商品的文字展示信息
        title_banners = IndexTypeGoodsBanner.objects.filter(type=type, display_type=0).order_by('index')

        # 动态给type增加属性，分别保存首页分类商品的图片展示信息和文字展示信息
        type.image_banners = image_banners
        type.title_banners = title_banners

    # 组织模板上下文
    context = {'types': types,
               'goods_banners': goods_banners,
               'promotion_banners': promotion_banners}

    # 使用模板
    # 1.加载模板文件
    temp = loader.get_template('static_index.html')
    # # 2.定义模板上下文
    # context = RequestContext(request, context)
    # 3.模板渲染
    static_index_html = temp.render(context)

    # 生成首页对应静态文件
    save_path = os.path.join(settings.BASE_DIR, 'static/index.html')
    # 写文件
    with open(save_path, 'w', encoding='utf-8') as f:
        f.write(static_index_html)
