from rest_framework import serializers
from .models import Memo
from Rooms.serializers import RoomSerializer

# This class i believe is an inherited class from the ModelSerializer
class MemoSerializer(serializers.ModelSerializer):
    text = serializers.CharField()
    # user_id = serializers.ForeignKey('User', default=1) # connects to user table -> foreign key
    editable = serializers.BooleanField()

    # Creates new item in database
    def create(self, data):
        return Memo.objects.create(
            text=data.get("text"), editable=data.get("editable"), room=data.get("room")
        )

    # Updates item in database
    def update(self, instance, data):
        instance.text = data.get("text", instance.text)
        instance.editable = data.get("editable", instance.editable)
        instance.room = data.get("room", instance.room)

        instance.save()
        return instance

    class Meta:
        model = Memo
        fields = ("id", "text", "editable", "room", "user")
