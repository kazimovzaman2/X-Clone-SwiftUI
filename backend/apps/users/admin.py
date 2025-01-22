from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from apps.users.models import User
from django.utils.translation import gettext_lazy as _


@admin.register(User)
class CustomUserAdmin(UserAdmin):
    add_fieldsets = (
        (
            None,
            {
                "classes": ("wide",),
                "fields": (
                    "first_name",
                    "last_name",
                    "password1",
                    "password2",
                ),
            },
        ),
    )
    fieldsets = (
        (None, {"fields": ("email", "username", "password")}),
        (
            _("Personal info"),
            {
                "fields": (
                    "first_name",
                    "last_name",
                )
            },
        ),
        (
            _("Permissions"),
            {
                "fields": (
                    "is_active",
                    "is_staff",
                    "is_superuser",
                    "groups",
                    "user_permissions",
                ),
            },
        ),
        (_("Important dates"), {"fields": ("last_login", "date_joined")}),
    )
    list_display = (
        "id",
        "email",
        "is_staff",
        "is_active",
        "date_joined",
    )
    list_display_links = ("id", "email")
    list_filter = ("is_staff", "is_active")
    ordering = ("-id",)
    search_fields = (
        "email",
        "first_name",
        "last_name",
    )
    sortable_by = ("id", "username", "email", "date_joined")
    readonly_fields = ("date_joined", "last_login")
