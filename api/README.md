# slayOS_backend

## Set Up Info
- clone/pull from repository
- run `pip install -r requirements.txt`
- start the server from the instructions below

I think this should be enough (all the tutorials were asking for database migrations but we dont have any yet so i think it should be fine) If this doesnt work, then you might need to install django: `pip install django`. Also, if the test.py file gives you trouble, just delete it/comment the whole thing out


Make an app: `python3 manage.py startapp APPNAME`
Migrate from models to migrations: `python3 manage.py makemigrations APPNAME`
Migrate up to database: `python3 manage.py migrate`



## Folder Structure:
- slayos_backend -> main project file
    - slayosbackend (the inner one) -> project config stuff
    - expenses-> the actual app [^note]
        - admin.py -> adds models and stuff to admin interface [^note2]
        - apps.py -> i beleive this is just config settings
        - migrations -> holds database migrations
        - models.py -> database layout and metadata
        - tests.py -> holds unit tests <3
        - ursl.py -> holds the urls for the paths in this api and what function they'll call
        - views.py -> holds what youre gonna send as a request/get as response
    - docker-compose.yml -> contains the docker-compose file for the config stuff for docker
    - Dockerfile -> holds scripts to set up docker for app
    - Makefile -> run `make [command]` to run simplified commands
    - manage.py -> scripts for cli 
    - README.md (this file!)
    - requirements.txt -> holds python dependencies
    - test.py -> okay ignore this i was just messing with sql connector that first day

## Starting the Server
Run `python manage.py runserver` or `python3 manage.py runserver` in the outer slayosbackend folder. Server starts on http://localhost:8000/

(also check out http://localhost:8000/slay)


## Models
	
class User(models.Model):
    name = models.CharField(max_length=45)
    nickname = models.CharField(max_length=45)
    email = models.CharField(max_length=90)
    available = models.CharField(max_length=45)
    expenses_amt = models.FloatField()
    room_id = models.ForeignKey('Rooms.room', on_delete=models.SET_DEFAULT, default=0) # connects to room table -> foreign key
    chore_weight = models.IntegerField()

[^note]: depending on some further research and how big the programs will be we might have separate "apps" for expenses, chores, etc. but idk rn so im keeping it all in one for rn.

[^note2]: We can look more into the admin stuff it seems useful in general, but idk if for our project