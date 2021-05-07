
from django.db import models
from django.db.models.fields import IntegerField


# Create your models here.

class Bookings(models.Model):
    booked_date = models.DateField(auto_now=True)
    booked_time = models.TimeField(auto_now=True)
    customer = models.ForeignKey(
        'authentication.Customer', on_delete=models.CASCADE)
    restaurant = models.ForeignKey(
        'authentication.Restaurant', on_delete=models.CASCADE)
    book = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True, null=True)
    updated_at = models.DateTimeField(auto_now=True)
    # stat = (('Pending', 'Pending'), ('Approved', 'Approved'))
    # status = models.CharField(
    #     max_length=50, choices=stat, default='Pending', null=True)

    # def str(self):
    #     return self.problem_description
    
    @property
    def owner(self):
        return self.customer

# class BookConfirm(models.Model):
#     bookings = models.ForeignKey(
#         'bookings.Bookings', on_delete=models.CASCADE)
#     date = models.DateField(auto_now=True)
#     by = models.ForeignKey(
#         'authentication.Restaurant', on_delete=models.CASCADE)
    
#     confirmed = models.BooleanField(default=False)



# for_request = models.ForeignKey('Request', on_delete=models.CASCADE)


# class Bookings(models.Model):
#     booking_time = models.TimeField()
#     booking_date = models.DateField()
#     date_of_booking = models.DateField(auto_now=True)
#     # restaurant_id = models.IntegerField()
#     # customer_id = models.IntegerField()
#     # restaurant = models.ForeignKey(Restaurant, on_delete=models.CASCADE)
#     # customer_id = models.ForeignKey(Customer, on_delete=models.CASCADE)

#     def __str__(self):
#         return self.title
