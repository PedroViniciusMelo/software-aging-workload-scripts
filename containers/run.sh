#!/bin/bash
source config.sh
source commom.sh
informative=$1

if [ $remove_image -eq 0 ]; then
  pull_command
  image_available=$(is_image_available)
  if [ -z "$image_available" ]; then
    echo "Erro ao baixar a imagem $image:$image_tag"
    exit 1
  fi
fi

while [[ $max_runs -gt 0 ]]; do
  echo "Runs left: $max_runs"
  if [ $remove_image -eq 1 ]; then
    pull_time=$(pull_command)
  else
    pull_time=0
  fi

  if [ -n "$informative" ]; then
    echo "Pull time: $pull_time"
  fi

  image_available=$(is_image_available)

  if [ -n "$informative" ]; then
    echo "Image ID: $image_available"
  fi

  if [ -n "$image_available" ]; then
    instantiate_time=$(start_command)

    if [ -n "$informative" ]; then
      echo "Instantiate time: $instantiate_time"
    fi

    stop_time=$(stop_command)

    if [ -n "$informative" ]; then
      echo "Stop time: $stop_time"
    fi

    container_removal_time=$(remove_container_command)

    if [ -n "$informative" ]; then
      echo "Container remove time: $container_removal_time"
    fi

    if [ $remove_image -eq 1 ]; then
      image_removal_time=$(remove_image_command)
    else
      image_removal_time=0
    fi

    if [ -n "$informative" ]; then
      echo "Image remove time: $image_removal_time"
    fi

    display_date=$(get_date_time)
    echo "$pull_time;$instantiate_time;$stop_time;$container_removal_time;$image_removal_time;$display_date" >>"logs/$log_file"
    max_runs=$((max_runs - 1))
    image_available=""
  fi
  if [ -z "$informative" ]; then
    clear
  fi
done
