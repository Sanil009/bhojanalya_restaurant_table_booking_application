from rest_framework import serializers
from .models import CustomUser, Customer, Restaurant
# from django.contrib.auth import authenticate
# from rest_framework import exceptions
# from django.utils.translation import gettext_lazy as _
from django.contrib import auth
from rest_framework.exceptions import AuthenticationFailed
from rest_framework_simplejwt.tokens import RefreshToken
# from django.contrib.auth.tokens import PasswordResetTokenGenerator
# from django.utils.encoding import smart_str, force_str, smart_bytes, DjangoUnicodeDecodeError
from django.contrib.auth.password_validation import validate_password
from django.core.validators import EmailValidator
# from django.utils.http import urlsafe_base64_decode, urlsafe_base64_encode
from rest_framework import serializers, status, validators
from rest_framework.exceptions import AuthenticationFailed
from rest_framework_simplejwt.serializers import TokenObtainSerializer


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = CustomUser
        fields = ('id', 'name', 'email', 'contact',
                  'address', 'user_type', 'password')
        extra_kwargs = {'password': {'write_only': True},
                        'id': {'read_only': True},
                        'email': {'required': True, 'validators': [EmailValidator, ]},
                        }

    def create(self, validated_data):
        """ Creates and returns a new user """

        # Validating Data
        user = CustomUser(
            name=validated_data['name'],
            email=validated_data['email'],
            contact=validated_data['contact'],
            address=validated_data['address'],
            user_type=validated_data['user_type']
        )

        user.set_password(validated_data['password'])
        user.save()
        return user


class UserUpdateSerializer(serializers.ModelSerializer):
    class Meta:
        model = CustomUser
        fields = fields = ('name', 'contact', 'address')


class CustomerSerializer(serializers.ModelSerializer):
    user = serializers.PrimaryKeyRelatedField(read_only=True)
    name = serializers.ReadOnlyField(source="user.name")
    email = serializers.ReadOnlyField(source="user.email")
    contact = serializers.ReadOnlyField(source="user.contact")
    address = serializers.ReadOnlyField(source="user.address")
    # gender_type = serializers.ReadOnlyField(source="user.gender_type")
    # profile_pic = serializers.ReadOnlyField(source="user.profile_pic")

    class Meta:
        model = Customer
        fields = ('user', 'name', 'email', 'contact',
                  'address', 'gender_type', 'profile_pic')


class RestaurantSerializer(serializers.ModelSerializer):
    user = serializers.PrimaryKeyRelatedField(read_only=True)
    name = serializers.ReadOnlyField(source="user.name")
    email = serializers.ReadOnlyField(source="user.email")
    contact = serializers.ReadOnlyField(source="user.contact")
    address = serializers.ReadOnlyField(source="user.address")
    
    # description = serializers.ReadOnlyField(source="user.description")
    # dish_speciality = serializers.ReadOnlyField(source="user.dish_speciality")
    # pictures = serializers.ReadOnlyField(source="user.pictures")

    class Meta:
        model = Restaurant
        fields = ('user', 'name', 'email', 'contact', 'address',
                  'profile_pic', 'description', 'type', 'seating_type', 
                  'dish_speciality', 'is_open', 'parking', 'pictures')


class EmailTokenObtainSerializer(TokenObtainSerializer):
    username_field = CustomUser.USERNAME_FIELD


class CustomTokenObtainPairSerializer(EmailTokenObtainSerializer):
    @classmethod
    def get_token(cls, user):
        return RefreshToken.for_user(user)

    def validate(self, attrs):
        data = super().validate(attrs)

        refresh = self.get_token(self.user)
        if self.user.is_verified == True:
            data['user_type'] = str(self.user.user_type)
            data["user_id"] = int(self.user.pk)
            data["refresh"] = str(refresh)
            data["access"] = str(refresh.access_token)
        else:
            raise serializers.ValidationError("Email should be validated!!")

        return data


class EmailVerificationSerializer(serializers.ModelSerializer):
    token = serializers.CharField(max_length=555)

    class Meta:
        model = CustomUser
        fields = ['token']


class ChangePasswordSerializer(serializers.ModelSerializer):
    password = serializers.CharField(
        write_only=True, required=True, validators=[validate_password])
    password2 = serializers.CharField(write_only=True, required=True)
    old_password = serializers.CharField(write_only=True, required=True)

    class Meta:
        model = CustomUser
        fields = ('old_password', 'password', 'password2')

    def validate(self, attrs):
        if attrs['password'] != attrs['password2']:
            raise serializers.ValidationError(
                {"password": "Password fields didn't match."})

        return attrs

    def validate_old_password(self, value):
        user = self.context['request'].user
        if not user.check_password(value):
            raise serializers.ValidationError(
                {"old_password": "Old password is not correct"})
        return value

    def update(self, instance, validated_data):
        user = self.context['request'].user
        if user.pk != instance.pk:
            raise serializers.ValidationError(
                {"authorize": "You don't have permission for this user."})

        instance.set_password(validated_data['password'])
        instance.save()

        return instance


# class CustomerRegisterSerializer(serializers.ModelSerializer):
#     password = serializers.CharField(
#         max_length=68, min_length=4, write_only=True)

#     default_error_messages = {
#         'username': 'The username should only contain alphanumeric characters'}

#     class Meta:
#         model = User
#         fields = ['email', 'username', 'password']

#     def validate(self, attrs):
#         email = attrs.get('email', '')
#         username = attrs.get('username', '')
#         phone = attrs.get('phone','')

#         if not username.isalnum():
#             raise serializers.ValidationError(
#                 self.default_error_messages)
#         return attrs

#     def create(self, validated_data):
#         return User.objects.create_user(**validated_data)

# class LoginSerializer(serializers.ModelSerializer):
#     email=serializers.EmailField(max_length=60, min_length=4)
#     password = serializers.CharField(
#         max_length=40, min_length=4, write_only=True)
#     username = serializers.CharField(max_length=255, min_length=4, read_only=True)
#     # id = serializers.IntegerField(source='pk, read_only=True)
#     tokens = serializers.SerializerMethodField()

#     def get_tokens(self, obj):
#         user = User.objects.get(email=obj['email'])
#         userprofile = User.objects.get(id=obj['id'])
#         return{
#             'user-id': userprofile.id,
#             # 'refresh': user.tokens()['refresh'],
#             'token': user.tokens()['access']
#         }

#     class Meta:
#         model = User
#         fields = ['email','password', 'username', 'tokens']

#     def validate(self,attrs):
#         email=attrs.get('email')
#         password=attrs.get('password')
#         filtered_user_by_email = User.objects.filter(email=email)
#         user = auth.authenticate(email=email, password=password)

#         if not user:
#             raise AuthenticationFailed('Invalid credentials, please try again')
#         if not user.is_active:
#             raise AuthenticationFailed('Account disabled, please contact admin')
#         if not user.is_verified:
#             raise AuthenticationFailed('Email is not verified')

#         return {
#             'email': user.email,
#             'username': user.username,
#             'id': user.pk,
#             'tokens': user.tokens
#         }

#         return super().validate(attrs)

#         # if email and password:
#         #     auth=authenticate(email=email,password=password)
#         #     if auth:
#         #         return auth
#         #     else:
#         #         raise  exceptions.ValidationError('Email or Password Invalid')
#         # else:
#         #     raise exceptions.ValidationError('fill all the fields')


# class CustomerCustomRegistrationSerializer(RegisterSerializer):
#     customer = serializers.PrimaryKeyRelatedField(
#         read_only=True,)  # by default allow_null = False
#     password = serializers.CharField(max_length=68, min_length=4, write_only=True)
#     default_error_messages = {'username': 'The username should only contain alphanumeric characters'}
#     gender = serializers.CharField(required=True)

#     def get_cleaned_data(self):
#         data = super(CustomerCustomRegistrationSerializer,
#                      self).get_cleaned_data()
#         extra_data = {
#             'gender': self.validated_data.get('gender', ''),
#         }
#         data.update(extra_data)
#         return data

#     def save(self, request):
#         user = super(CustomerCustomRegistrationSerializer, self).save(request)
#         user.is_seller = True
#         user.save()
#         customer = Customer(customer=user,
#                         gender=self.cleaned_data.get('gender'))
#         customer.save()
#         return user

# class RestaurantCustomRegistrationSerializer(RegisterSerializer):
#     restaurant = serializers.PrimaryKeyRelatedField(
#         read_only=True,)  # by default allow_null = False
#     description = serializers.CharField(required=True)
#     type = serializers.CharField(required=True)
#     seating_type = serializers.CharField()
#     parking = serializers.BooleanField()
#     pictures = serializers.ImageField()

#     def get_cleaned_data(self):
#         data = super(RestaurantCustomRegistrationSerializer,
#                      self).get_cleaned_data()
#         extra_data = {
#             'description': self.validated_data.get('description', ''),
#             'type': self.validated_data.get('type', ''),
#             'seating_type': self.validated_data.get('seating_type', ''),
#             'is_open': self.validated_data.get('is_open', ''),
#             'parking': self.validated_data.get('parking', ''),
#             'pictures': self.validated_data.get('pictures', ''),
#         }
#         data.update(extra_data)
#         return data

#     def save(self, request):
#         user = super(RestaurantCustomRegistrationSerializer, self).save(request)
#         user.is_restaurant = True
#         user.save()
#         restaurant = Restaurant(restaurant=user, description=self.cleaned_data.get('description'),
#                                 type=self.cleaned_data.get('description'),
#                                 seating_type=self.cleaned_data.get('seating_type'),
#                                 parking=self.cleaned_data.get('parking'),
#                                 pictures=self.cleaned_data.get('pictures'))
#         restaurant.save()
#         return user

# class CustomerProfileSerializer(serializers.HyperlinkedModelSerializer):
#     user = serializers.ReadOnlyField(source='user.id')
#     id = serializers.IntegerField(source='pk', read_only=True)
#     username = serializers.CharField(source='user.username', read_only=True)
#     email = serializers.ReadOnlyField(source='user.email', read_only=True)
#     name = serializers.CharField(max_length=100, min_length=2)
#     address = serializers.CharField(max_length=100, min_length=2)
#     contact = serializers.CharField(max_length=100, min_length=2)
#     gender = serializers.CharField()

#     class Meta:
#         model = User
#         depth = 1
#         fields = ('id', 'username', 'email', 'first_name',
#                   'address', 'mobile_number', 'last_name', 'user',)


# class RestaurantProfileSerializer(serializers.HyperlinkedModelSerializer):
#     user = serializers.ReadOnlyField(source='user.id')
#     id = serializers.IntegerField(source='pk', read_only=True)
#     username = serializers.CharField(source='user.username', read_only=True)
#     email = serializers.ReadOnlyField(source='user.email', read_only=True)
#     name = serializers.CharField(max_length=100, min_length=2)
#     address = serializers.CharField(max_length=100, min_length=2)
#     contact = serializers.CharField(max_length=100, min_length=2)
#     type = serializers.CharField()
#     seating_type = serializers.CharField()
#     is_open = serializers.BooleanField()
#     parking = serializers.BooleanField(required=True)
#     pictures = serializers.ImageField(required=False)

#     class Meta:
#         model = User
#         depth = 1
#         fields = ('id', 'username', 'email', 'first_name',
#                   'address', 'mobile_number', 'type', 'seating_type', 'is_open', 'parking', 'pictures', 'user',)


# # class UserSerializer(serializers.HyperlinkedModelSerializer):
# #     # profile_url = serializers.HyperlinkedIdentityField(
# #     #     view_name='profile-detail')
# #     class Meta:
# #         model = User
# #         depth = 1
# #         fields = ('id', 'username', 'email')
