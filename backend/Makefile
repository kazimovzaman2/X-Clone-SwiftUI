export DJANGO_READ_DOT_ENV_FILE=1

help:
	@echo "-----------------HELP-----------------"
	@echo "This project requires python for building."
	@echo "make install: installs the project dependencies (dev)."
	@echo "make install-no-dev: installs the project dependencies (no dev)."
	@echo "make run: runs the project."
	@echo "make makemigrations: creates migrations for all apps."
	@echo "make migrate: applies all migrations."
	@echo "--------------------------------------"

install:
	pip install -r requirements/local.txt

install-no-dev:
	pip install -r requirements/production.txt

run:
	python manage.py runserver

makemigrations:
	python manage.py makemigrations

migrate:
	python manage.py migrate

makemessages-en:
	python manage.py makemessages -l en --ignore env

makemessages-az:
	python manage.py makemessages -l az --ignore env

makemessages-ru:
	python manage.py makemessages -l ru --ignore env

makemessages:
	python manage.py makemessages -l en --ignore env
	python manage.py makemessages -l az --ignore env
	python manage.py makemessages -l ru --ignore env

compilemessages:
	python manage.py compilemessages
