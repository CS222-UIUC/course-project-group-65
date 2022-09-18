# gets from python
# makes sure terminal outputs are not buffere and come in real time
# creates new folder in container called app which is project root in container
# copies the requirements.txt into the app file
# installs the requriments
# adds the content of the project into the app folder

FROM python:3.10 
ENV PYTHONUNBUFFERED 1
WORKDIR /app
COPY requirements.txt /app/requirements.txt
RUN pip install -r requirements.txt
COPY . /app
