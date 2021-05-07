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
from django.conf.urls import url
from authentication.views import EmailTokenObtainPairView, VerifyEmail
from django.core.mail import EmailMessage
from django.contrib import admin
from django.urls import path, include
from bhojanalaya_backend import settings
from django.conf.urls.static import static

urlpatterns = [
    url(r'^jet/', include('jet.urls', 'jet')),
    url(r'^jet/dashboard/', include('jet.dashboard.urls', 'jet-dashboard')),
    path('admin/', admin.site.urls),
    path('auth/', include('authentication.urls')),
    path('bookings/', include('bookings.urls')),
    path('email-verify', VerifyEmail.as_view(), name='email-verify'),
    path('api-auth/', include('rest_framework.urls')),
    path('api/token/', EmailTokenObtainPairView.as_view()),
    path('invoice/', include('invoice.urls')),
    path('reviews/', include('reviews.urls'))
    # path('api/token/refresh/', TokenRefreshView.as_view()),
]

if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL,
                          document_root=settings.MEDIA_ROOT)
    urlpatterns += static(settings.STATIC_URL ,document_root=settings.STATIC_ROOT)
