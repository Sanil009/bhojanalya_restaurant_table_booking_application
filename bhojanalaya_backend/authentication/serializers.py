from django.db import models
from django.db.models import fields
from rest_framework import serializers
from .models import User, UserProfile
from django.contrib.auth import authenticate
from rest_framework import exceptions
from django.utils.translation import gettext_lazy as _
from django.contrib import auth
from rest_framework.exceptions import AuthenticationFailed

class RegisterSerializer(serializers.ModelSerializer):
    password = serializers.CharField(
        max_length=68, min_length=4, write_only=True)

    default_error_messages = {
        'username': 'The username should only contain alphanumeric characters'}

    class Meta:
        model = User
        fields = ['email', 'username', 'password']

    def validate(self, attrs):
        email = attrs.get('email', '')
        username = attrs.get('username', '')
        phone = attrs.get('phone','')

        if not username.isalnum():
            raise serializers.ValidationError(
                self.default_error_messages)
        return attrs

    def create(self, validated_data):
        return User.objects.create_user(**validated_data)

class LoginSerializer(serializers.ModelSerializer):
    email=serializers.EmailField(max_length=60, min_length=4)
    password = serializers.CharField(
        max_length=40, min_length=4, write_only=True)
    username = serializers.CharField(max_length=255, min_length=4, read_only=True)
    # id = serializers.IntegerField(source='pk, read_only=True)
    tokens = serializers.SerializerMethodField()
    
    def get_tokens(self, obj):
        user = User.objects.get(email=obj['email'])
        userprofile = UserProfile.objects.get(id=obj['id'])
        return{
            'user-id': userprofile.id,
            # 'refresh': user.tokens()['refresh'],
            'token': user.tokens()['access']
        }

    class Meta:
        model = User
        fields = ['email','password', 'username', 'tokens']

    def validate(self,attrs):
        email=attrs.get('email')
        password=attrs.get('password')
        filtered_user_by_email = User.objects.filter(email=email)
        user = auth.authenticate(email=email, password=password)

        if not user:
            raise AuthenticationFailed('Invalid credentials, please try again')
        if not user.is_active:
            raise AuthenticationFailed('Account disabled, please contact admin')
        if not user.is_verified:
            raise AuthenticationFailed('Email is not verified')

        return {
            'email': user.email,
            'username': user.username,
            'id': user.pk,
            'tokens': user.tokens
        }
        
        return super().validate(attrs)
    
        # if email and password:
        #     auth=authenticate(email=email,password=password)
        #     if auth:
        #         return auth
        #     else:
        #         raise  exceptions.ValidationError('Email or Password Invalid')
        # else:
        #     raise exceptions.ValidationError('fill all the fields')

class ProfileSerializer(serializers.HyperlinkedModelSerializer):
    user = serializers.ReadOnlyField(source='user.id')
    id = serializers.IntegerField(source='pk', read_only=True)
    username = serializers.CharField(source='user.username', read_only=True)
    email = serializers.ReadOnlyField(source='user.email', read_only=True)
    first_name = serializers.CharField(max_length=100, min_length=2)
    last_name = serializers.CharField(max_length=100, min_length=2)
    address = serializers.CharField(max_length=100, min_length=2)
    mobile_number = serializers.CharField(max_length=100, min_length=2)

    class Meta:
        model = UserProfile
        depth = 1
        fields = ('id', 'username', 'email', 'first_name', 'last_name',
                  'address', 'mobile_number', 'user',)


class UserSerializer(serializers.HyperlinkedModelSerializer):
    # profile_url = serializers.HyperlinkedIdentityField(
    #     view_name='profile-detail')
    class Meta:
        model = User
        depth = 1
        fields = ('id', 'username', 'email')
