# coding=utf-8
from django.contrib.auth.decorators import login_required


class LoginRequiredMixin(object):
    @classmethod
    def as_view(cls, **initkwargs):
        # ���ø����as_view
        view = super(LoginRequiredMixin, cls).as_view(**initkwargs)
        return login_required(view)
