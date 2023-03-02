#!/bin/bash

# ./run.sh 1GB docker.io/1GB 100 docker 1
imagem=$1
imagemsrc=$2
repetitions=$3
errcount=0
script=$4

function get_date_time() {
  date_time=($(date +"%F %H-%M-%S"))
  current_date=${date_time[0]}
  current_time=${date_time[1]}
}

function progress {
  _progrees=$((($1 * 10000 / $2) / 100))
  _done=$((($_progrees * 6) / 10))
  _left=$((60 - $_done))
  _fill=$(printf "%${_done}s")
  _empty=$(printf "%${_left}s")

  NC='\033[0m'
  GREEN='\033[0;32m'

  printf "\r$1 / $2 : ${GREEN}${_fill// /#}${_empty// /-} ${_progrees}%% ${errcount} errors${NC}"
}

mkdir -p "logs"
mkdir -p "logs/$script"
get_date_time

log_erro="logs/$script/log-erro-$script-$imagem-${current_date}_$current_time.csv"
log_arquivo="logs/$script/log-$script-$imagem-${current_date}_$current_time.csv"
echo $script | grep -q "rmi"
rmi=$?

echo "count,pull_time,instantiate_time,stop_time,container_removal_time,image_removal_time,date,time" >$log_arquivo
echo "message,reason,date,time" >$log_erro

count=0
hasError=0

source "./scripts/$script.sh"

echo "Iniciando o teste $script.sh com $repetitions repetições"

progress $count $repetitions

pull

while [ $count -lt $repetitions ]; do

  if add_container; then
    if [ $rmi -eq 0 ]; then
      sleep 30
    else
      sleep 10
    fi
    if remove_container; then
      get_date_time
      if [ $rmi -eq 0 ]; then
        echo "$count,$pull_time,$instantiate_time,$stop_time,$container_removal_time,$image_removal_time,$current_date,$current_time" >>$log_arquivo
      else
        echo "$count,0,$instantiate_time,$stop_time,$container_removal_time,0,$current_date,$current_time" >>$log_arquivo
      fi
    fi
  fi
  if [ $rmi -eq 0 ]; then
    sleep 60
  else
    sleep 20
  fi
  if [ $hasError -eq 1 ]; then
    get_date_time
    echo "Algum erro aconteceu,$(</tmp/ERROR),$current_date,$current_time" >>$log_erro
    errcount=$((errcount + 1))
    hasError=0
  else
    count=$((count + 1))
  fi
  progress $count $repetitions
done

remove

printf "\n"

echo "Todos os testes finalizados"
