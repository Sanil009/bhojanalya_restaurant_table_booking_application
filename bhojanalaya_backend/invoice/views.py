
from django.shortcuts import render
from rest_framework.response import Response
from rest_framework import viewsets
from .serializers import InvoiceSerializer
from .models import Invoice
# Create your views here.


class InvoiceViewsets(viewsets.ModelViewSet):
    queryset = Invoice.objects.all()
    serializer_class = InvoiceSerializer
