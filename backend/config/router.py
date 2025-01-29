from django.conf import settings
from rest_framework.routers import BaseRouter, DefaultRouter, SimpleRouter

from apps.users.viewsets import UserViewSet


router: BaseRouter

if settings.DEBUG:
    router = DefaultRouter()
else:
    router = SimpleRouter()

router.register("users", UserViewSet)


urlpatterns = router.urls
