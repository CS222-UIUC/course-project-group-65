# Generated by Django 4.0.5 on 2022-07-29 01:49

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ("Expenses", "0001_initial"),
    ]

    operations = [
        migrations.RenameField(
            model_name="userexpense",
            old_name="expense_id",
            new_name="expense",
        ),
    ]
