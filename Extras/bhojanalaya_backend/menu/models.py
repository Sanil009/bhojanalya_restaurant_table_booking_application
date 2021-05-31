from django.db import models

# Create your models here.

class Menu(models.Model):
    picture = models.ImageField(null=True)
    food_name = models.CharField(max_length = 100, null=False)
    food_type = models.CharField(max_length = 50)
    price = models.CharField(max_length = 50)
    restaurant = models.ForeignKey(
        'authentication.Restaurant', on_delete=models.CASCADE, null=True)
    
