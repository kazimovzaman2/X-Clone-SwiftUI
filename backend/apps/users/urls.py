from django.urls import path
from rest_framework_simplejwt.views import (
    TokenObtainPairView,
    TokenRefreshView,
    TokenVerifyView,
)

from apps.users.views import LogoutView

urlpatterns = [
    path("jwt/create/", TokenObtainPairView.as_view(), name="token_obtain_pair"),
    path("jwt/refresh/", TokenRefreshView.as_view(), name="token_refresh"),
    path("jwt/logout/", LogoutView.as_view(), name="logout"),
    path("jwt/verify/", TokenVerifyView.as_view(), name="token_verify"),
]
