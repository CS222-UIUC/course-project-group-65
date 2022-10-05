# Generated by Django 4.0.5 on 2022-09-19 19:01

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ("Users", "0002_rename_room_id_user_room"),
        ("Memos", "0001_initial"),
    ]

    operations = [
        migrations.AddField(
            model_name="memo",
            name="user",
            field=models.ForeignKey(
                default=1, on_delete=django.db.models.deletion.CASCADE, to="Users.user"
            ),
        ),
    ]
