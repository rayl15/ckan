#!/bin/bash

echo "
CREATE ROLE ${CKAN_DB_USER} WITH LOGIN PASSWORD '${CKAN_DB_USER_PASS}' NOSUPERUSER NOCREATEDB NOCREATEROLE;
CREATE DATABASE ${CKAN_DB_NAME} WITH OWNER ${CKAN_DB_USER};
" >> /toRun1.sql

echo "
CREATE ROLE ${CKAN_DATASTORE_RW_DB_USER} WITH LOGIN PASSWORD '${CKAN_DATASTORE_RW_DB_USER_PASS}' NOSUPERUSER NOCREATEDB NOCREATEROLE;
CREATE ROLE ${CKAN_DATASTORE_RO_DB_USER} WITH LOGIN PASSWORD '${CKAN_DATASTORE_RO_DB_USER_PASS}' NOSUPERUSER NOCREATEDB NOCREATEROLE;
CREATE DATABASE ${CKAN_DATASTORE_DB_NAME} WITH OWNER ${CKAN_DATASTORE_RW_DB_USER};
REVOKE CREATE ON SCHEMA public FROM PUBLIC;
REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT CREATE ON SCHEMA public TO ${CKAN_DB_USER};
GRANT USAGE ON SCHEMA public TO ${CKAN_DB_USER};
GRANT CREATE ON SCHEMA public TO ${CKAN_DATASTORE_RW_DB_USER};
GRANT USAGE ON SCHEMA public TO ${CKAN_DATASTORE_RW_DB_USER};
REVOKE CONNECT ON DATABASE ${CKAN_DB_NAME} FROM ${CKAN_DATASTORE_RO_DB_USER};
GRANT CONNECT ON DATABASE ${CKAN_DATASTORE_DB_NAME} TO ${CKAN_DATASTORE_RO_DB_USER};
GRANT USAGE ON SCHEMA public TO ${CKAN_DATASTORE_RO_DB_USER};
GRANT SELECT ON ALL TABLES IN SCHEMA public TO ${CKAN_DATASTORE_RO_DB_USER};
ALTER DEFAULT PRIVILEGES FOR USER ${CKAN_DATASTORE_RW_DB_USER} IN SCHEMA public
GRANT SELECT ON TABLES TO ${CKAN_DATASTORE_RO_DB_USER};
" >> /toRun2.sql

cat /toRun1.sql
cat /toRun2.sql

psql -f /toRun1.sql
psql -f /toRun2.sql
