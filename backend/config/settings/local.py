"""Settings for local development environment with enabled debugging tools."""

from config.settings.base import *  # noqa: F403

DEBUG = True

# https://docs.djangoproject.com/en/dev/ref/settings/#allowed-hosts
ALLOWED_HOSTS = ["*"]

if USE_DOCKER:  # noqa: F405
    ALLOWED_HOSTS += ["0.0.0.0"]  # nosec B104


if USE_DOCKER:  # noqa: F405
    import socket

    hostname, _, ips = socket.gethostbyname_ex(socket.gethostname())
    INTERNAL_IPS = [ip[: ip.rfind(".")] + ".1" for ip in ips]
    INTERNAL_IPS += ["127.0.0.1", "10.0.2.2"]
else:
    INTERNAL_IPS = ["127.0.0.1", "localhost"]

# JWT
# ------------------------------------------------------------------------------
# https://django-rest-framework-simplejwt.readthedocs.io/en/latest
SIMPLE_JWT["ACCESS_TOKEN_LIFETIME"] = timedelta(minutes=1)  # noqa: F405
SIMPLE_JWT["REFRESH_TOKEN_LIFETIME"] = timedelta(days=7)  # noqa: F405

# EMAIL
# ---------------------------------------------------------------------
EMAIL_BACKEND = "django.core.mail.backends.console.EmailBackend"

# https://docs.djangoproject.com/en/dev/ref/settings/#default-from-email
DEFAULT_FROM_EMAIL = "X Clone <info@xclone.com>"
# https://docs.djangoproject.com/en/dev/ref/settings/#server-email
SERVER_EMAIL = "X Clone <info@xclone.com>"
# https://docs.djangoproject.com/en/dev/ref/settings/#email-subject-prefix

NGROK_URL = env("NGROK_URL", default=None)  # noqa: F405


# CORS HEADERS
# ------------------------------------------------------------------------------
# https://github.com/adamchainz/django-cors-headers#setup
CORS_ALLOWED_ORIGINS = []
CORS_ALLOWED_ORIGIN_REGEXES = []

# This value is True if '*' is in cors allowed origins, otherwise False
CORS_ALLOW_ALL_ORIGINS = True
