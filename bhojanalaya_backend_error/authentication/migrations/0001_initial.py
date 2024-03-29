# Generated by Django 3.1.4 on 2021-04-18 13:56

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='CustomUser',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('password', models.CharField(max_length=128, verbose_name='password')),
                ('last_login', models.DateTimeField(blank=True, null=True, verbose_name='last login')),
                ('email', models.EmailField(max_length=255, unique=True, verbose_name='email address')),
                ('name', models.CharField(max_length=255, verbose_name='Name')),
                ('contact', models.IntegerField(null=True, verbose_name='Contact')),
                ('address', models.TextField(max_length=255, verbose_name='Address')),
                ('user_type', models.CharField(choices=[('C', 'Customer'), ('R', 'Restaurant')], default='C', max_length=10)),
                ('is_verified', models.BooleanField(default=False)),
                ('is_restaurant', models.BooleanField(default=False)),
                ('is_active', models.BooleanField(default=True)),
                ('is_admin', models.BooleanField(default=False)),
            ],
            options={
                'abstract': False,
            },
        ),
        migrations.CreateModel(
            name='Customer',
            fields=[
                ('user', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, primary_key=True, related_name='customer', serialize=False, to='authentication.customuser')),
                ('gender_type', models.CharField(choices=[('M', 'Male'), ('F', 'Female'), ('U', 'Unspecified')], default='F', max_length=10)),
                ('profile_pic', models.ImageField(upload_to='customerprofile/', verbose_name='Profile Picture')),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField(auto_now_add=True)),
            ],
        ),
        migrations.CreateModel(
            name='Restaurant',
            fields=[
                ('user', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, primary_key=True, related_name='restaurant', serialize=False, to='authentication.customuser')),
                ('profile_pic', models.ImageField(upload_to='restaurantprofile/', verbose_name='Restaurant Profile Picture')),
                ('approved', models.BooleanField(default=False)),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField(auto_now_add=True)),
                ('description', models.CharField(max_length=200)),
                ('type', models.CharField(max_length=200)),
                ('seating_type', models.CharField(choices=[('O', 'Outdoor'), ('I', 'Indoor'), ('B', 'Both')], default='I', max_length=10)),
                ('dish_speciality', models.CharField(max_length=20)),
                ('is_open', models.BooleanField(default=True)),
                ('parking', models.BooleanField(default=True)),
                ('pictures', models.ImageField(null=True, upload_to='')),
            ],
        ),
    ]
