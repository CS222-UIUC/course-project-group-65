# Makefile for common commands.

slay:
	echo "😈"

start:
	python3 manage.py runserver

# these commands will only work if docker-compose up has been run before
# run docker ps to find the container ids.
web:
	docker exec -it 435cf62d631a bash

db:
	docker exec -it e9903b442277 bash


# run `make git m="message"`
git:
	git add .
	git commit -m "$m"
	git push origin main