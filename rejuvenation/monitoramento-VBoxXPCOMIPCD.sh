#!/bin/bash

pidXPCO=$(pidof -s VBoxXPCOMIPCD)
#echo $pid
if [ -n "$pidXPCO" ]; then
  dados=$(pidstat -u -h -p $pidXPCO -T ALL -r 1 1 | sed -n '4p')
  thread=$(cat /proc/"$pidXPCO"/status | grep Threads | awk '{print $2}')
  cpu=$(echo "$dados" | awk '{print $8}')
  mem=$(echo "$dados" | awk '{print $14}')
  vmrss=$(echo "$dados" | awk '{print $13}')
  vsz=$(echo "$dados" | awk '{print $12}')
  swap=$(cat /proc/"$pidXPCO"/status | grep Swap | awk '{print $2}')

  #vm_total_rss=$(($vmrss + $vm_total_rss))
  #vm_total_vsz=$(($vsz + $vm_total_vsz))

  echo "$cpu;$mem;$vmrss;$vsz;$thread;$swap;$date_time" >>logs/monitoramento-VBoxXPCOMIPCD.csv
else
  echo "pid is empty"
  exit 1
fi
