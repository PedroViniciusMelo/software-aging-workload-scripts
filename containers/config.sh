#!/bin/bash

image="docker.io/pedrmelo/software-aging"
max_runs=100
remove_image=1
image_tag="500mb"

#Not important, just to control the file name
display_name="software-aging"
local="local"

function pull_command() {
  local start end total
  start=$(date +%s%N)

  docker pull "$image:$image_tag"  > /dev/null

  end=$(date +%s%N)
  total=$((end - start))
  echo $total
}

function start_command() {
  local start end total
  start=$(date +%s%N)

  docker run -d "$image:$image_tag"  > /dev/null

  end=$(date +%s%N)
  total=$((end - start))
  echo $total
}

function stop_command() {
  local start end total
  start=$(date +%s%N)

  docker container stop $(docker container ls -aq)  > /dev/null

  end=$(date +%s%N)
  total=$((end - start))
  echo $total
}

function remove_image_command() {
  local start end total
  start=$(date +%s%N)

  docker rmi "$image:$image_tag"  > /dev/null

  end=$(date +%s%N)
  total=$((end - start))
  echo $total
}

function remove_container_command() {
  local start end total
  start=$(date +%s%N)

  docker rm $(docker container ls -aq) > /dev/null

  end=$(date +%s%N)
  total=$((end - start))
  echo $total
}

function is_image_available() {
  local result
  result=$(docker image ls -a | grep "$display_name" | awk '{print $3}')
  echo "$result"
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

echo "pull;start;stop;rm_container;rm_image;time" >"logs/$log_file"
