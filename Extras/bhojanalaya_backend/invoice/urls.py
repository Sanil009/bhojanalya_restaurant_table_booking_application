from django.urls import path
from . import views as InvoiceView
from rest_framework import routers
from django.urls import path, include

router = routers.DefaultRouter()
router.register('invoice', InvoiceView.InvoiceViewsets, basename='invoice')


urlpatterns = [
    path('', include(router.urls))
]
