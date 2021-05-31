from menu.models import Menu
from rest_framework import serializers

class MenuSerializer(serializers.ModelSerializer):
    class Meta:
        model = Menu
        fields = ['food_name', 'food_type', 'price', 'restaurant']
