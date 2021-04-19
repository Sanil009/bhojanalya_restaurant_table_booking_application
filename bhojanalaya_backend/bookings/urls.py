from django.urls import path
from . import views

urlpatterns = [
    path('', views.apiOverview, name="api-overview"),
    path('bookings-list', views.bookingsList, name="api-overview"),
    path('bookings-detail/<str:pk>/', views.bookingsDetail, name="bookings-detail"),
    path('bookings-create', views.views.bookingsCreate, name="bookings-create"),
    path('bookings-update/<str:pk>/', views.bookingsUpdate, name="bookings-update"),
    path('bookings-delete/<str:pk>/',
         views.bookingsDelete, name="bookings-delete"),
]
