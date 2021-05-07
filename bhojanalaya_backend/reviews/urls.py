from django.urls import path
from . import views as ReviewsView
from rest_framework import routers
from django.urls import path, include

router = routers.DefaultRouter()
router.register('reviews', ReviewsView.ReviewsViewsets, basename='reviews')


urlpatterns = [
    path('', include(router.urls))
]
