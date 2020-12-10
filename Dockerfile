FROM python:3.9.1-alpine

RUN adduser -D lilite

WORKDIR /home/lilite

COPY requirements.txt requirements.txt
RUN python -m venv venv
RUN python -m pip install --upgrade pip
RUN rm -rf /var/cache/apk/* && \
    rm -rf /tmp/*
RUN apk update && \
 apk add --no-cache postgresql-libs && \
 apk add --no-cache --virtual .build-deps gcc musl-dev postgresql-dev
RUN python3 -m pip install -r requirements.txt
RUN venv/bin/pip install gunicorn

COPY . .
RUN chmod +x boot.sh

RUN chown -R lilite:lilite ./
USER lilite

EXPOSE 5000
ENTRYPOINT ["./boot.sh"]

