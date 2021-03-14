from authentication.models import User
from rest_framework import permissions
from django.core.exceptions import PermissionDenied

class UpdateOwnProfile(permissions.BasePermission):
    """Allows Users to edit their own profile"""

    def has_object_permission(self, request, view, obj):
        """Check if user is trying to edit their own profile"""

        if request.method in permissions.SAFE_METHODS:
            return True

        return obj.id == request.user.id

class IsOwnerOrReadOnly(permissions.BasePermission):
    def has_permission(self, request, view, obj):
        if request.method in permissions.SAFE_METHODS:
            return True

        return (request.user and request.user.is_superuser) or (obj.user== request.user) 


class IsSameUserAllowEditionOrReadOnly(permissions.BasePermission):
    """
    Custom permission to only allow owners of an object to edit it.
    """

    def has_permission(self, request, view):
        # Read permissions are allowed to any request,
        # so we'll always allow GET, HEAD or OPTIONS requests.
        if request.method in permissions.SAFE_METHODS:
            return True

        # grant permission only if the method is the PUT method
        return request.user.is_staff or request.method == 'PUT'

    def has_object_permission(self, request, view, obj):
        # Read permissions are allowed to any request,
        # so we'll always allow GET, HEAD or OPTIONS requests.
        if request.method in permissions.SAFE_METHODS:
            return True

        return request.user.is_staff or (request.method == 'PUT' and
                                         obj.id == request.user.id)


# class UserIsOwnerOrAdmin(permissions.BasePermission):
#     user = User.objects.all()
#     def has_permission(self, request, view):
#         return request.user and request.user.is_authenticated()

#     def check_object_permission(self, user):
#         return (user and user.is_authenticated() and
#           (user.is_staff or ))

#     def has_object_permission(self, request, view, obj):
#         return self.check_object_permission(request.user, obj)
