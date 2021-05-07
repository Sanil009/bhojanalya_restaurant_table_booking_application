# Generated by Django 3.1.4 on 2021-04-24 09:09

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('authentication', '0004_restaurant_avg_price'),
    ]

    operations = [
        migrations.CreateModel(
            name='Reviews',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('rating', models.IntegerField(null=True)),
                ('comments', models.CharField(max_length=250)),
                ('customer', models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='authentication.customer')),
                ('restaurant', models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='authentication.restaurant')),
            ],
        ),
    ]