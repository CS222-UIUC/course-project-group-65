from django.db import models

# Create your models here.


class Memo(models.Model):
    room = models.ForeignKey(
        "Rooms.Room", on_delete=models.CASCADE, default=1
    )  # connects to room table -> foreign key
    text = models.TextField()
    user = models.ForeignKey(
        "Users.User", on_delete=models.CASCADE, default=1
    )  # connects to user table -> foreign key
    editable = models.BooleanField()
