#!/bin/bash
version=$(cat SNAPSHOT | awk -F "=" '{print $2}')
timestamp=$(date +%Y%m%d%H%M%S)
docker build . -t flowalex/linux_package_installer:$version-snapshot-$timestamp -t flowalex/linux_package_installer:latest --no-cache
docker push flowalex/linux_package_installer:latest
docker push flowalex/linux_package_installer:$version-snapshot-$timestamp
