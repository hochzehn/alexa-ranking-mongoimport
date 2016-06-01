#!/usr/bin/env bash

docker rm -f hochzehn_restmq
docker run -d -p 6379:6379 -p 8888:8888 --name hochzehn_restmq pablozaiden/restmq

cd ../alexa-ranking-parser
docker-compose run --rm parser 8

cd ../alexa-ranking-worker
docker-compose scale worker=2


echo "Waiting for all workers to finish...."
running=true
while "$running";
do
  worker_running=$(docker ps | grep "worker")
  if [ -n "$worker_running" ]; then
    echo -n " "$(echo "$worker_running" | wc -l)
    sleep 5
  else
    running=false
  fi
done

docker-compose rm -f worker
