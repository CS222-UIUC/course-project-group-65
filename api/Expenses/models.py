from django.db import models

# Create your models here.


class Expense(models.Model):
    name = models.CharField(max_length=45, default="")
    amount = models.FloatField(default=0)
    paid = models.BooleanField(default=0)
    date = models.DateTimeField(auto_now_add=True)
    category = models.CharField(max_length=45, default="")
    room = models.ForeignKey(
        "Rooms.Room", on_delete=models.CASCADE, default=1
    )  # connects to room table -> foreign key
    owner = models.ForeignKey(
        "Users.user", on_delete=models.CASCADE, default=1
    )  # connects to users table -> foreign key


# owners not in user expenses
class UserExpense(models.Model):
    user = models.ForeignKey(
        "Users.user", on_delete=models.CASCADE, default=1
    )  # connects to users table -> foreign key
    expense = models.ForeignKey(
        "Expense", on_delete=models.CASCADE, default=1
    )  # connects to expenses table
    splitCost = models.FloatField(default=0)
    paid = models.BooleanField(default=False)
