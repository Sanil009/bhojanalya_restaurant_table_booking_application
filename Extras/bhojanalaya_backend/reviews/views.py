from django.shortcuts import render
from rest_framework.response import Response
from .serializers import ReviewsSerializer
from .models import Reviews
from rest_framework.response import Response
from rest_framework import  status
from rest_framework.permissions import AllowAny, IsAuthenticated, IsAdminUser
from rest_framework.filters import SearchFilter, OrderingFilter
from bhojanalaya_backend import settings
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework.generics import ListAPIView, CreateAPIView
# Create your views here.


class ReviewsListView(ListAPIView):
    queryset = Reviews.objects.all()
    serializer_class = ReviewsSerializer
    filter_backends = [DjangoFilterBackend]
    filter_fields = ['restaurant']
    # def get_queryset(self):
    #     restaurant = self.request.restaurant
    #     return Restaurant.objects.get_queryset()


class ReviewsCreateView(CreateAPIView):
    queryset = Reviews.objects.all()
    serializer_class = ReviewsSerializer

    def create(self, request):
        if self.request.user.is_active:
            serializer = ReviewsSerializer(
                data=request.data, context={"request": request})
            serializer.is_valid()
            serializer.save()
            print(serializer)
            return Response({'success': 'Review Successfully Created'}, status=status.HTTP_201_CREATED)
        else:
            return Response({'error': 'Only verified customer can review'}, status=status.HTTP_400_BAD_REQUEST)