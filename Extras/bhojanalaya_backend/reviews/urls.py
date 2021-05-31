from django.urls import path
from . import views as ReviewsView
from rest_framework import routers
from django.urls import path, include
from reviews import views

# router = routers.DefaultRouter()
# router.register('reviews', ReviewsView.ReviewsViewsets, basename='reviews')


urlpatterns = [
    # path('', include(router.urls)),
    path('reviewslist/', views.ReviewsListView.as_view()),
    path('reviewscreate/', views.ReviewsCreateView.as_view()),
]