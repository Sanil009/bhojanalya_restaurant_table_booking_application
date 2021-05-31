
from . import views as BookingsView
from rest_framework import routers
from django.urls import path, include
# from bookings import views

router = routers.DefaultRouter()

router = routers.DefaultRouter()
router.register('bookings',
                BookingsView.BookingsViewset, basename='bookings')

urlpatterns = [
    path('', include(router.urls)),
    path('get_bookings/', BookingsView.get_bookings, name='get_bookings'),
]


#     path('bookingslist/', views.BookingsListView.as_view()),
#     path('bookingscreate/', views.BookingsCreateView.as_view()),













# urlpatterns = [
#     path('', views.apiOverview, name="api-overview"),
#     path('bookings-list', views.bookingsList, name="api-overview"),
#     path('bookings-detail/<str:pk>/', views.bookingsDetail, name="bookings-detail"),
#     path('bookings-create', views.views.bookingsCreate, name="bookings-create"),
#     path('bookings-update/<str:pk>/', views.bookingsUpdate, name="bookings-update"),
#     path('bookings-delete/<str:pk>/',
#          views.bookingsDelete, name="bookings-delete"),
# ]
