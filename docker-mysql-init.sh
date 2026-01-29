#!/bin/bash
# This script runs before MySQL starts and ensures init.sql is available for the entrypoint

set -e

# Wait for MySQL to be ready and then initialize the database
echo "Waiting for MySQL to be ready..."
until mysqladmin ping -h localhost -u root -p"$MYSQL_ROOT_PASSWORD" --silent; do
  echo 'waiting for mysql...'
  sleep 1
done

echo "MySQL is ready. Running init.sql..."
mysql -h localhost -u root -p"$MYSQL_ROOT_PASSWORD" < /init.sql

echo "Database initialization complete."
