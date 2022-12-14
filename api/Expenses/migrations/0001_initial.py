# Generated by Django 4.0.5 on 2022-10-10 19:30

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('Users', '0001_initial'),
        ('Rooms', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Expense',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(default='', max_length=45)),
                ('amount', models.FloatField(default=0)),
                ('paid', models.BooleanField(default=0)),
                ('date', models.DateTimeField(auto_now_add=True)),
                ('category', models.CharField(default='', max_length=45)),
                ('owner', models.ForeignKey(default=1, on_delete=django.db.models.deletion.CASCADE, to='Users.user')),
                ('room', models.ForeignKey(default=1, on_delete=django.db.models.deletion.CASCADE, to='Rooms.room')),
            ],
        ),
        migrations.CreateModel(
            name='UserExpense',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('splitCost', models.FloatField(default=0)),
                ('paid', models.BooleanField(default=False)),
                ('expense', models.ForeignKey(default=1, on_delete=django.db.models.deletion.CASCADE, to='Expenses.expense')),
                ('user', models.ForeignKey(default=1, on_delete=django.db.models.deletion.CASCADE, to='Users.user')),
            ],
        ),
    ]
