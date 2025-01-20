from django.conf import settings
from rest_framework.routers import BaseRouter, DefaultRouter, SimpleRouter


router: BaseRouter

if settings.DEBUG:
    router = DefaultRouter()
else:
    router = SimpleRouter()


urlpatterns = router.urls
