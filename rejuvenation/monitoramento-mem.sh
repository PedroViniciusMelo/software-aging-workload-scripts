#!/bin/bash

mem=$(free | grep Mem)
used=$(echo $mem | awk '{print $3}')
cached=$(cat /proc/meminfo | grep -i Cached | sed -n '1p' | awk '{print $2}')
buffer=$(cat /proc/meminfo | grep -i Buffers | awk '{print $2}')
swap=$(cat /proc/meminfo | grep -i Swap | grep -i Free | awk '{print $2}')
data=$(date)
echo "$used $cached $buffer $swap $data" >>logs/monitoramento-mem.txt

