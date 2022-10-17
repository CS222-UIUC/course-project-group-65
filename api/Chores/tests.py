import pytest

from django.urls import reverse

from Chores.models import Chore
from Chores.serializers import ChoreSerializer


@pytest.mark.django_db
def test_get_chores(client):
    url = reverse("chore-list")
    response = client.get(url)

    rooms = Chore.objects.all()
    expected = ChoreSerializer(rooms, many=True).data

    assert response.status_code == 200
    assert response.data == expected
