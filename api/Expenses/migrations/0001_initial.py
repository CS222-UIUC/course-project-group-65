# Generated by Django 4.0.5 on 2022-07-29 01:43

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = []

    operations = [
        migrations.CreateModel(
            name="Expense",
            fields=[
                (
                    "id",
                    models.BigAutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                ("name", models.CharField(default="NULL", max_length=45)),
                ("amount", models.FloatField(default=0)),
                ("paid", models.BooleanField(default=0)),
                ("date", models.DateTimeField(auto_now_add=True)),
                ("category", models.CharField(default="NULL", max_length=45)),
            ],
        ),
        migrations.CreateModel(
            name="UserExpense",
            fields=[
                (
                    "id",
                    models.BigAutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                ("splitCost", models.FloatField(default=0)),
                ("paid", models.BooleanField(default=False)),
                (
                    "expense_id",
                    models.ForeignKey(
                        default=1,
                        on_delete=django.db.models.deletion.CASCADE,
                        to="Expenses.expense",
                    ),
                ),
            ],
        ),
    ]
