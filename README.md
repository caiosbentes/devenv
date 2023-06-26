# Arquivo Docker Compose para MongoDB, PostgreSQL e RabbitMQ

Este arquivo Docker Compose criará três containers:

1. Um container MongoDB, que será usado para armazenar dados.
2. Um container PostgreSQL, que será usado para armazenar dados.
3. Um container RabbitMQ, que será usado para enviar e receber mensagens.

## Container MongoDB

- Imagem: mongo:6-jammy
- Nome do container: mongodb
- Política de reinício: "always" (sempre reiniciar)
- Porta exposta: 27017 (porta padrão para o MongoDB)
- Variáveis de ambiente:
  - MONGO_INITDB_DATABASE: [nome_do_banco_de_dados]
  - MONGO_INITDB_ROOT_USERNAME: [nome_de_usuário_root]
  - MONGO_INITDB_ROOT_PASSWORD: [senha_do_usuário_root]
- Volume montado:
  - Hospedeiro: mongodb_data
  - Container: /data/db

## Container PostgreSQL

- Imagem: postgres:14.1-alpine
- Nome do container: postgres
- Política de reinício: "always" (sempre reiniciar)
- Porta exposta: 5432 (porta padrão para o PostgreSQL)
- Variáveis de ambiente:
  - POSTGRES_USER: [nome_do_usuário_do_banco_de_dados]
  - POSTGRES_PASSWORD: [senha_do_usuário_do_banco_de_dados]
  - POSTGRES_DB: [nome_do_banco_de_dados]
- Volume montado:
  - Hospedeiro: postgres_data
  - Container: /var/lib/postgresql/data

## Container RabbitMQ

- Imagem: rabbitmq:3.8-management-alpine
- Nome do container: rabbitmq
- Política de reinício: "always" (sempre reiniciar)
- Portas expostas:
  - 5672 (porta padrão para a interface de gerenciamento AMQP)
  - 15672 (porta padrão para o protocolo RabbitMQ)
- Variáveis de ambiente:
  - RABBITMQ_DEFAULT_USER: [nome_de_usuário_do_RabbitMQ]
  - RABBITMQ_DEFAULT_PASS: [senha_do_usuário_do_RabbitMQ]
- Volume montado:
  - Hospedeiro: rabbitmq_data
  - Container: /var/lib/rabbitmq

Para usar este arquivo Docker Compose, execute o seguinte comando a partir do diretório:

```console
foo@bar:~$ docker-compose up -d
foo
```

Isso iniciará os três containers e os exporá em suas respectivas portas. Você pode então se conectar aos containers MongoDB, PostgreSQL e RabbitMQ usando os seguintes endereços:

- MongoDB: `localhost:27017`
- PostgreSQL: `localhost:5432`
- Interface de gerenciamento do RabbitMQ: `localhost:15672`
