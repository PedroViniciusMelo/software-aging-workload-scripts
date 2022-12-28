#!/bin/bash

echo "cpu mem vmrss vsz threads swap" >monitoramento-VBoxSVC.txt

pid=$(pidof VBoxSVC)
#echo $pid
if [ -n "$pid" ]; then
  dados=$(pidstat -u -h -p $pid -T ALL -r 1 1 | sed -n '4p')
  thread=$(cat /proc/"$pid"/status | grep Threads | awk '{print $2}')
  cpu=$(echo "$dados" | awk '{print $8}')
  mem=$(echo "$dados" | awk '{print $14}' | sed 's/,/./g')
  vmrss=$(echo "$dados" | awk '{print $13}')
  vsz=$(echo "$dados" | awk '{print $12}')
  swap=$(cat /proc/"$pid"/status | grep Swap | awk '{print $2}')

  memtotal=$(awk "BEGIN{ print $mem + $memtotal }")

  echo "$cpu $mem $vmrss $vsz $thread $swap" >>monitoramento-VBoxSVC.txt
else
  echo "pid is empty"
fi
