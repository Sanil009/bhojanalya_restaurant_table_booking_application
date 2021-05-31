# from authentication.utils import Util
from .serializers import ChangePasswordSerializer, CustomTokenObtainPairSerializer, CustomerSerializer, EmailVerificationSerializer, RestaurantSerializer, UserSerializer, UserUpdateSerializer
from django.shortcuts import get_object_or_404, render
from .models import CustomUser, Customer, Restaurant
# from authentication.permissions import (
#     IsOwnerOrReadOnly
# )
from rest_framework.permissions import IsAuthenticated, IsAuthenticatedOrReadOnly, AllowAny, IsAdminUser
import os
from django.http import HttpResponsePermanentRedirect
from rest_framework import viewsets, status, views, generics, permissions, mixins
from rest_framework.permissions import AllowAny, IsAuthenticated, IsAdminUser, IsAuthenticatedOrReadOnly
from rest_framework.response import Response
from rest_framework.status import HTTP_500_INTERNAL_SERVER_ERROR, HTTP_400_BAD_REQUEST
from rest_framework.views import APIView
from rest_framework_simplejwt.tokens import RefreshToken
from rest_framework_simplejwt.views import TokenObtainPairView
from .permissions import IsOwnerOrReadOnly
from .utils import Util
from django.contrib.sites.shortcuts import get_current_site
from django.urls import reverse
import jwt
from django.conf import settings
from drf_yasg.utils import swagger_auto_schema
from drf_yasg import openapi
from django.shortcuts import get_object_or_404
from django.utils.encoding import smart_str, force_str, smart_bytes, DjangoUnicodeDecodeError
class CustomRedirect(HttpResponsePermanentRedirect):

    allowed_schemes = [os.environ.get('APP_SCHEME'), 'http', 'https']


class UserViewSet(viewsets.ModelViewSet):
    serializer_class = UserSerializer
    queryset = CustomUser.objects.all()

    def create(self, request):
        try:
            user=request.data
            serializer = UserSerializer(
                data=request.data, context={"request": request})
            serializer.is_valid()
            serializer.save()
            user_data = serializer.data
            user = CustomUser.objects.get(email=user_data['email'])
            token = RefreshToken.for_user(user).access_token

            current_site = get_current_site(request).domain
            relativeLink = reverse('email-verify')
            absurl = 'http://'+current_site+relativeLink+'?token='+str(token)
            email_body = 'Hello '+user.name + \
                ', please click on the link to verify your email \n' + absurl
            data = {'email_body': email_body, 'to_email': user.email,
                    'email_subject': 'Verify your Email!'}
            Util.send_email(data)
            return Response(user_data, status=status.HTTP_201_CREATED)
        except Exception as e:
            return Response({"error": str(e)}, status=HTTP_500_INTERNAL_SERVER_ERROR)

    def get_serializer_class(self):
        if self.action == 'create':
            return UserSerializer
        if self.action == 'list':
            return UserSerializer
        if self.action == 'retrieve':
            return UserSerializer
        if self.action == 'update':
            return UserSerializer
        return UserSerializer

    def get_permissions(self):
        if self.request.method == 'GET':
            self.permission_classes = (AllowAny,)
        if self.request.method == 'PATCH':
            self.permission_classes = (IsAuthenticated, IsOwnerOrReadOnly)
        if self.request.method == 'PUT':
            self.permission_classes = (IsOwnerOrReadOnly,)
        if self.request.method == 'DELETE':
            self.permission_classes = (IsAdminUser,)
        if self.request.method == 'POST':
            self.permission_classes = (AllowAny, )
        return super(UserViewSet, self).get_permissions()

    def update(self, request, pk=None):
        try:
            user = self.get_object()
            serializer = UserUpdateSerializer(
                user, data=request.data, partial=True)
            if serializer.is_valid():
                serializer.save()
                return Response({'message': 'Account Updated Has Been Successfully'})
            else:
                return Response(serializer.errors, status=HTTP_400_BAD_REQUEST)
        except Exception as e:
            return Response({"error": str(e)}, status=HTTP_500_INTERNAL_SERVER_ERROR)

class VerifyEmail(views.APIView):
    serializer_class = EmailVerificationSerializer
    token_param_config = openapi.Parameter(
        'token', in_=openapi.IN_QUERY, description='Description', type=openapi.TYPE_STRING)

    @swagger_auto_schema(manual_parameters=[token_param_config])
    def get(self, request):
        token = request.GET.get('token')
        try:
            payload = jwt.decode(token, settings.SECRET_KEY, algorithms=['HS256'])
            user = CustomUser.objects.get(id=payload['user_id'])
            if not user.is_verified:
                user.is_verified = True
                user.save()
            return Response({'email': 'Successfully Activated'}, status=status.HTTP_200_OK)
        except jwt.ExpiredSignatureError as identifier:
            return Response({'error': 'Token has been expired'}, status=status.HTTP_400_BAD_REQUEST)

        except jwt.exceptions.DecodeError as identifier:
            return Response({'error': 'Invalid token request new one'}, status=status.HTTP_400_BAD_REQUEST)

class CustomerViewset(viewsets.ModelViewSet):
    queryset = Customer.objects.all()
    serializer_class = CustomerSerializer

    def get_permissions(self):
        if self.request.method == 'GET':
            self.permission_classes = (AllowAny,)
        if self.request.method == 'DELETE':
            self.permission_classes = (IsAdminUser,)
        return super(CustomerViewset, self).get_permissions()


class RestaurantViewset(viewsets.ModelViewSet):
    queryset = Restaurant.objects.all()
    serializer_class = RestaurantSerializer
    # permission_classes = [IsAuthenticatedOrReadOnly]
    
    def get_permissions(self):
        if self.request.method == 'GET':
            self.permission_classes = (AllowAny,)
        if self.request.method == 'DELETE':
            self.permission_classes = (IsAdminUser,)
        return super(RestaurantViewset, self).get_permissions()

# ProfileOwnerOrReadOnly,

class EmailTokenObtainPairView(TokenObtainPairView):
    serializer_class = CustomTokenObtainPairSerializer

class ChangePasswordView(generics.UpdateAPIView):
    queryset = CustomUser.objects.all()
    permission_classes = (IsAuthenticated,)
    serializer_class = ChangePasswordSerializer


    # def create(self, request):
    #     try:
    #         serializer = UserSerializer(
    #             data=request.data, context={"request": request})
    #         serializer.is_valid()
    #         serializer.save()
    #         user_data = serializer.data
    #         user = CustomUser.objects.get(email=user_data['email'])
    #         token = RefreshToken.for_user(user).access_token

    #         current_site = get_current_site(request)
    #         relativeLink = reverse('email-verify')
    #         absurl = 'http://'+str(current_site) + \
    #             relativeLink+'?token='+str(token)
    #         email_body = 'Hello '+user.name + \
    #             ', please click on the link to verify your email \n' + absurl
    #         data = {'email_body': email_body, 'to_email': user.email,
    #                 'email_subject': 'Verify your Email!'}
    #         Util.send_email(data)
    #         return Response(user_data, status=status.HTTP_201_CREATED)
    #     except Exception as e:
    #         return Response({"error": str(e)}, status=HTTP_500_INTERNAL_SERVER_ERROR)



# class CustomerRegisterView(generics.GenericAPIView):

#     serializer_class = CustomerCustomRegistrationSerializer

#     def post(self, request):
#         user = request.data
#         serializer = self.serializer_class(data=user)
#         serializer.is_valid(raise_exception=True)
#         serializer.save()
#         user_data = serializer.data
#         user = User.objects.get(email=user_data['email'])
#         token = RefreshToken.for_user(user).access_token
#         current_site = get_current_site(request).domain
#         relativeLink = reverse('email-verify')
#         absurl = 'http://'+current_site+relativeLink+"?token="+str(token)
#         email_body = 'Hello '+user.username + \
#             ' Click on the link below to verify your email \n' + absurl
#         data = {'email_body': email_body, 'to_email': user.email,
#                 'email_subject': 'Verify your email'}
#         Util.send_email(data)
#         return Response(user_data, status=status.HTTP_201_CREATED)


# class RestaurantRegisterView(generics.GenericAPIView):

#     serializer_class = RestaurantCustomRegistrationSerializer

#     def post(self, request):
#         user = request.data
#         serializer = self.serializer_class(data=user)
#         serializer.is_valid(raise_exception=True)
#         serializer.save()
#         user_data = serializer.data
#         user = User.objects.get(email=user_data['email'])
#         token = RefreshToken.for_user(user).access_token
#         current_site = get_current_site(request).domain
#         relativeLink = reverse('email-verify')
#         absurl = 'http://'+current_site+relativeLink+"?token="+str(token)
#         email_body = 'Hello '+user.username + \
#             ' Click on the link below to verify your email \n' + absurl
#         data = {'email_body': email_body, 'to_email': user.email,
#                 'email_subject': 'Verify your email'}
#         Util.send_email(data)
#         return Response(user_data, status=status.HTTP_201_CREATED)

# class VerifyEmail(generics.GenericAPIView):
#     def get(self,request):
#         token = request.GET.get('token')
#         try:
#             payload = jwt.decode(token, settings.SECRET_KEY, algorithms=['HS256'])
#             user = User.objects.get(id= payload['user_id'])
#             if not user.is_verified:
#                 user.is_verified = True
#                 user.save()
#             return Response({'email': 'Created'}, status=status.HTTP_200_OK)

#         except jwt.ExpiredSignatureError as identifier:
#             return Response({'error': 'EXpired link'}, status=status.HTTP_400_BAD_REQUEST)

#         except jwt.exceptions.DecodeError as identifier:
#             return Response({'error': 'Invalid TOken'}, status=status.HTTP_400_BAD_REQUEST)


# class LoginAPIView(generics.GenericAPIView):
#     serializer_class = LoginSerializer

#     def post(self, request):
#         serializer = self.serializer_class(data=request.data)
#         serializer.is_valid(raise_exception=True)
#         return Response(serializer.data, status=status.HTTP_200_OK)

# # class UserViewSet(viewsets.ModelViewSet):

# #     # Handles creating, editing and updating profiles.

# #     serializer_class    = UserSerializer
# #     queryset            = User.objects.all()
# #     permission_classes = (IsSameUserAllowEditionOrReadOnly,)
# #     # permission_classes = (permissions.IsAuthenticatedOrReadOnly,
# #     #                       IsSameUserAllowEditionOrReadOnly,)


# class CustomerProfileViewSet(viewsets.ReadOnlyModelViewSet):
#     """
#     This viewset automatically provides 'list', 'create', 'retrieve',
#     'update' and 'destroy' actions.
#     """
#     queryset = Customer.objects.all()
#     serializer_class = CustomerCustomRegistrationSerializer

#     def get_permissions(self):

#         if self.request.method == 'GET':
#             self.permission_classes = (AllowAny,)
#         if self.request.method == 'PATCH':
#             self.permission_classes = (IsAuthenticated, IsOwnerOrReadOnly)
#         if self.request.method == 'PUT':
#             self.permission_classes = (IsAuthenticated, IsOwnerOrReadOnly)
#         if self.request.method == 'DELETE':
#             self.permission_classes = (IsAdminUser,)
#         if self.request.method == 'POST':
#             self.permission_classes = (IsAuthenticated, IsOwnerOrReadOnly,)
#         return super(CustomerProfileViewSet, self).get_permissions()
