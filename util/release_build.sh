#!/bin/bash

version=$(cat VERSION | awk -F "=" '{print $2}')
docker build . -t flowalex/linux_package_installer:$version  --no-cache
docker push flowalex/linux_package_installer:$version
