#!/bin/bash

timestamp=$(date +%Y%m%d%H%M%S)

docker build . -t flowalex/linuxlite:$timestamp -t flowalex/linuxlite:latest --no-cache
#docker push flowalex/linuxlite:latest
#docker push flowalex/linuxlite:$timestamp
