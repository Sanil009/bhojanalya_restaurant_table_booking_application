# Generated by Django 3.1.6 on 2021-05-26 13:15

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('bookings', '0004_auto_20210526_1859'),
    ]

    operations = [
        migrations.AlterField(
            model_name='bookings',
            name='booked_time',
            field=models.CharField(default='', max_length=100),
        ),
    ]
