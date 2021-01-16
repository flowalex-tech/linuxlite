FROM python:3.9.1-alpine

LABEL version="0.3"
LABEL maintainer="Alex Wolf"

RUN adduser -D lilite

WORKDIR /home/lilite

COPY . .

RUN python -m venv venv

# hadolint ignore=DL3013
RUN python -m ensurepip --upgrade && pip install --trusted-host pypi.python.org --upgrade setuptools pip

RUN rm -rf /var/cache/apk/* && \
    rm -rf /tmp/*

# hadolint ignore=DL3018
RUN apk update && \
 apk add --no-cache postgresql-libs && \
 apk add --no-cache --virtual .build-deps gcc musl-dev postgresql-dev

RUN python3 -m pip install --no-cache-dir --trusted-host pypi.python.org -r requirements.txt

RUN venv/bin/pip --no-cache-dir install gunicorn

RUN chmod +x boot.sh

RUN chown -R lilite:lilite ./

USER lilite

EXPOSE 5000

ENTRYPOINT ["./boot.sh"]
