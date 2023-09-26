#!/bin/bash

image="docker.io/pedrmelo/software-aging"
max_runs=100
remove_image=1
image_tag="500mb"

#Not important, just to control the file name
display_name="software-aging"
local="local"

function pull_command() {
  docker pull "$image:$image_tag"
}

function start_command() {
  docker run -d "$image:$image_tag"
}

function stop_command() {
  docker container stop $(docker container ls -aq)
}

function remove_image_command() {
  docker rmi "$image:$image_tag"
}

function remove_container_command() {
  docker rm $(docker container ls -aq)
}

mkdir -p "logs"

if [ $remove_image -eq 1 ]; then
  if [ "$local" == "local" ]; then
    log_file="$display_name-rmi-local-$(date +%Y%m%d%H%M%S).csv"
  else
    log_file="$display_name-rmi-$(date +%Y%m%d%H%M%S).csv"
  fi
else
  log_file="$display_name-$(date +%Y%m%d%H%M%S).csv"
fi

echo "pull;start;stop;rm_container;rm_image;time" > "logs/$log_file"