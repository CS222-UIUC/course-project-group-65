from rest_framework import serializers
from .models import Expense
from .models import UserExpense


# This class i believe is an inherited class from the ModelSerializer
class ExpenseSerializer(serializers.ModelSerializer):
    name = serializers.CharField(max_length=45, required=True)
    amount = serializers.FloatField(required=True)
    paid = serializers.BooleanField(required=False)
    date = serializers.DateTimeField(required=True)
    category = serializers.CharField(max_length=45, required=True)

    # Creates new item in database
    def create(self, data):
        return Expense.objects.create(
            name = data.get('name'),
            amount = data.get('amount'),
            paid = data.get('paid'),
            date = data.get('date'),
            category = data.get('category'),
            room = data.get('room')

        )
    
    # Updates item in database
    def update(self, instance, data):
        instance.name = data.get('name', instance.name)
        instance.amount = data.get('amount', instance.amount)
        instance.paid = data.get('paid', instance.paid)
        instance.date = data.get('date', instance.date)
        instance.category = data.get('category', instance.category)
        instance.room = data.get('room', instance.room)

        instance.save()
        return instance

    class Meta:
        model = Expense
        fields = (
            'id',
            'name',
            'amount',
            'paid',
            'date',
            'category',
            'room'
        )



class UserExpenseSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserExpense
        fields = [
            'id',
            'expense',
            'splitCost',
            'paid'
        ]