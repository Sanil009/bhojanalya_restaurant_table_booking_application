from django.contrib.auth.models import User
from rest_framework import serializers
from rest_framework.validators import UniqueTogetherValidator


class UserSerializer(serializers.ModelSerializer):
    password = serializers.CharField(
        max_length=65, min_length=8, write_only=True 
    )
    email = serializers.EmailField(max_length=255, min_length=4)
    first_name = serializers.CharField(max_length=255, min_length=3)
    last_name = serializers.CharField(max_length=255, min_length=3)
    phone = serializers.CharField(max_length=20, min_length=5)
    address = serializers.CharField(max_length=100, min_length=10)
    
    class Meta:
        model = User
        fields = ['username, first_name, last_name, email, password, phone, address']
    
    def validate(self, attrs):
        email = attrs.get('email', '')
        
        if User.objects.filter(email=email).exists():
            raise serializers.ValidationError({'email': ('Email is already in use')})
        return super().validate(attrs)
    
    def create(self, validated_data):
        return User.objects.create_user(**validated_data)