#!/bin/bash

CMD="docker run \
       --rm \
       --name valut \
       --net "host" \
       --user 1000:1000 \
       --volume $HOME:/home/developer \
       --volume $(pwd):/pwd \
       kurron/docker-vault:latest"

#echo $CMD
eval $CMD $*
