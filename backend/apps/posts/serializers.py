from rest_framework import serializers
from apps.posts.models import Post

from drf_base64.fields import Base64ImageField

from apps.users.serializers import UserSerializer


class PostSerializer(serializers.ModelSerializer):
    file = Base64ImageField(required=False)
    user = UserSerializer(read_only=True)

    class Meta:
        model = Post
        fields = "__all__"
        read_only_fields = ["id", "user", "posted_at"]
