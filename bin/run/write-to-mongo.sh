#!/usr/bin/env bash

detectedjs=$1

IMPORT_FILE="tmp/results.json"
LOCAL_IMPORT_FILE=${PWD}"/"$IMPORT_FILE
CONTAINER_IMPORT_FILE="/app/"$IMPORT_FILE
CONTAINER_NAME="jss_mongodb"

# Write argument to file so it can be imported to mongo
rm "$LOCAL_IMPORT_FILE" 2> /dev/null
touch "$LOCAL_IMPORT_FILE"

# Unescape

echo -e "$detectedjs" | sed -E 's/\\(.)/\1/g' > "$LOCAL_IMPORT_FILE"

MONGO_DB_NAME="local"
MONGO_COLLECTION_NAME="run_"$(date +"%Y-%m-%d--%H-%M-%S")

echo "Local Import File: "
cat "$LOCAL_IMPORT_FILE"

docker run -ti --rm \
  --link ${CONTAINER_NAME}:mongodb \
  --volume "$LOCAL_IMPORT_FILE":"$CONTAINER_IMPORT_FILE" \
  mongo \
  sh -c 'exec mongoimport \
    --host "mongodb" \
    --port "27017" \
    --db "'${MONGO_DB_NAME}'" \
    --collection "'${MONGO_COLLECTION_NAME}'" \
    --upsert \
    --file "'${CONTAINER_IMPORT_FILE}'"'

echo ""
echo "Data was imported into MongoDB '$MONGO_DB_NAME', collection '$MONGO_COLLECTION_NAME'."
