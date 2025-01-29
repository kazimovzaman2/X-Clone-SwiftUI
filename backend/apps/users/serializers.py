from rest_framework import serializers
from drf_base64.fields import Base64ImageField

from apps.users.models import User


class UserCreateSerializer(serializers.ModelSerializer):
    """Serializer for creating user."""

    class Meta:
        model = User
        fields = ("id", "first_name", "last_name", "email", "password")
        extra_kwargs = {"password": {"write_only": True}}


class UserSerializer(serializers.ModelSerializer):
    """Serializer for user model."""

    profile_picture = Base64ImageField(required=False)

    class Meta:
        model = User
        fields = (
            "id",
            "first_name",
            "last_name",
            "email",
            "profile_picture",
            "updated_at",
        )
        read_only_fields = ("email",)
