
from django.db import models
from django.db.models.fields import IntegerField


# Create your models here.


class Bookings(models.Model):
    booking_time = models.TimeField()
    booking_date = models.DateField()
    date_of_booking = models.DateField(auto_now=True)
    restaurant_id = models.IntegerField()
    customer_id = models.IntegerField()
    # restaurant = models.ForeignKey(Restaurant, on_delete=models.CASCADE)
    # customer_id = models.ForeignKey(Customer, on_delete=models.CASCADE)

    def __str__(self):
        return self.title
