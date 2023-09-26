#!/bin/bash

function get_date_time() {
  local date_time
  date_time=$(date "+%Y-%m-%d %H:%M:%S")
  echo "$date_time"
}

function monitor_action() {
  local action start end total
  action=$1
  start=$(date +%s%N)

  if [ ! "$action" ] ; then
    echo 0
  fi

  end=$(date +%s%N)
  total=$((end - start))
  echo $total
}


function progress {
  _progrees=$((($1 * 10000 / $2) / 100))
  _done=$((($_progrees * 6) / 10))
  _left=$((60 - $_done))
  _fill=$(printf "%${_done}s")
  _empty=$(printf "%${_left}s")
  RED='\033[0;31m'
  BLUE='\033[0;34m'
  NC='\033[0m'
  GREEN='\033[0;32m'
  if [ $errcount -gt 0 ]; then
    printf "\r$1 / $2 : ${RED}${_fill// /#}${_empty// /-} ${_progrees}%% ${errcount} errors${NC}"
  else
    printf "\r$1 / $2 : ${GREEN}${_fill// /#}${_empty// /-} ${_progrees}%%${NC}"
  fi
}