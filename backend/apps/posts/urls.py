from django.urls import path
from apps.posts.views import PostListCreateView

urlpatterns = [
    path("posts/", PostListCreateView.as_view(), name="post-list-create"),
]
