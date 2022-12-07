from rest_framework import serializers
from .models import User


# This class i believe is an inherited class from the ModelSerializer
class UserSerializer(serializers.ModelSerializer):
    name = serializers.CharField(max_length=45, default="")
    nickname = serializers.CharField(max_length=45, default="")
    email = serializers.CharField(max_length=90, default="")
    available = serializers.CharField(max_length=45, default="")
    expenses_amt = serializers.FloatField(default=0)
    room_admin = serializers.BooleanField(default=0)
    # room = serializers.ForeignKey('Rooms.room', on_delete=models.SET_DEFAULT, default=1) # connects to room table -> foreign key
    chore_weight = serializers.IntegerField(default=1)

    # Creates new item in database
    def create(self, data):
        return User.objects.create(
            name=data.get("name"),
            nickname=data.get("nickname"),
            email=data.get("email"),
            available=data.get("available"),
            expenses_amt=data.get("expenses_amt"),
            chore_weight=data.get("chore_weight"),
            room_admin=data.get("room_admin"),
        )

    # Updates item in database
    def update(self, instance, data):
        instance.name = data.get("name", instance.name)
        instance.nickname = data.get("nickname", instance.nickname)
        instance.email = data.get("email", instance.email)
        instance.available = data.get("available", instance.available)
        instance.expenses_amt = data.get("expenses_amt", instance.expenses_amt)
        instance.chore_weight = data.get("chore_weight", instance.chore_weight)
        instance.room_admin = data.get("room_admin", instance.room_admin)
        instance.save()
        return instance

    class Meta:
        model = User
        fields = (
            "id",
            "name",
            "nickname",
            "email",
            "available",
            "expenses_amt",
            "room",
            "room_admin",
            "chore_weight",
        )
