#!/bin/bash


#echo $pid
while true; do
  :

  pidHead=$(pidof -s VBoxHeadless)
  date_time=$(date +%d-%m-%Y-%H:%M:%S)

  if [ -n "$pidHead" ]; then
    dados=$(pidstat -u -h -p $pidHead -T ALL -r 1 1 | sed -n '4p')
    thread=$(cat /proc/"$pidHead"/status | grep Threads | awk '{print $2}')
    cpu=$(echo "$dados" | awk '{print $8}')
    mem=$(echo "$dados" | awk '{print $14}')
    vmrss=$(echo "$dados" | awk '{print $13}')
    vsz=$(echo "$dados" | awk '{print $12}')
    swap=$(cat /proc/"$pidHead"/status | grep Swap | awk '{print $2}')

    echo "$cpu;$mem;$vmrss;$vsz;$thread;$swap;$date_time" >> ../logs/monitoramento-VBoxHeadless.csv
  else
    echo "pid is empty"
  fi
done
