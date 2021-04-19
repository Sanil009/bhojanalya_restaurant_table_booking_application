from django.shortcuts import render
import bookings
from rest_framework import viewsets
from django.http import JsonResponse
from rest_framework.decorators import api_view
from rest_framework.response import Response
from .serializers import BookingsSerializer
from bookings import serializers
from .models import Bookings

# Create your views here.


@api_view(['GET'])
def apiOverview(request):
    api_urls = {
        'List':'/bookings-list',
        'Detail View':'/bookings-detail/<str:pk/>',
        'Create':'bookings-create/',
        'Delete':'/bookings-delete/<str:pk>/',
    }
    return Response(api_urls)


@api_view(['GET'])
def bookingsList(request):
    tasks = Bookings.objects.all()
    serializer = BookingsSerializer(bookings, many=True)
    return Response(serializer.data)

@api_view(['GET'])
def bookingsDetail(request, pk):
    bookings = Bookings.objects.get(id=pk)
    serializer = BookingsSerializer(bookings, many=True)
    return Response(serializer.data)

@api_view(['POST'])
def bookingsCreate(request):
    serializer = BookingsSerializer(data=request.data)

    if serializer.is_valid():
        serializer.save()

    return Response(serializer.data)


@api_view(['POST'])
def bookingsUpdate(request, pk):
    bookings = Bookings.objects.get(id=pk)
    serializer = BookingsSerializer(instance=bookings, data=request.data)

    if serializer.is_valid():
        serializer.save()

    return Response(serializer.data)


@api_view(['DELETE'])
def bookingsDelete(request, pk):
    bookings = Bookings.objects.get(id=pk)
    bookings.delete()

    return Response("Item Successfully Deleted")


# class BookingsViewSet(viewsets.ModelViewSet):

#     def get_queryset(self):
#         if self.request.user.is_restaurant:
#             return Bookings.objects.filter(assigned_to=self.request.user)
#         return Bookings.objects.all()

#     def get_serializer_class(self):
#         if self.action in ['create', 'update']:
#             serializer_class = AppointmentLogSer
#         elif self.action == 'get_treatment':
#             serializer_class = TreatmentSer
#         else:
#             serializer_class = AppointmentSer
#         return serializer_class

#     def get_permissions(self):
#         if self.action == 'create':
#             permission_classes = [IsHelpdesk]
#         elif self.action in ['update', 'partial_update']:
#             permission_classes = [IsHelpdeskOrAssignedDoctor]
#         else:
#             permission_classes = [IsStaffOrAssignedDoctor]
#         return [permission() for permission in permission_classes]

#     @action(methods=['GET'], detail=True, url_path='treatment')
#     def get_treatment(self, request, pk=None):
#         appointment = self.get_object()
#         try:
#             treatment = Treatment.objects.get(appointment=appointment)
#             serializer = self.get_serializer(treatment)
#             return Response(serializer.data)
#         except Treatment.DoesNotExist:
#             return Response({'detail': 'No Booking Found'}, status=HTTP_404_NOT_FOUND)









# class BookingViewset(viewsets.ModelViewSet):
#     serializer_class = BookingSerializer

#     def get_queryset(self):
#         queryset = Booking.objects.all()
#         customer = self.request.query_params.get('customer_id', None)
#         if customer is not None:
#             queryset = queryset.filter(organizer__customer_id=customer)
#         return queryset
