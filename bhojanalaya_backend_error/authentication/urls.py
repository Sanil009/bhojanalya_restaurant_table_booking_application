# from django.db import router
# from authentication.views import UserViewSet
from django.urls import path,include
from rest_framework import routers, urls
# from authentication.views import CustomerView, VerifyEmail
# from rest_framework.routers import DefaultRouter
from . import views as UserView


router = routers.DefaultRouter()
router.register('register', UserView.UserViewSet, basename='create user')
router.register('restaurant', UserView.RestaurantViewset, basename='restaurant')
router.register('customer', UserView.CustomerViewset, basename='customer')

urlpatterns = [
    path('', include(router.urls))
]


# router = DefaultRouter()
# router.register('profiles', ProfileView.ProfileViewSet,basename='user'),
# router.register('customer-profile', ProfileView.CustomerProfileViewSet,basename='customer')
# router.register('restaurant-profile',
#                 ProfileView.RestaurantProfileViewSet, basename='restaurant')

# urlpatterns = [
#     # path('register/', CustomerView.as_view(), name="register"),
#     # path('email-verify/', VerifyEmail.as_view(), name="email-verify"),
#     # path('login/', LoginAPIView.as_view(), name='login'),
#     # path('password_reset/', include('django_rest_passwordreset.urls', namespace='password_reset')),
#     # path('',include(router.urls)),
#     # path('users/', UserProfile.as_view(), name="Profiler")
#     # path('profile/<int : pk>', UserProfileViewSet.as_view(), name='update'),
#     # 
# ]path('api/token/', .as_view(), name=""),
