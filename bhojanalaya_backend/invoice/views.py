
from django.shortcuts import render
from rest_framework.response import Response
from rest_framework import viewsets
from .serializers import InvoiceSerializer
from .models import Invoice
# Create your views here.


from authentication.models import Restaurant, Customer
from django.shortcuts import render
from rest_framework.response import Response
from rest_framework import viewsets
from .serializers import InvoiceSerializer
from .models import Invoice
import jwt
from jwt import ExpiredSignatureError
from rest_framework.response import Response
from requests import exceptions
from rest_framework import viewsets, status
from rest_framework.permissions import AllowAny, IsAuthenticated, IsAdminUser
from rest_framework.filters import SearchFilter, OrderingFilter
from bhojanalaya_backend import settings
from authentication.permissions import RestaurantOrReadOnly
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework.generics import ListAPIView, CreateAPIView
# Create your views here.


class InvoiceListView(ListAPIView):
    queryset = Invoice.objects.all()
    serializer_class = InvoiceSerializer
    filter_backends = [DjangoFilterBackend]
    filter_fields = ['customer']
    # def get_queryset(self):
    #     restaurant = self.request.restaurant
    #     return Restaurant.objects.get_queryset()


class InvoiceCreateView(CreateAPIView):
    queryset = Invoice.objects.all()
    serializer_class = InvoiceSerializer

    def create(self, request):
        if self.request.user.is_customer:
            serializer = InvoiceSerializer(
                data=request.data, context={"request": request})
            serializer.is_valid()
            serializer.save()
            print(serializer)
            return Response({'success': 'Invoice Successfully Created'}, status=status.HTTP_201_CREATED)
        else:
            return Response({'error': 'Only verified restaurant can review'}, status=status.HTTP_400_BAD_REQUEST)
