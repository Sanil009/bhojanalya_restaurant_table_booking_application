from django.db import models

# Create your models here.


class Reviews(models.Model):
    rating = models.IntegerField(default=1, max_length=5, null=True)
    comments = models.CharField(max_length=250)
    customer = models.ForeignKey(
        'authentication.Customer', on_delete=models.CASCADE, null=True)
    restaurant = models.ForeignKey(
        'authentication.Restaurant', on_delete=models.CASCADE, null=True)
