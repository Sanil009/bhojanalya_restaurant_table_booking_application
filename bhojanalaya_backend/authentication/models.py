from django.core.mail import send_mail
from django_rest_passwordreset.signals import reset_password_token_created
from django.urls import reverse
from django.dispatch import receiver
from django.db import models
from django.contrib.auth.models import(AbstractBaseUser, BaseUserManager, PermissionsMixin)
from django.db.models.deletion import CASCADE
from django.utils.translation import ugettext_lazy as _
from django.db.models.signals import post_save


class UserManager(BaseUserManager):

    def create_user(self, username, email, password=None,):
        if username is None:
            raise TypeError("Add Username")
        if email is None:
            raise TypeError("Add Email")

        user = self.model(username=username, email=self.normalize_email(email))
        user.set_password(password)
        user.save()
        return user

    def create_superuser(self, username, email, password=None):
        if password is None:
            raise TypeError("Add Password")
        if email is None:
            raise TypeError("Add Email")

        user = self. create_user(username, email, password)
        user.is_superuser = True
        user.is_staff = True
        user.save()
        return user


class User(AbstractBaseUser, PermissionsMixin):
    username = models.CharField(max_length=255, unique=True, db_index=True)
    email = models.EmailField(max_length=255, unique=True, db_index=True)
    is_verified = models.BooleanField(default=False)
    is_active = models.BooleanField(default=True)
    is_restaurant = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = ['username']

    objects = UserManager()

    def __str__(self):
        return self.email

    def tokens(self):
        return ''


class UserProfile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    # first_name = models.CharField(max_length=100, min_length=2)
    # last_name = models.CharField(max_length=100, min_length=2)
    # address = models.CharField(max_length=100, min_length=2)
    # mobile_number = models.CharField(max_length=100, min_length=2)

    def __str__(self):
        return self.user.username

    def create_user_profile(sender, instance, created, **kwargs):
        if created:
            UserProfile.objects.create(user=instance)
    post_save.connect(create_user_profile, sender=User)


# class RestaurantProfile(models.Model):


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
