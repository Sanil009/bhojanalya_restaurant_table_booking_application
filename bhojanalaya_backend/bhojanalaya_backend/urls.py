"""bhojanalaya_backend URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
# from reviews.views import ReviewsListView
from reviews import views
from bookings import views as BookingsView
from django.conf.urls import url
from authentication.views import EmailTokenObtainPairView, VerifyEmail, ChangePasswordView
from bookings.views import get_bookings
from rest_framework_simplejwt.views import TokenRefreshView
from django.core.mail import EmailMessage
from django.contrib import admin
from django.urls import path, include
from bhojanalaya_backend import settings
from django.conf.urls.static import static
from rest_framework import permissions


urlpatterns = [
    url(r'^jet/', include('jet.urls', 'jet')),
    url(r'^jet/dashboard/', include('jet.dashboard.urls', 'jet-dashboard')),
    path('admin/', admin.site.urls),

    # authentication
    path('auth/', include('authentication.urls')),
    path('email-verify', VerifyEmail.as_view(), name='email-verify'),
    path('authentication/change_password/<int:pk>/',
         ChangePasswordView.as_view(), name='auth_change_password'),
    path('api-auth/', include('rest_framework.urls')),
    path('api/token/', EmailTokenObtainPairView.as_view()),
    path('api/token/refresh/', TokenRefreshView.as_view()),
    path('api/password_reset/',
         include('django_rest_passwordreset.urls', namespace='password_reset')),

    # menu, invoice
    path('menu/', include('menu.urls')),
    path('invoice/', include('invoice.urls')),

    #Reviews
    path('reviews/', include('reviews.urls')),
    # path('reviewslist/', views.ReviewsListView.as_view()),
    # path('reviewscreate/', views.ReviewsCreateView.as_view()),
    # path('api/token/refresh/', TokenRefreshView.as_view()),

    #bookings
    path('bookings/', include('bookings.urls')),
    # path('get_bookings/', BookingsView.get_bookings, name='get_bookings'),
]

if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL,
                          document_root=settings.MEDIA_ROOT)
    urlpatterns += static(settings.STATIC_URL,
                          document_root=settings.STATIC_ROOT)
