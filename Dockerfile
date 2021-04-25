FROM python:3.9.4-slim-buster
RUN  unset -v PYTHONPATH

LABEL version="0.4"
LABEL maintainer="Alex Wolf"
LABEL UUID="9347b232-1f14-486b-b63d-51fecead8bf0"

RUN adduser  lilite

WORKDIR /home/lilite

COPY . .

RUN python -m venv venv

# hadolint ignore=DL3018,DL3005
RUN apt-get update && apt-get upgrade \
  && rm -rf /var/lib/apt/lists/*

# hadolint ignore=DL3013,DL3042
RUN python3 -m ensurepip --upgrade && pip install --trusted-host pypi.python.org --upgrade setuptools pip \
    && python3 -m pip install --no-cache-dir --trusted-host pypi.python.org -r requirements.txt \
    && venv/bin/pip --no-cache-dir install gunicorn

RUN chmod +x boot.sh

RUN chown -R lilite:lilite ./

USER lilite

EXPOSE 5000

ENTRYPOINT ["./boot.sh"]
