from django.urls import path
from . import views as InvoiceView
from rest_framework import routers
from django.urls import path, include

# router = routers.DefaultRouter()
# router.register('invoice', InvoiceView.InvoiceViewsets, basename='invoice')


urlpatterns = [
    # path('', include(router.urls))
    path('invoicelist/', InvoiceView.InvoiceListView.as_view()),
    path('invoicecreate/', InvoiceView.InvoiceCreateView.as_view()),
]
