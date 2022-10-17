import pytest

from django.urls import reverse

from Rooms.models import Room
from Rooms.serializers import RoomSerializer


@pytest.mark.django_db
def test_get_rooms(client):
    url = reverse("room-list")
    response = client.get(url)

    rooms = Room.objects.all()
    expected = RoomSerializer(rooms, many=True).data

    assert response.status_code == 200
    assert response.data == expected


'''
{
    "name": "test room",
    "num_members": 4,
    "chore_cycle_len": 7,
    "set_up": 0
}


'''