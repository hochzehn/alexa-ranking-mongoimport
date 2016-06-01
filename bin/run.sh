#!/usr/bin/env bash

# Fill Queue
bin/fill_queue.sh

# Read from RestMQ
detectedjs=$(bin/run/load-from-restmq.sh)

# Write to Mongo
bin/run/write-to-mongo.sh "$detectedjs"
