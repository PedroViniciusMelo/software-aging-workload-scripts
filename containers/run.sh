#!/bin/bash
source config.sh
source commom.sh
container_id=""

pull=$(pull_command "$image" "$image_tag")
instantiate=$(start_command "$image" "$image_tag")
image_removal=$(remove_image_command "$image" "$image_tag")

if [ $remove_image -eq 0 ]; then
  if [ ! "$pull" ]; then
    echo "Erro ao baixar a imagem $image:$image_tag"
    exit 1
  fi
fi

while [[ $max_runs -gt 0 ]]; do
  if [ $remove_image -eq 1 ]; then
    pull_time=$(monitor_action "$pull")
  else
    pull_time=0
  fi

  is_image_available=$(docker images | grep "$image")

  if [ -n "$is_image_available" ]; then
    instantiate_time=$(monitor_action "$instantiate")

    container_id=$(docker ps -a | grep "$image" | awk '{print $1}')
    stop=$(stop_command "$container_id")
    stop_time=$(monitor_action "$stop")

    container_removal=$(remove_container_command "$container_id")
    container_removal_time=$(monitor_action "$container_removal")

    if [ $remove_image -eq 1 ]; then
      image_removal_time=$(monitor_action "$image_removal")
    else
      image_removal=0
    fi

    display_date=$(get_date_time)
    echo "$display_date;$pull_time;$instantiate_time;$stop_time;$container_removal_time;$image_removal_time" >>"logs/$log_file"
    max_runs=$((max_runs - 1))
  fi
done
