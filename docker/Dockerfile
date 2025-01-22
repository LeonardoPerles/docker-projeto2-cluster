# Usar uma imagem base oficial do MySQL
FROM mysql:8.0

# Definir variáveis de ambiente para configuração do MySQL
ENV MYSQL_ROOT_PASSWORD=root_password
ENV MYSQL_DATABASE=my_database

# Expor a porta padrão do MySQL
EXPOSE 3306

# Comando padrão para iniciar o MySQL
CMD ["mysqld"]