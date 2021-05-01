#!/bin/bash

cd packages
rm -f Dockerfile
echo "FROM $INSTANCE" >> Dockerfile
echo "WORKDIR /src" >> Dockerfile
echo "ENV DEBIAN_FRONTEND noninteractive" >> Dockerfile
sudo iptables -L DOCKER || ( echo "DOCKER iptables chain missing" ; sudo iptables -N DOCKER )
python test_packages.py
docker build .
