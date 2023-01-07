#!/bin/bash

cpu=$(mpstat | grep all)
usr=$(echo $cpu | awk '{print $3}')
nice=$(echo $cpu | awk '{print $4}')
sys=$(echo $cpu | awk '{print $5}')
iowait=$(echo $cpu | awk '{print $6}')
soft=$(echo $cpu | awk '{print $8}')
# Obtem o tempo atual, no formato RFC3339: AAAA-MM-DD HH:MM:SS 
tempo=$(date --rfc-3339=seconds)
# Separa data e hora do tempo obtido
data=$(echo $tempo | cut -d\  -f1)
hora=$(echo $tempo | cut -d\  -f2 | awk 'BEGIN{FS="-"}{print $1}')

echo "$usr $nice $sys $iowait $soft $data $hora" >>logs/monitoramento-cpu.txt
