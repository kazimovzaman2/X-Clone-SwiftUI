from django.db import models


class Post(models.Model):
    user = models.ForeignKey("users.User", on_delete=models.CASCADE)
    content = models.TextField()
    file = models.FileField(upload_to="posts/", blank=True, null=True)
    posted_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.user.username} - {self.posted_at}"
