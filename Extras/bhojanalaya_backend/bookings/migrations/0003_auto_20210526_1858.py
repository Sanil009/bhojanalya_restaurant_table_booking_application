# Generated by Django 3.1.6 on 2021-05-26 13:13

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('bookings', '0002_bookings_is_accepted'),
    ]

    operations = [
        migrations.AlterField(
            model_name='bookings',
            name='booked_time',
            field=models.TimeField(),
        ),
    ]
