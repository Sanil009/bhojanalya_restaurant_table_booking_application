from django.urls import path
from . import views as MenuView
from rest_framework import routers
from django.urls import path, include

router = routers.DefaultRouter()
router.register('menu', MenuView.MenuViewsets, basename='menu')


urlpatterns = [
    path('', include(router.urls))
]
