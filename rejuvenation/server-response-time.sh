#!/bin/bash

#!/bin/bash

# usage ./remoteServiceResponse.sh http://www.example.com
# Define a URL do servidor
URL=$1

# Cria o cabeçalho do arquivo CSV
echo "date_time;response_time" > response_times.csv

# Loop infinito para medir o tempo de resposta
while true; do
  # Captura o timestamp atual
  timestamp=$(date +%d-%m-%Y-%H:%M:%S)

  # Faz a requisição HTTP e captura o tempo de resposta
  response=$(curl -w "%{http_code}  %{time_total}" -o /dev/null -s "$URL")
  code=$(echo $response | awk '{print $1}')
  response_time=$(echo $response | awk '{print $2}')

  if [ ! "$code" -eq 200 ]; then
    response_time="-1"
  fi

  # Adiciona o timestamp e o tempo de resposta ao arquivo CSV
  echo "$timestamp;$response_time" >> response_times.txt

  # Espera 5 segundos antes de fazer a próxima requisição
  sleep 5
done
