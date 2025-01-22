#!/bin/bash

# Caminho do Dockerfile
DOCKERFILE_PATH="/vagrant/docker"

# Nome da imagem personalizada
IMAGE_NAME="my_custom_sql_image"

# Cria o volume para armazenamento dos dados do banco
docker volume create mysql-A

# Cria a rede que sera utilizada para a comunicação entre o banco e a aplicação que nesse caso é o phpmyadmin 
docker network create -d bridge mynet-A

# Verifica se a imagem já existe, caso contrário, constrói a imagem
if [[ "$(docker images -q $IMAGE_NAME 2> /dev/null)" == "" ]]; then
  echo "Imagem não encontrada. Construindo a imagem '$IMAGE_NAME'..."
  docker build -t $IMAGE_NAME $DOCKERFILE_PATH
else
  echo "Imagem '$IMAGE_NAME' já existe. Pulando a construção."
fi

# Rodando o contêiner Docker com a imagem personalizada
echo "Iniciando o contêiner com a imagem '$IMAGE_NAME'..."
docker run -d \
  --name "my_custom_sql_service" \
  --hostname db \
  --network mynet-A \
  -v mysql-A:/var/lib/mysql/ \
  --restart="always" \
  -p 3306:3306 \
  -e MYSQL_ROOT_PASSWORD=root_password \
  -e MYSQL_DATABASE=my_database \
  $IMAGE_NAME