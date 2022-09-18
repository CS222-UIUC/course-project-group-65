from rest_framework import generics
from Rooms.serializers import RoomSerializer

from .models import Room

# Create your views here.

class RoomList(generics.ListCreateAPIView):
    queryset = Room.objects.all()
    serializer_class = RoomSerializer

# GET (one), PUT, and DELETE
class RoomDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Room.objects.all()
    serializer_class = RoomSerializer
