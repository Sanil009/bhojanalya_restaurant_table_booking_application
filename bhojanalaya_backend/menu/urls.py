from django.urls import path
from . import views as MenuView
from rest_framework import routers
from django.urls import path, include
from menu import views

# router = routers.DefaultRouter()
# router.register('menu', MenuView.MenuViewsets, basename='menu')


urlpatterns = [
    # path('', include(router.urls))
    path('menulist/', views.MenuListView.as_view()),
    path('menucreate/', views.MenuCreateView.as_view()),
]
