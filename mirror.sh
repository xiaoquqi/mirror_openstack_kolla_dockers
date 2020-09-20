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

for image in $(cat $CONF_FILE); do
  echo "docker pull $image:$BRANCH_NAME"
done
