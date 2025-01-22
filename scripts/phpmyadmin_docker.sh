# Variáveis de configuração
MYSQL_HOST="my_custom_sql_service"  # Nome do serviço do MySQL no Docker
MYSQL_ROOT_PASSWORD="root_password"  # Senha do usuário root do MySQL
MYSQL_USER="root"  # Usuário MySQL (no caso, root)

# Executar o contêiner do phpMyAdmin
docker run -d \
  --name phpmyadmin \
  --network mynet-A \
  -e MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD} \
  -e MYSQL_USER=${MYSQL_USER} \
  -e MYSQL_HOST=${MYSQL_HOST} \
  -p 8080:80 \
  --restart=always \
  phpmyadmin/phpmyadmin