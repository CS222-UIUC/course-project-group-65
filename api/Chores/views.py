from rest_framework import generics
from Chores.serializers import ChoreSerializer

from .models import Chore

# Create your views here.


class ChoreList(generics.ListCreateAPIView):
    queryset = Chore.objects.all()
    serializer_class = ChoreSerializer


# GET (one), PUT, and DELETE
class ChoreDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Chore.objects.all()
    serializer_class = ChoreSerializer
