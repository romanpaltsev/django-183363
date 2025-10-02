from django.urls import path, register_converter

from . import views
from . import converters


register_converter(converters.FourDigitYearConverter, "year4")

urlpatterns = [
    path("", views.index, name="index"),
    path("about/", views.about, name="about"),
    path("create_article/", views.create_article, name="article_create"),
    path("contact/", views.contact_view, name="contact"),
    path("login/", views.login_view, name="login"),
    path("post/<int:post_id>/", views.post_detail, name="post"),
]