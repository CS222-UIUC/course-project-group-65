from rest_framework import serializers
from .models import Chore


# This class i believe is an inherited class from the ModelSerializer
class ChoreSerializer(serializers.ModelSerializer):
    name = serializers.CharField(max_length=45, default="")
    completed = serializers.BooleanField(default=0)
    weight = serializers.IntegerField(default=0)

    # Creates new item in database
    def create(self, data):
        return Chore.objects.create(
            name = data.get('name'),
            completed = data.get('completed'),
            weight = data.get('weight'),
            room = data.get('room')
        )
    
    # Updates item in database
    def update(self, instance, data):
        instance.name = data.get('name', instance.name)
        instance.completed = data.get('completed', instance.completed)
        instance.weight = data.get('weight', instance.weight)
        instance.room = data.get('room', instance.room)

        instance.save()
        return instance

    class Meta:
        model = Chore
        fields = (
            'id',
            'name',
            'completed',
            'weight',
            'room'
        )