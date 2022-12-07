import pytest

from django.urls import reverse

from Memos.models import Memo
from Memos.serializers import MemoSerializer


@pytest.mark.django_db
def test_get_memos(client):
    url = reverse("memo-list")
    response = client.get(url)

    rooms = Memo.objects.all()
    expected = MemoSerializer(rooms, many=True).data

    assert response.status_code == 200
    assert response.data == expected
