#!/bin/bash

#
# Mirror OpenStack Dockers to target Docker Repo
#

CURRENT_PATH=$(cd `dirname $0`; pwd)

BRANCH_NAME=$1
TARGET_REPO=$2

if [[ "x$BRANCH_NAME" == "x" ]] && [[ "x$TARGET_REPO" == "x" ]]; then
  echo "Usage: $(dirname $0) <branch name> <target repo>"
  exit 1
fi

CONF_FILE=$CURRENT_PATH/$BRANCH_NAME.list
if [[ ! -e $CONF_FILE ]]; then
  echo "Can not find $CONF_FILE, exiting..."
  exit 1
fi

docker login --username $DOCKER_USERNAME --password $DOCKER_PASSWORD

for image in $(cat $CONF_FILE); do
  source_docker_repo="$image:$BRANCH_NAME"
  target_docker_repo="$TARGET_REPO/$(basename $image):$BRANCH_NAME"
  docker pull $source_docker_repo
  docker tag $source_docker_repo $target_docker_repo
  docker push $target_docker_repo
done
