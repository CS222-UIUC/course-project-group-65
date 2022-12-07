from django.urls import path
from . import views


urlpatterns = [
    path("", views.ChoreList.as_view(), name="chore-list"),
    path("<int:pk>", views.ChoreDetail.as_view(), name="chore-detail"),
]
