import pytest

from django.urls import reverse

from Users.models import User
from Users.serializers import UserSerializer


@pytest.mark.django_db
def test_get_users(client):
    url = reverse("user-list")
    response = client.get(url)

    rooms = User.objects.all()
    expected = UserSerializer(rooms, many=True).data

    assert response.status_code == 200
    assert response.data == expected

@pytest.mark.django_db
def test_post_users(client):
    url = reverse("user-list")
    response = client.post(url)

    rooms = User.objects.all()
    expected = UserSerializer(rooms, many=True).data

    assert response.status_code == 200
    assert response.data == expected

'''
{
    "name": "Bob Bob",
    "nickname": "bo",
    "email": "bob@bob.com",
    "available": 0,
    "expenses_amt": 0,
    "room_admin": 0,
    "room": 5,
    "chore weight": 1
}
'''