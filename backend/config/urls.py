"""URL configuration for X Clone project."""

from django.conf import settings
from django.conf.urls.static import static
from django.contrib import admin
from django.urls import include, path
from drf_spectacular.views import (
    SpectacularAPIView,
    SpectacularRedocView,
    SpectacularSwaggerView,
)
from rest_framework.versioning import QueryParameterVersioning

from apps.core.views import ApiTestView, get_server_time

urlpatterns = [
    # Api Endpoints
    path(
        "api/",
        include(
            [
                path("", include("config.router")),
                path("", include("apps.users.urls")),
            ]
        ),
    ),
    path("api/test/", ApiTestView.as_view(), name="test"),
    # Server time endpoint
    path("server-time/", get_server_time, name="server-time"),
    # Health check endpoint
    path("ht/", include("health_check.urls")),
    # Django's admin page
    path(settings.ADMIN_URL, admin.site.urls),
]

if not settings.DISABLE_API_DOC:
    urlpatterns += [
        # DRF Spectacular (API schema)
        path(
            "api/schema/",
            SpectacularAPIView.as_view(versioning_class=QueryParameterVersioning),
            name="schema",
        ),
        # DRF Spectacular UIs:
        path(
            "api/schema/swagger-ui/",
            SpectacularSwaggerView.as_view(
                url_name="schema", versioning_class=QueryParameterVersioning
            ),
            name="swagger-ui",
        ),
        path(
            "api/schema/redoc/",
            SpectacularRedocView.as_view(
                url_name="schema", versioning_class=QueryParameterVersioning
            ),
            name="redoc",
        ),
        # Django REST Framework browsable API.
        path("api-auth/", include("rest_framework.urls")),
    ]

if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
