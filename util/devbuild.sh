#!/bin/bash

timestamp=$(date +%Y%m%d%H%M%S)
docker build . -t flowalex/linux_package_installer:dev-$timestamp -t flowalex/linux_package_installer:latest --no-cache
docker push flowalex/linux_package_installer:latest
docker push flowalex/linux_package_installer:dev-$timestamp
