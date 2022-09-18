from django.urls import include, path
from . import views
from rest_framework.routers import DefaultRouter

# router = DefaultRouter()
# router.register(r'userexpense', views.UserExpenseViews)
# router.register(r'expense', views.ExpenseViews)

urlpatterns = [
    path('', views.ExpenseList.as_view(), name='expense-list'),
    path('<int:pk>', views.ExpenseDetail.as_view(), name='expense-detail'),
    path('user', views.UserExpenseList.as_view(), name='userexpense-list'),
    path('user/<int:pk>', views.UserExpenseDetail.as_view(), name='userexpense-detail')
]
