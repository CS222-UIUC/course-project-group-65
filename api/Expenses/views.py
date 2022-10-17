from rest_framework import generics
from Expenses.serializers import ExpenseSerializer, UserExpenseSerializer

from .models import Expense
from .models import UserExpense

# Create your views here.

# GET (all) and POST
class ExpenseList(generics.ListCreateAPIView):
    queryset = Expense.objects.all()
    serializer_class = ExpenseSerializer


# GET (one), PUT, and DELETE
class ExpenseDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Expense.objects.all()
    serializer_class = ExpenseSerializer


# GET (all) and POST
class UserExpenseList(generics.ListCreateAPIView):
    queryset = UserExpense.objects.all()
    serializer_class = UserExpenseSerializer


# GET (all) and POST
class UserExpenseDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = UserExpense.objects.all()
    serializer_class = UserExpenseSerializer


"""
When creating a new expense in the UI, we're gonna get the info of who added it and who its assign to.
So, when requesting to the api, we're gonna send a post request with the data of the new expense, and then another post request
What will this other post request look like?
{
    "user-id": 1,
    "expense-id": 1,
    "splitCost": 8.32,
    "paid": false
}
okay. so for each person who is assigned the expense,
we get the expense id after creating the expense (the post request)
then the split cost is calculated in frontend
and the paid is set to false

Then, if that specific user hits the paid button (and its approved), then 
another put requdest to change this info to paid.
Then, another request from the frontend if the info

"""


# This is an older and more handholdy way of doing the CRUD ops in django
# technically works the same as above just with way more code

# class ExpensesViews(APIView, UpdateModelMixin, DestroyModelMixin):

#     # [GET] Method
#     def get(self, request, id=None):
#         # if you get an id, find that specific expense
#         if id:
#             try:
#                 expense = Expense.objects.get(id=id) # find it
#             except Expense.DoesNotExist:
#                 return Response({"errors": "expense with that id does not exist"}, status=400)

#             serializer = ExpenseSerializer(expense) # read it
#         # Otherwise, list all expenses
#         else:
#             expenses = Expense.objects.all() # find all
#             serializer = ExpenseSerializer(expenses, many=True) # read all

#         # send response with expense(s)
#         return Response({'data': serializer.data}, status=201)

#     # [POST] Method
#     def post(self, request):

#          # creates object w/ request json data
#         create_serializer = ExpenseSerializer(data=request.data)

#         if create_serializer.is_valid():
#             expense = create_serializer.save() # save to database

#             #### NEED TO UPDATE USER TABLE
#             #### NEED TO UPDATE USER_EXPENSE TABLE

#             read_serializer = ExpenseSerializer(expense)
#              # send response with expense
#             return Response({'data': read_serializer.data})


#         # Error
#         return Response(create_serializer.errors, status=400)

#     # [PUT] Method
#     def put(self, request, id=None):
#         # check if expense w/ id exists
#         try:
#             expense = Expense.objects.get(id=id) # find it
#         except Expense.DoesNotExist:
#             return Response({"error": "expense with that id does not exist"}, status=400)

#         # validate update data
#         update_serializer = ExpenseSerializer(expense, data=request.data)

#         # update the entry in the database and read out/send response
#         if update_serializer.is_valid():
#             expense = update_serializer.save()
#             read_serializer = ExpenseSerializer(expense)
#             return Response(read_serializer.data, status=200)

#         # error
#         return Response(read_serializer.errors, status=400)


#     # [DELETE] Method
#     def delete(self, request, id=None):
#         # check if expense w/ that id exists
#         try:
#             expense = Expense.objects.get(id=id)
#         except Expense.DoesNotExist:
#             return(Response({"error": "expense with that id does not exist"}, status=400))

#         # delete it.
#         expense.delete()

#         return Response(status=204)
