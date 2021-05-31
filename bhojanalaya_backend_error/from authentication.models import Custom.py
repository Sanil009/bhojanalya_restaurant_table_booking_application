    from authentication.models import Customer, Restaurant


def list(self, request):
        if request.user.is_active==False:
            return Response({'error': 'Bad Request'}, status=status.HTTP_400_BAD_REQUEST)
        elif request.user.is_restaurant:
            queryset = Bookings.objects.filter(customer=Restaurant.objects.get(user=self.request.user))
            serializer = BookingsSerializer(queryset, many=True, )
        elif request.user.is_active:
            queryset = Bookings.objects.all()
            serializer = BookingsSerializer(queryset, many=True, )
        else:
            queryset = Bookings.objects.all()
        serializer = BookingsSerializer(queryset, many=True, )
        return Response(serializer.data)