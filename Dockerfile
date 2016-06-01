FROM alpine:3.3

RUN apk add --no-cache \
  bash \
  unzip \
  parallel \
  curl

ADD . /opt/app
VOLUME ./tmp /opt/app/tmp

WORKDIR /opt/app

ENTRYPOINT ["bin/run.sh"]
