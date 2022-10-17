from rest_framework import generics
from Memos.serializers import MemoSerializer

from .models import Memo

# Create your views here.


class MemoList(generics.ListCreateAPIView):
    queryset = Memo.objects.all()
    serializer_class = MemoSerializer


# GET (one), PUT, and DELETE
class MemoDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Memo.objects.all()
    serializer_class = MemoSerializer
