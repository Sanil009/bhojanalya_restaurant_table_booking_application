from django.db import models

# Create your models here.


class Invoice(models.Model):
    invoice = models.FileField()
    customer = models.ForeignKey(
        'authentication.Customer', on_delete=models.CASCADE, null=True)
    restaurant = models.ForeignKey(
        'authentication.Restaurant', on_delete=models.CASCADE, null=True)
