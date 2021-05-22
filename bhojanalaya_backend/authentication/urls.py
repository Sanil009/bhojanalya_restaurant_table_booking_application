# from django.db import router
# from authentication.views import UserViewSet
from django.urls import path, include
from rest_framework import routers, urls
from . import views as UserView


router = routers.DefaultRouter()
router.register('register', UserView.UserViewSet, basename='create user')
router.register('restaurant', UserView.RestaurantViewset,
                basename='restaurant')
router.register('customer', UserView.CustomerViewset, basename='customer')

urlpatterns = [
    path('', include(router.urls)),
]
