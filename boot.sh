#!/bin/sh
source venv/bin/activate

python packages/seed_packages.py
exec gunicorn -b :5000 --workers=2 --threads=4 --worker-class=gthread --access-logfile - --error-logfile - app:app
