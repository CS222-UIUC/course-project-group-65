from django.db import models

# Create your models here.


class Chore(models.Model):
    name = models.CharField(max_length=45, default="")
    completed = models.BooleanField(default=0)
    room = models.ForeignKey(
        "Rooms.Room", on_delete=models.CASCADE, default=1
    )  # connects to room table -> foreign key
    user = models.ForeignKey(
        "Users.user", on_delete=models.CASCADE, default=1
    )  # connects to users table -> foreign key
    weight = models.IntegerField(default=0)
