from authentication.models import Restaurant, Customer, CustomUser
from django.shortcuts import render
from rest_framework.response import Response
from rest_framework import viewsets
from .serializers import ReviewsSerializer
from bookings import serializers
from .models import Reviews
import jwt
from jwt import ExpiredSignatureError
from rest_framework.response import Response
from requests import exceptions
from rest_framework import viewsets, status
from rest_framework.permissions import AllowAny, IsAuthenticated, IsAdminUser
from rest_framework.filters import SearchFilter, OrderingFilter
from bhojanalaya_backend import settings
from authentication.permissions import RestaurantOrReadOnly
# Create your views here.

class ReviewsViewsets(viewsets.ModelViewSet):
    queryset = Reviews.objects.all()
    serializer_class = ReviewsSerializer

    def list(self, request):
        if request.user.is_active == False:
            return Response({'error': 'Login to view.'}, status=status.HTTP_400_BAD_REQUEST)
        elif request.user.is_restaurant:
            queryset = Reviews.objects.filter(
                report_by=Restaurant.objects.get(user=self.request.user))
            serializer = ReviewsSerializer(queryset, many=True, )
        elif request.user.is_customer:
            queryset = Reviews.objects.filter(
                response_to=Customer.objects.get(user=self.request.user))
            serializer = ReviewsSerializer(queryset, many=True, )
        else:
            return Response({'Error': 'Invalid access'}, status=status.HTTP_400_BAD_REQUEST)
        serializer = ReviewsSerializer(queryset, many=True, )
        return Response(serializer.data)

    def create(self, request):
        if self.request.user.is_customer:
            serializer = ReviewsSerializer(
                data=request.data, context={"request": request})
            serializer.is_valid()
            serializer.save()
            print(serializer)
            return Response({'success': 'Successfully Created'}, status=status.HTTP_201_CREATED)
        else:
            return Response({'error': 'Only verified customer can create'}, status=status.HTTP_400_BAD_REQUEST)
