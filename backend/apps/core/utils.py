from collections.abc import Sequence
from typing import Any, Optional

from django_stubs_ext import StrOrPromise
from rest_framework.response import Response


def success_response(
    message: StrOrPromise, detail: Optional[Sequence[Any]] = None
) -> Response:
    """Returns success response with 200 http code."""
    return Response({"type": "success", "message": message, "detail": detail or []})
