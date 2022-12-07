from django.urls import path
from . import views

urlpatterns = [
    path("", views.MemoList.as_view(), name="memo-list"),
    path("<int:pk>", views.MemoDetail.as_view(), name="memo-detail"),
]
