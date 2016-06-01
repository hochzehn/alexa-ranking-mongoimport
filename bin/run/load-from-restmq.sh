#!/usr/bin/env bash

restmq="192.168.99.100"
DOWNLOAD_URL="http://$restmq:8888/q/detectedjs"
TARGET_DIR=tmp
TARGET_FILE="$TARGET_DIR/queue_extract.txt"

touch "$TARGET_FILE"

shouldRun=true
while [ "$shouldRun" = true ]; do

    # Load json from RestMQ
    result=$(curl -s "$DOWNLOAD_URL")

    #Extract value from json result
    detectedjs=$(echo "$result" | sed -e 's/^.*"value": "\(.*\)".*$/\1/')


    if [ -z "$detectedjs" ]; then
        shouldRun=false
    else
        echo $detectedjs >> "$TARGET_FILE"
    fi
done

cat "$TARGET_FILE"
rm  "$TARGET_FILE" &> /dev/null
