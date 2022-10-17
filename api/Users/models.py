from django.db import models

# Create your models here.


class User(models.Model):
    name = models.CharField(max_length=45, default="")
    nickname = models.CharField(max_length=45, default="")
    email = models.CharField(max_length=90, default="")
    available = models.CharField(max_length=45, default="")
    expenses_amt = models.FloatField(default=0)
    room_admin = models.BooleanField(default=0)
    room = models.ForeignKey(
        "Rooms.Room", on_delete=models.SET_DEFAULT, default=1
    )  # connects to room table -> foreign key
    chore_weight = models.IntegerField(default=1)
