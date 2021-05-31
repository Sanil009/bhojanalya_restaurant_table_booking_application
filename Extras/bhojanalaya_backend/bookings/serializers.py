from rest_framework import viewsets, generics
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated, AllowAny
from rest_framework import serializers
from .models import Bookings


class BookingsSerializer(serializers.ModelSerializer):
    class Meta:
        model = Bookings
        fields = ['id','booked_date', 'booked_time', 'customer', 'restaurant','is_accepted']


# class BookConfirmSerializer(serializers.ModelSerializer):
#     class Meta:
#         model = BookConfirm
#         fields = ['date', 'by', 'for_request', 'confirmed']









# class BookingsSerializer(serializers.ModelSerializer):
#     class Meta:
#         model = Bookings
#         fields = (
#             "time",
#             "date",
#             "status",
#             "restaurant_id",
#             "customer_id",
#         )
#         read_only_fields = (
#             "restaurant_id",
#             "customer_id",
#         )
