from django.shortcuts import render
from authentication.utils import Util
from rest_framework import generics, status
from rest_framework.response import Response
from rest_framework_simplejwt.tokens import RefreshToken
from .serializers import RegisterSerializer, LoginSerializer, ProfileSerializer, UserSerializer
from django.urls import reverse
from django.shortcuts import get_object_or_404, render
from .models import User, UserProfile
from django.contrib.sites.shortcuts import get_current_site
import jwt
from rest_framework import viewsets, permissions, mixins
from django.conf import settings
from authentication.permissions import (
    IsOwnerOrReadOnly, IsSameUserAllowEditionOrReadOnly
)
from rest_framework.permissions import IsAuthenticated, IsAuthenticatedOrReadOnly, AllowAny, IsAdminUser

# Create your views here.

class RegisterView(generics.GenericAPIView):
    
    serializer_class = RegisterSerializer

    def post(self, request):
        user = request.data
        serializer = self.serializer_class(data=user)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        user_data = serializer.data
        user = User.objects.get(email=user_data['email'])
        token = RefreshToken.for_user(user).access_token
        current_site = get_current_site(request).domain
        relativeLink = reverse('email-verify')
        absurl = 'http://'+current_site+relativeLink+"?token="+str(token)
        email_body = 'Hello '+user.username + \
            ' Click on the link below to verify your email \n' + absurl
        data = {'email_body': email_body, 'to_email': user.email,
                'email_subject': 'Verify your email'}
        Util.send_email(data)
        return Response(user_data, status=status.HTTP_201_CREATED)


class VerifyEmail(generics.GenericAPIView):
    def get(self,request):
        token = request.GET.get('token')
        try:
            payload = jwt.decode(token,settings.SECRET_KEY)
            user = User.objects.get(id= payload['user_id'])
            if not user.is_verified:
                user.is_verified = True
                user.save()
            return Response({'email': 'Created'}, status=status.HTTP_200_OK)

        except jwt.ExpiredSignatureError as identifier:
            return Response({'error': 'EXpired link'}, status=status.HTTP_400_BAD_REQUEST)
        
        except jwt.exceptions.DecodeError as identifier:
            return Response({'error': 'Invalid TOken'}, status=status.HTTP_400_BAD_REQUEST)
        
        
class LoginAPIView(generics.GenericAPIView):
    serializer_class = LoginSerializer

    def post(self, request):
        serializer = self.serializer_class(data=request.data)
        serializer.is_valid(raise_exception=True)
        return Response(serializer.data, status=status.HTTP_200_OK)

class UserViewSet(viewsets.ModelViewSet):
    
    # Handles creating, editing and updating profiles.

    serializer_class    = UserSerializer
    queryset            = User.objects.all()
    permission_classes = (IsSameUserAllowEditionOrReadOnly,)
    # permission_classes = (permissions.IsAuthenticatedOrReadOnly,
    #                       IsSameUserAllowEditionOrReadOnly,)


class ProfileViewSet(viewsets.ReadOnlyModelViewSet):
    """
    This viewset automatically provides 'list', 'create', 'retrieve',
    'update' and 'destroy' actions.
    """
    queryset = UserProfile.objects.all()
    serializer_class = ProfileSerializer
    permission_classes = [IsOwnerOrReadOnly, IsAuthenticatedOrReadOnly, ]
    
    def get_permissions(self):
        
        if self.request.method == 'GET':
            self.permission_classes = (AllowAny,)
        if self.request.method == 'PATCH':
            self.permission_classes = (IsAuthenticated, IsOwnerOrReadOnly)
        if self.request.method == 'PUT':
            self.permission_classes = (IsAuthenticated, IsOwnerOrReadOnly)
        if self.request.method == 'DELETE':
            self.permission_classes = (IsAdminUser,)
        if self.request.method == 'POST':
            self.permission_classes = (IsAuthenticated, IsOwnerOrReadOnly,)
        return super(ProfileViewSet, self).get_permissions()
