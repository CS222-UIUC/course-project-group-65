# Makefile for common commands.

slay:
	echo "😈"

start:
	python3 manage.py runserver

# these commands will only work if docker-compose up has been run before
# run docker ps to find the container ids.
web:
	docker exec -it a28d9a252f43 bash

db:
	docker exec -it 956bb7b24a1a bash


# run `make git m="message"`
git:
	git add .
	git commit -m "$m"
	git push origin main