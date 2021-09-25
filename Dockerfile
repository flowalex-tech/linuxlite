FROM python:3.9.7-slim-bullseye
RUN  unset -v PYTHONPATH

LABEL version="0.4.2"
LABEL maintainer="Alex Wolf"

RUN adduser --disabled-password --gecos ''  lilite

WORKDIR /home/lilite

COPY . .

RUN python -m venv venv

# hadolint ignore=DL3018,DL3005,DL3059
RUN apt-get update && apt-get upgrade -y \
  && rm -rf /var/lib/apt/lists/*

# hadolint ignore=DL3013,DL3042,DL3059
RUN python3 -m ensurepip --upgrade && pip install --trusted-host pypi.python.org --upgrade setuptools pip \
    && python3 -m pip install --no-cache-dir --trusted-host pypi.python.org -r requirements.txt \
    && venv/bin/pip --no-cache-dir install gunicorn

# hadolint ignore=DL3059
RUN chmod +x boot.sh

# hadolint ignore=DL3059
RUN chown -R lilite:lilite ./

USER lilite

EXPOSE 5000

ENTRYPOINT ["./boot.sh"]
