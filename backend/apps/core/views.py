"""Views for the core app. Consists of different mixins and utilities."""

from __future__ import annotations

from django.http import JsonResponse
from django.utils import timezone
from django.views.decorators.http import require_GET
from rest_framework.permissions import IsAdminUser
from rest_framework.response import Response
from rest_framework.views import APIView


@require_GET
def get_server_time(request):
    return JsonResponse(timezone.now(), safe=False)


class ApiTestView(APIView):
    """View for testing default headers and stuff."""

    permission_classes = [IsAdminUser]
    serializer_class = None

    def get(self, *args, **kwargs):
        return Response(
            {
                "X-Forwarded-For": self.request.META.get("X-Forwarded-For"),
                "REMOTE_ADDR": self.request.META.get("REMOTE_ADDR"),
                "HTTP_X_FORWARDED_PROTO": self.request.META.get(
                    "HTTP_X_FORWARDED_PROTO"
                ),
            }
        )
