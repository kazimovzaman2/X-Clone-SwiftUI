from rest_framework import serializers

from apps.users.models import User


class UserCreateSerializer(serializers.ModelSerializer):
    """Serializer for creating user."""

    class Meta:
        model = User
        fields = ("id", "first_name", "last_name", "email", "password")
        extra_kwargs = {"password": {"write_only": True}}
