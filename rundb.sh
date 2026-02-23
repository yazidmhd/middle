#!/bin/bash

# Source server connection details
SRC_HOST="maria_a_host"
SRC_PORT=3306
SRC_USER="root"
SRC_PASS="source_password"

# Target server connection details
TGT_HOST="maria_b_host"
TGT_PORT=3306
TGT_USER="root"
TGT_PASS="target_password"

# List of databases to migrate
DATABASES=("db_one" "db_two" "db_three" "db_four" "db_five")

# Loop through each database
for DB in "${DATABASES[@]}"; do

  echo "Dumping $DB..."
  # Export tables + data + routines + triggers from source into a sql file
  mysqldump -h "$SRC_HOST" -P "$SRC_PORT" -u "$SRC_USER" -p"$SRC_PASS" \
	  --routines --triggers "$DB" > "${DB}_dump.sql"

  echo "Importing $DB..."
  # Import the sql file into the target server's database
  mysql -h "$TGT_HOST" -P "$TGT_PORT" -u "$TGT_USER" -p"$TGT_PASS" "$DB" < "${DB}_dump.sql"

  echo "$DB done."
  
done