from django.db import models

# Create your models here.


class Room(models.Model):
    name = models.CharField(max_length=45, default="")
    num_members = models.IntegerField(default=0)
    # causing errors: admin = models.ForeignKey('Users.user', on_delete=models.SET_NULL, related_name='rooms', blank=True, null=True) # connects to user table -> foreign key
    chore_cycle_len = models.IntegerField(default=0)
    # DONT NEED? total_expenses = models.FloatField()
    set_up = models.BooleanField(default=0)
