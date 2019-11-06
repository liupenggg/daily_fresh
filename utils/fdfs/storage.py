# coding=utf-8
from django.core.files.storage import Storage
from django.conf import settings
#
from fdfs_client.client import Fdfs_client


class FDFSStorage(Storage):
    '''fast_dfs文件存储类'''
    def __init__(self, client_conf=None, base_url=None):
        '''初始化'''
        if client_conf is None:
            client_conf = settings.FDFS_CLIENT_CONF  # './utils/fdfs/client.conf'
        self.client_conf = client_conf

        if base_url is None:
            base_url = settings.FDFS_URL  # 'http://192.168.1.118:8888/'
        self.base_url = base_url

    def _open(self, name, mode='rb'):
        '''打开文件时使用'''
        pass

    def _save(self, name, content):
        '''保存文件时使用'''
        # name:你选择的上传文件的名字
        # content:包含你上传文件内容的File对象

        # 创建一个Fdfs_client对象
        client = Fdfs_client(self.client_conf)  # 文件字母不能打错了

        # 上传文件到fast_dfs系统中
        res = client.upload_by_buffer(content.read())

        # dict
        # {
        #     'Group name': group_name,
        #     'Remote file_id': remote_file_id,
        #     'Status': 'Upload successed.',
        #     'Local file name': '',
        #     'Uploaded size': upload_size,
        #     'Storage IP': storage_ip
        # }

        if res.get('Status') != 'Upload successed.':
            # 上传失败
            raise Exception('上传文件到fast_dfs失败')

        # 获取返回的文件ID
        filename = res.get('Remote file_id')

        return filename

    # 在调用save方法之前，会先调用exists
    def exists(self, name):
        '''Django判断文件名是否可用'''
        # 如果提供的名称所引用的文件在系统中存在，则返回True,否则如果这个名称可用于新文件，则返回False
        return False

    def url(self, name):
        '''返回访问文件url路径'''
        return self.base_url+name







