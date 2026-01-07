#! /bin/sh

docker run \
  -v $PWD:/usr/src/onigmo \
  --rm -it onigmo:latest
