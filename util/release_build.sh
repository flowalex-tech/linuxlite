#!/bin/bash

version=$(cat VERSION | awk -F "=" '{print $2}')
docker build . -t flowalex/linuxlite:$version  --no-cache
docker push flowalex/linuxlite:$version
