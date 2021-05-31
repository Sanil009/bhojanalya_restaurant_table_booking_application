from authentication.models import Restaurant
from authentication.serializers import RestaurantSerializer
from menu.models import Menu
from rest_framework import serializers

class MenuSerializer(serializers.ModelSerializer):
    restaurant = RestaurantSerializer(read_only=True)
    restaurant_id = serializers.PrimaryKeyRelatedField(
        queryset=Restaurant.objects.all(), source='restaurant', write_only=True)
    class Meta:
        model = Menu
        fields = ['food_name', 'food_type', 'price', 'restaurant', 'restaurant_id']
