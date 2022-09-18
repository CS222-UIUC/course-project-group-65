from rest_framework import serializers
from .models import Room


# This class i believe is an inherited class from the ModelSerializer
class RoomSerializer(serializers.ModelSerializer):
    name = serializers.CharField(max_length=45, default="")
    num_members = serializers.IntegerField(default=0)
    chore_cycle_len = serializers.IntegerField(default=0)
    set_up = serializers.BooleanField(default=0)

    # Creates new item in database
    def create(self, data):
        return Room.objects.create(
            name = data.get('name'),
            num_members = data.get('num_members'),
            chore_cycle_len = data.get('chore_cycle_len'),
            set_up = data.get('set_up') 
        )
    
    # Updates item in database
    def update(self, instance, data):
        instance.name = data.get('name', instance.name)
        instance.num_members = data.get('num_members', instance.num_members)
        instance.chore_cycle_len = data.get('chore_cycle_len', instance.chore_cycle_len)
        instance.set_up = data.get('set_up', instance.set_up)

        instance.save()
        return instance

    class Meta:
        model = Room
        fields = (
            'id',
            'name',
            'num_members',
            'chore_cycle_len',
            'set_up'
        )