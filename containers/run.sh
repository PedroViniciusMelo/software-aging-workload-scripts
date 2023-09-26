#!/bin/bash
source config.sh
source commom.sh
container_id=""


if [ $remove_image -eq 0 ]; then
  if [ ! "$pull" ]; then
    echo "Erro ao baixar a imagem $image:$image_tag"
    exit 1
  fi
fi

while [[ $max_runs -gt 0 ]]; do
  if [ $remove_image -eq 1 ]; then
    pull_time=$(monitor_action pull_command)
  else
    pull_time=0
  fi

  is_image_available=$(docker images | grep "$image")

  if [ -n "$is_image_available" ]; then
    instantiate_time=$(monitor_action start_command)

    container_id=$(docker ps -a | grep "$image" | awk '{print $1}')
    stop_time=$(monitor_action stop_command "$container_id")

    container_removal_time=$(monitor_action remove_container_command "$container_id")

    if [ $remove_image -eq 1 ]; then
      image_removal_time=$(monitor_action remove_image_command)
    else
      image_removal_time=0
    fi

    display_date=$(get_date_time)
    echo "$pull_time;$instantiate_time;$stop_time;$container_removal_time;$image_removal_time;$display_date" >>"logs/$log_file"
    max_runs=$((max_runs - 1))
  fi
done
