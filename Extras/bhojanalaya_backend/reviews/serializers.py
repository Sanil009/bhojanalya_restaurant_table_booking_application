from authentication.serializers import CustomerSerializer, RestaurantSerializer
from authentication.models import Customer, Restaurant
from reviews.models import Reviews
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated, AllowAny
from rest_framework import serializers

class ReviewsSerializer(serializers.ModelSerializer):
    customer = CustomerSerializer(read_only=True)
    restaurant = RestaurantSerializer(read_only=True)
    restaurant_id = serializers.PrimaryKeyRelatedField(
        queryset=Restaurant.objects.all(), source='restaurant', write_only=True)
    user_id = serializers.PrimaryKeyRelatedField(
        queryset=Customer.objects.all(), source='customer', write_only=True)
    class Meta:
        model = Reviews
        fields = ['rating', 'comments', 'customer', 'restaurant', 'restaurant_id', 'user_id']