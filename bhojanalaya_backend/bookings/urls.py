# from django.urls import path
# from . import views

from . import views as BookingsView
from rest_framework import routers
from django.urls import path, include

router = routers.DefaultRouter()
# # router.register('services', BookingView.ServicesViewsets, basename='services')
# router.register('bookings', BookingsView.BookingsViewsets, basename='bookings')
# # router.register('book', BookingView.BookConfirmViewsets, basename='book')

router = routers.DefaultRouter()
router.register('bookings',
                BookingsView.BookingsViewset, basename='bookings')
# router.register('bookconfirm', BookConfirmView.InsightViewset,
#                 basename='bookconfirm')

urlpatterns = [
    path('', include(router.urls))
]




# urlpatterns = [
#     path('', views.apiOverview, name="api-overview"),
#     path('bookings-list', views.bookingsList, name="api-overview"),
#     path('bookings-detail/<str:pk>/', views.bookingsDetail, name="bookings-detail"),
#     path('bookings-create', views.views.bookingsCreate, name="bookings-create"),
#     path('bookings-update/<str:pk>/', views.bookingsUpdate, name="bookings-update"),
#     path('bookings-delete/<str:pk>/',
#          views.bookingsDelete, name="bookings-delete"),
# ]
