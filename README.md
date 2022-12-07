# Group 65

RoomHub is an iOS application to make organizing roommate activities and tasks more centralized. Users will be able to create rooms, in which chores can be assigned
to roommates, expenses can be tracked, and memos can be written. 

# Technical Architecture
Backend: We will write the backend API using Python with the Django framework. The backend will receive HTTP requests from the frontend in order to communicate with the MySQL database. In out MySQL database, we have We can test this using the built in django/python testing.
Frontend: We will be programming in Swift and using Xcode as our IDE. We are using SwiftUI and Firebase as well. This will be for creating the UI and frontend functionality. This will be tested with the XCTest framework 


# Set Up Info
- clone/pull from repository
- run `pip install -r requirements.txt`
- start the server from the instructions below

Make an app: `python3 manage.py startapp APPNAME`
Migrate from models to migrations: `python3 manage.py makemigrations APPNAME`
Migrate up to database: `python3 manage.py migrate`

# Group Member Roles
Backend: 
  Saloni- connecting backend and frontend
  Devanshi- algorithmic development and testing
Frontend: 
  Nikhila- UI development of login,landing,home pages
  Deeya- stylized elements for expenses, chores, and memo pages
