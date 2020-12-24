#!/bin/bash

docker build . -t linuxlite_local:latest

docker run -p 5000:5000 -d linuxlite_local:latest
