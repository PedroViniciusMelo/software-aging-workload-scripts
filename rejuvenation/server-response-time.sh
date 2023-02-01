#!/bin/bash

#!/bin/bash

# usage ./remoteServiceResponse.sh http://www.example.com
# Define a URL do servidor
URL=$1

# Cria o cabeçalho do arquivo CSV
echo "timestamp,response_time" > response_times.csv

# Loop infinito para medir o tempo de resposta
while true; do
  # Captura o timestamp atual
  timestamp=$(date +"%Y-%m-%d %T")

  # Faz a requisição HTTP e captura o tempo de resposta
  response_time=$(curl -w '%{time_total}' -o /dev/null -s "$URL")

  # Adiciona o timestamp e o tempo de resposta ao arquivo CSV
  echo "$timestamp,$response_time" >> response_times.csv

  # Espera 5 segundos antes de fazer a próxima requisição
  sleep 5
done