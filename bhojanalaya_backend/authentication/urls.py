from django.db import router
from django.urls import path,include
from rest_framework import views
from authentication.views import LoginAPIView, RegisterView, VerifyEmail, ProfileViewSet, UserProfile
from rest_framework.routers import DefaultRouter
from . import views as ProfileView


router = DefaultRouter()
router.register('profiles', ProfileView.ProfileViewSet,basename='user')

urlpatterns = [
    path('register/', RegisterView.as_view(), name="register"),
    path('email-verify/', VerifyEmail.as_view(), name="email-verify"),
    path('login/', LoginAPIView.as_view(), name='login'),
    path('password_reset/', include('django_rest_passwordreset.urls', namespace='password_reset')),
    path('',include(router.urls)),
    # path('users/', UserProfile.as_view(), name="Profiler")
    # path('profile/<int : pk>', UserProfileViewSet.as_view(), name='update'),
]