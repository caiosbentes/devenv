#!/bin/bash

set -e
set -u

# Set the color variable
green='\033[0;32m'
# Clear the color after that
clear='\033[0m'

function create_user_and_database() {
	local database=$1
	echo "  Creating user and database '$database'"
	psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
	    CREATE USER "$database";
	    CREATE DATABASE "$database";
	    GRANT ALL PRIVILEGES ON DATABASE "$database" TO "$database";
EOSQL
}

function restore_database() {
	local database=$1
	echo "  Restoring database '$database'"
    pg_restore -U $POSTGRES_USER --schema=public -d $database "/sql/Script${database}_20230628.backup"
}

if [ -n "$POSTGRES_MULTIPLE_DATABASES" ]; then
	echo "Multiple database creation requested: $POSTGRES_MULTIPLE_DATABASES"
	for db in $(echo $POSTGRES_MULTIPLE_DATABASES | tr ',' ' '); do
		create_user_and_database $db
	done
	echo -e "${green}Multiple databases created${clear}"
fi

if [ -n "$POSTGRES_MULTIPLE_DATABASES" ]; then
	echo "Multiple database restore requested: $POSTGRES_MULTIPLE_DATABASES"
	for db in $(echo $POSTGRES_MULTIPLE_DATABASES | tr ',' ' '); do
		restore_database $db
	done
	echo -e "${green}Multiple databases restored${clear}"
fi
