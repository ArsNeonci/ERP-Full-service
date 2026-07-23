#!/bin/bash
set -e

# Hàm tạo database nếu chưa tồn tại và cài đặt pgvector
function create_user_and_database() {
	local database=$1
	echo "  Creating user and database '$database'"
    
    # 1. Tạo Database và cấp quyền
	psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
	    CREATE DATABASE $database;
	    GRANT ALL PRIVILEGES ON DATABASE $database TO $POSTGRES_USER;
	EOSQL

    # 2. Kết nối vào Database vừa tạo để kích hoạt extension vector
	psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$database" <<-EOSQL
        CREATE EXTENSION IF NOT EXISTS vector;
	EOSQL
}

if [ -n "$POSTGRES_MULTIPLE_DATABASES" ]; then
	echo "Multiple database creation requested: $POSTGRES_MULTIPLE_DATABASES"
	for db in $(echo $POSTGRES_MULTIPLE_DATABASES | tr ',' ' '); do
		create_user_and_database $db
	done
	echo "Multiple databases created with pgvector extension"
fi