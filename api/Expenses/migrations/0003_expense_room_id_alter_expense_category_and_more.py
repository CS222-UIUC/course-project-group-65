# Generated by Django 4.0.5 on 2022-08-05 01:45

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('Rooms', '0001_initial'),
        ('Expenses', '0002_rename_expense_id_userexpense_expense'),
    ]

    operations = [
        migrations.AddField(
            model_name='expense',
            name='room_id',
            field=models.ForeignKey(default=1, on_delete=django.db.models.deletion.CASCADE, to='Rooms.room'),
        ),
        migrations.AlterField(
            model_name='expense',
            name='category',
            field=models.CharField(default='', max_length=45),
        ),
        migrations.AlterField(
            model_name='expense',
            name='name',
            field=models.CharField(default='', max_length=45),
        ),
    ]
