from apps.users.models import User
from apps.users.serializers import UserSerializer
from rest_framework import viewsets
from rest_framework.permissions import IsAuthenticated
from rest_framework.permissions import IsAdminUser
from rest_framework.permissions import BasePermission
from rest_framework.exceptions import PermissionDenied
from rest_framework.exceptions import MethodNotAllowed
from rest_framework.decorators import action

from apps.core.utils import success_response


class UserViewSet(viewsets.ModelViewSet):
    """ViewSet for user model."""

    queryset = User.objects.all()
    serializer_class = UserSerializer
    permission_classes = [IsAuthenticated]
    http_method_names = ["get", "put", "patch", "delete"]

    def get_permissions(self) -> list[BasePermission]:
        if self.action == "list":
            return [IsAdminUser()]

        return super().get_permissions()

    def get_instance(self):
        return self.request.user

    def retrieve(self, request, *args, **kwargs):
        """Retrieve a user profile. Only the user or admin can view it."""

        instance = self.get_object()
        if request.user != instance and not request.user.is_staff:
            raise PermissionDenied("You do not have permission to view this profile.")
        serializer = self.get_serializer(instance)
        return success_response("User profile retrieved successfully.", serializer.data)

    def create(self, request, *args, **kwargs):
        """Disallow POST method (user creation)."""
        raise MethodNotAllowed("POST", detail="User creation is not allowed via API.")

    def perform_update(self, serializer):
        if self.request.user != self.get_object() and not self.request.user.is_staff:
            raise PermissionDenied("You do not have permission to update this profile.")
        serializer.save()

    def perform_destroy(self, instance):
        if self.request.user != instance and not self.request.user.is_staff:
            raise PermissionDenied("You do not have permission to delete this profile.")

        instance.delete()

    @action(["get", "put", "patch", "delete"], detail=False)
    def me(self, request, *args, **kwargs):
        self.get_object = self.get_instance

        if request.method == "GET":
            return self.retrieve(request, *args, **kwargs)
        elif request.method == "PUT":
            return self.update(request, *args, **kwargs)
        elif request.method == "PATCH":
            return self.partial_update(request, *args, **kwargs)
        elif request.method == "DELETE":
            return self.destroy(request, *args, **kwargs)
