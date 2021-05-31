from authentication.models import Restaurant, Customer
from django.shortcuts import render
from rest_framework.response import Response
from rest_framework import viewsets
from .serializers import MenuSerializer
from .models import Menu
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


class MenuViewsets(viewsets.ModelViewSet):
    queryset = Menu.objects.all()
    serializer_class = MenuSerializer

    def list(self, request):
        if request.user.is_active == False:
            return Response({'error': 'Login to view.'}, status=status.HTTP_400_BAD_REQUEST)
        elif request.user.is_restaurant:
            queryset = Menu.objects.filter(
                restaurant=Restaurant.objects.get(user=self.request.user))
            serializer = MenuSerializer(queryset, many=True, )
        elif request.user.is_customer:
            queryset = Menu.objects.all()
            serializer = MenuSerializer(queryset, many=True, )
        elif request.user.is_active:
            queryset = Menu.objects.all()
            serializer = MenuSerializer(queryset, many=True, )
        else:
            return Response({'Error': 'Invalid access'}, status=status.HTTP_400_BAD_REQUEST)
        serializer = MenuSerializer(queryset, many=True, )
        return Response(serializer.data)

    def create(self, request):
        if self.request.user.is_restaurant:
            serializer = MenuSerializer(
                data=request.data, context={"request": request})
            serializer.is_valid()
            serializer.save()
            print(serializer)
            return Response({'success': 'Item Added Successfully'}, status=status.HTTP_201_CREATED)
        else:
            return Response({'error': 'Only verified restaurant can add menu items'}, status=status.HTTP_400_BAD_REQUEST)
