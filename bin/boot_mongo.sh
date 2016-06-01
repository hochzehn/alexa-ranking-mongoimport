#!/usr/bin/env bash

# Boot mongo.

docker run -d -p 27117:27017 --name jss_mongodb mongo:3.2.6
