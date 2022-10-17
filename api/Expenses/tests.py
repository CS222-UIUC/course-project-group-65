import pytest

from django.urls import reverse

from Expenses.models import Expense
from Expenses.serializers import ExpenseSerializer


@pytest.mark.django_db
def test_get_expenses(client):
    url = reverse("expense-list")
    response = client.get(url)

    rooms = Expense.objects.all()
    expected = ExpenseSerializer(rooms, many=True).data

    assert response.status_code == 200
    assert response.data == expected
