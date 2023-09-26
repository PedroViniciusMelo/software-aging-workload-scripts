#!/bin/bash

image="docker.io/pedrmelo/software-aging"
max_runs=100
remove_image=0
image_tag="500mb"

#Not important, just to control the file name
display_name="software-aging-500mb"
local="local"

function pull_command() {
  local image_name=$1
  local image_tag=$2
  if [[ -z "$image_tag" ]]; then
    image_tag="latest"
  fi
  echo "docker pull $image_name:$image_tag"
}

function start_command() {
  local image_name=$1
  local image_tag=$2
  if [[ -z "$image_tag" ]]; then
    image_tag="latest"
  fi
  echo "docker run -d $image_name:$image_tag"
}

function stop_command() {
  local container_name=$1
  echo "docker stop $container_name"
}

function remove_image_command() {
  local image_name=$1
  local image_tag=$2
  if [[ -z "$image_tag" ]]; then
    image_tag="latest"
  fi
  echo "docker rmi $image_name:$image_tag"
}

function remove_container_command() {
  local container_name=$1
  echo "docker rm $container_name"
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