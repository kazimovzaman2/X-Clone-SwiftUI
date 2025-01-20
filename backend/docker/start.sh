#!/bin/bash

set -o errexit
set -o pipefail
set -o nounset

python /code/x-clone/manage.py collectstatic --noinput
python /code/x-clone/manage.py migrate

exec gunicorn config.wsgi:application --bind 0.0.0.0:8000 --chdir=/code/x-clone --reload
