from django.db import models
from django.contrib.auth.models import(
    AbstractBaseUser, BaseUserManager, PermissionsMixin)
from rest_framework_simplejwt.tokens import RefreshToken
from django.dispatch import receiver
from django.urls import reverse
from django_rest_passwordreset.signals import reset_password_token_created
from django.core.mail import send_mail
# from django.utils.translation import gettext_lazy as _
from django.db.models.signals import post_save
from django.conf import settings


class UserManager(BaseUserManager):
    def create_user(self, email, password=None):
        """
        Creates and saves a User with the given email, date of
        birth and password.
        """
        if not email:
            raise ValueError('Users must have an email address')

        user = self.model(
            email=self.normalize_email(email),
        )

        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_superuser(self, email, password=None, **extra_fields):
        """
        Creates and saves a superuser with the given email, date of
        birth and password.
        """

        extra_fields.setdefault('is_customer', True)
        extra_fields.setdefault('is_restaurant', True)
        extra_fields.setdefault('is_active', True)
        user = self.create_user(
            email,
            password=password,
        )
        user.is_staff = True
        user.is_admin = True
        user.save(using=self._db)
        return user


class CustomUser(AbstractBaseUser):
    email = models.EmailField(
        verbose_name='email address',
        max_length=255,
        unique=True,
    )

    name = models.CharField(
        max_length=255,
        verbose_name="Name",
    )

    contact = models.IntegerField(
        null=True,
        verbose_name="Contact",
    )
    address = models.TextField(
        max_length=255,
        verbose_name="Address", )

    user_type_data = (('C', "Customer"), ('R', "Restaurant"))
    user_type = models.CharField(
        default='C', choices=user_type_data, max_length=10)
    is_verified = models.BooleanField(default=False)
    is_customer = models.BooleanField(default=True)
    is_restaurant = models.BooleanField(default=False)
    is_active = models.BooleanField(default=True)
    is_staff = models.BooleanField(default=False)
    is_admin = models.BooleanField(default=False)

    objects = UserManager()

    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = []

    def __str__(self):
        return self.email

    def has_perm(self, perm, obj=None):
        "Does the user have a specific permission?"
        # Simplest possible answer: Yes, always
        return True

    def has_module_perms(self, app_label):
        "Does the user have permissions to view the app `app_label`?"

        return True

    @property
    def is_customer(self):
        "Is the user a customer?"

        return self.is_admin

    @property
    def is_superuser(self):
        "Is the user a member of admin?"

        return self.is_admin


class Customer(models.Model):
    user = models.OneToOneField(
        CustomUser,
        on_delete=models.CASCADE,
        primary_key=True,
        related_name='customer'
    )
    gender_type_data = (('M', "Male"), ('F', "Female"), ('U', "Unspecified"))
    gender_type = models.CharField(
        default='F', choices=gender_type_data, max_length=10)
    profile_pic = models.ImageField(upload_to='customerprofile/',
                                    verbose_name="Profile Picture",)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f'{self.user}'


class Restaurant(models.Model):
    user = models.OneToOneField(
        CustomUser,
        on_delete=models.CASCADE,
        primary_key=True,
        related_name='restaurant'
    )
    profile_pic = models.ImageField(upload_to='restaurantprofile/',
                                    verbose_name="Restaurant Profile Picture",
                                    )
    approved = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    description = models.CharField(max_length=200)
    # type_data = (('In', "Indian"), ('It', "Italian"),
    #              ('Ch', "Chinese"), ('', "Chinese"))
    type = models.CharField(max_length=200)
    seating_type_data = (('O', "Outdoor"), ('I', "Indoor"), ('B', "Both"))
    seating_type = models.CharField(
        default='I', choices=seating_type_data, max_length=10)
    dish_speciality = models.CharField(max_length=20, null=True)
    is_open = models.BooleanField(default=True)
    parking = models.BooleanField(default=True)
    pictures = models.ImageField(null=True)
    avg_price = models.IntegerField(null=True)

    def __str__(self):
        return f'{self.user}'


@receiver(post_save, sender=CustomUser)
# Now Creating a Function which will automatically insert data in HOD, Staff or Student
def create_user_profile(sender, instance, created, **kwargs):
    # if Created is true (Means Data Inserted)
    if created:
        # Check the user_type and insert the data in respective tables
        if instance.user_type == 'C':
            Customer.objects.create(
                user=instance, profile_pic="customerprofile/userdefault.png", gender_type="Choose")
        if instance.user_type == 'R':
            Restaurant.objects.create(user=instance, profile_pic="restaurantprofile/defaultrestaurant.png", approved=False,
                                      type="", seating_type="Choose", dish_speciality="", is_open=True, parking = True, pictures="")


@receiver(post_save, sender=CustomUser)
def save_user_profile(sender, instance, **kwargs):
    if instance.user_type == 'C':
        instance.customer.save()
    if instance.user_type == 'R':
        instance.restaurant.save()


# class UserManager(BaseUserManager):

#     def create_user(self, username, email, password=None,):
#         if username is None:
#             raise TypeError("Add Username")
#         if email is None:
#             raise TypeError("Add Email")

#         user = self.model(username=username, email=self.normalize_email(email))
#         user.set_password(password)
#         user.save()
#         return user

#     def create_superuser(self, username, email, password=None):
#         if password is None:
#             raise TypeError("Add Password")
#         if email is None:
#             raise TypeError("Add Email")

#         user = self. create_user(username, email, password)
#         user.is_superuser = True
#         user.is_staff = True
#         user.save()
#         return user


# class User(AbstractBaseUser, PermissionsMixin):
#     username = models.CharField(max_length=255, unique=True, db_index=True)
#     email = models.EmailField(max_length=255, unique=True, db_index=True)
#     is_verified = models.BooleanField(default=False)
#     is_active = models.BooleanField(default=True)
#     is_restaurant = models.BooleanField(default=False)
#     is_customer = models.BooleanField(default=False)
#     created_at = models.DateTimeField(auto_now_add=True)
#     updated_at = models.DateTimeField(auto_now=True)
#     name = models.CharField(max_length=150)
#     address = models.CharField(max_length=150)
#     contact = models.IntegerField(max_length=10)
#     dp = models.ImageField()
#     class Option(models.TextChoices):
#         Customer = 'C'
#         Restaurant = 'R'
#     user_type = models.TextField(choices=Option.choices)

#     USERNAME_FIELD = 'email'
#     REQUIRED_FIELDS = ['username']

#     objects = UserManager()

#     def __str__(self):
#         return self.email

#     def tokens(self):
#         return ''

# class Customer(models.Model):
#     customer = models.OneToOneField(
#         settings.AUTH_USER_MODEL, on_delete=models.CASCADE, blank=True, null=True)

#     class GenderOption(models.TextChoices):
#         Male = 'M'
#         Female = 'F'
#         Other = 'O'
#     Gender = models.TextField(choices=GenderOption.choices, default='M')

#     def __str__(self):
#         return self.seller.username

#     @receiver(post_save, sender=User)
#     def create_user_profile(sender, instance, created, **kwargs):
#         if created:
#             Customer.objects.create(user=instance)

#     @receiver(post_save, sender=User)
#     def save_user_profile(sender, instance, **kwargs):
#         instance.profile.save()


# class Restaurant(models.Model):
#     restaurant = models.OneToOneField(
#         settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
#     description = models.CharField(max_length=200)
#     type = models.CharField()
#     class Seating(models.TextChoices):
#         Outdoor = 'O'
#         Indoor = 'I'
#         Both = 'B'
#     seating_type = models.TextField(choices=Seating.choices, default='B')
#     is_open = models.BooleanField(default=True)
#     parking = models.BooleanField(default=True)
#     pictures = models.ImageField(null=True)
#     def __str__(self):
#         return self.restaurant.username

#     @receiver(post_save, sender=User)
#     def create_user_profile(sender, instance, created, **kwargs):
#         if created:
#             Restaurant.objects.create(user=instance)

#     @receiver(post_save, sender=User)
#     def save_user_profile(sender, instance, **kwargs):
#         instance.profile.save()

# # class CustomerProfile(models.Model):
# #     user = models.OneToOneField(
# #         settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name='profile', default=None)
# #     name = models.CharField(max_length=150)
# #     address = models.CharField(max_length=255, blank=True, null=True)
# #     contact = models.CharField(max_length=100, blank=True, null=False)
# #     name = models.CharField(max_length=100)
# #     address = models.CharField(max_length=255, blank=True, null=True)
# #     mobile_number = models.CharField(max_length=100, blank=True, null=True)
# #     gender = models.TextField(max_length=100)

# #     @receiver(post_save, sender=User)
# #     def create_user_profile(sender, instance, created, **kwargs):
# #         if created:
# #             Customer.objects.create(user=instance)

# #     @receiver(post_save, sender=User)
# #     def save_user_profile(sender, instance, **kwargs):
# #         instance.profile.save()


# # class RestaurantProfile(models.Model):


@receiver(reset_password_token_created)
def password_reset_token_created(sender, instance, reset_password_token, *args, **kwargs):

    email_plaintext_message = "{}?token={}".format(
        reverse('password_reset:reset-password-request'), reset_password_token.key)

    send_mail(
        # title:
        "Password Reset for {title}".format(title="Reset Your Passowrd"),
        # message:
        email_plaintext_message,
        # from:
        "bhojanalayaapp@gmail.com",
        # to:
        [reset_password_token.user.email]
    )
