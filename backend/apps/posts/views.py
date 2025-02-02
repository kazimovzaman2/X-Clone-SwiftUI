from rest_framework import generics, permissions

from apps.posts.models import Post
from apps.posts.serializers import PostSerializer


class PostListCreateView(generics.ListCreateAPIView):
    queryset = Post.objects.all().order_by("-posted_at")
    serializer_class = PostSerializer
    permission_classes = [permissions.IsAuthenticated]

    def perform_create(self, serializer):
        """Set the user automatically from the authenticated request"""
        serializer.save(user=self.request.user)
