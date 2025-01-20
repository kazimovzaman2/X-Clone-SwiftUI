"""Provides user related models."""

from django.contrib.auth.models import AbstractUser
from django.db import models
from django.utils.translation import gettext_lazy as _

from apps.users.managers import CustomUserManager


class User(AbstractUser):
    """Custom implementation of user model."""

    DEFAULT_PROFILE_PICTURE = "defaults/user.png"

    first_name = models.CharField(_("first name"), max_length=150)
    last_name = models.CharField(_("last name"), max_length=150)
    email = models.EmailField(
        _("email address"),
        unique=True,
        help_text=_("Email address must be unique."),
    )
    updated_at = models.DateTimeField(_("update time"), auto_now=True, null=True)
    REQUIRED_FIELDS = ["first_name", "last_name"]
    USERNAME_FIELD = "email"

    objects = CustomUserManager()

    class Meta:
        verbose_name = _("user")
        verbose_name_plural = _("users")
        ordering = ("-date_joined",)

    def __repr__(self) -> str:
        return f"User(id:{self.id}, username:{self.email})"

    def __str__(self) -> str:
        return f"{self.first_name} {self.last_name} - {self.email}"
