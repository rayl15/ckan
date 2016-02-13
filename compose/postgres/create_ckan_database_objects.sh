#!/bin/bash

export PGUSER=postgres

IFS='/' read -ra CONN_DETAILS_1 <<< "$CKAN_SQLALCHEMY_URL"
IFS='@' read -ra CONN_DETAILS_2 <<< "${CONN_DETAILS_1[2]}"
IFS=':' read -ra CONN_DETAILS_3 <<< "${CONN_DETAILS_2[0]}"

CKAN_DB_NAME="${CONN_DETAILS_1[3]}"
CKAN_DB_USER="${CONN_DETAILS_3[0]}"
CKAN_DB_USER_PASS="${CONN_DETAILS_3[1]}"


psql <<- EOSQL
   CREATE ROLE $CKAN_DB_USER WITH LOGIN PASSWORD '${CKAN_DB_USER_PASS}' NOSUPERUSER NOCREATEDB NOCREATEROLE;
   CREATE DATABASE $CKAN_DB_NAME WITH OWNER $CKAN_DB_USER;
EOSQL


if [ -n "$CKAN_DATASTORE_WRITE_URL" ]; then

    IFS='/' read -ra CONN_DETAILS_1 <<< "$CKAN_DATASTORE_WRITE_URL"
    IFS='@' read -ra CONN_DETAILS_2 <<< "${CONN_DETAILS_1[2]}"
    IFS=':' read -ra CONN_DETAILS_3 <<< "${CONN_DETAILS_2[0]}"
    CKAN_DATASTORE_DB_NAME="${CONN_DETAILS_1[3]}"
    CKAN_DATASTORE_RW_DB_USER="${CONN_DETAILS_3[0]}"
    CKAN_DATASTORE_RW_DB_USER_PASS="${CONN_DETAILS_3[1]}"

    IFS='/' read -ra CONN_DETAILS_1 <<< "$CKAN_DATASTORE_READ_URL"
    IFS='@' read -ra CONN_DETAILS_2 <<< "${CONN_DETAILS_1[2]}"
    IFS=':' read -ra CONN_DETAILS_3 <<< "${CONN_DETAILS_2[0]}"
    CKAN_DATASTORE_RO_DB_USER="${CONN_DETAILS_3[0]}"
    CKAN_DATASTORE_RO_DB_USER_PASS="${CONN_DETAILS_3[1]}"

        psql <<- EOSQL
        CREATE ROLE $CKAN_DATASTORE_RW_DB_USER WITH LOGIN PASSWORD '${CKAN_DATASTORE_RW_DB_USER_PASS}' NOSUPERUSER NOCREATEDB NOCREATEROLE;
EOSQL
    psql <<- EOSQL
   CREATE ROLE $CKAN_DATASTORE_RO_DB_USER WITH LOGIN PASSWORD '${CKAN_DATASTORE_RO_DB_USER_PASS}' NOSUPERUSER NOCREATEDB NOCREATEROLE;
   CREATE DATABASE $CKAN_DATASTORE_DB_NAME WITH OWNER $CKAN_DATASTORE_RW_DB_USER;
EOSQL

psql -d $CKAN_DATASTORE_DB_NAME <<- EOSQL
   REVOKE CREATE ON SCHEMA public FROM PUBLIC;
   REVOKE USAGE ON SCHEMA public FROM PUBLIC;
   GRANT CREATE ON SCHEMA public TO $CKAN_DB_USER;
   GRANT USAGE ON SCHEMA public TO $CKAN_DB_USER;
   GRANT CREATE ON SCHEMA public TO $CKAN_DATASTORE_RW_DB_USER;
   GRANT USAGE ON SCHEMA public TO $CKAN_DATASTORE_RW_DB_USER;
   REVOKE CONNECT ON DATABASE $CKAN_DB_NAME FROM $CKAN_DATASTORE_RO_DB_USER;
   GRANT CONNECT ON DATABASE $CKAN_DATASTORE_DB_NAME TO $CKAN_DATASTORE_RO_DB_USER;
   GRANT USAGE ON SCHEMA public TO $CKAN_DATASTORE_RO_DB_USER;
   GRANT SELECT ON ALL TABLES IN SCHEMA public TO $CKAN_DATASTORE_RO_DB_USER;
   ALTER DEFAULT PRIVILEGES FOR USER $CKAN_DATASTORE_RW_DB_USER IN SCHEMA public
   GRANT SELECT ON TABLES TO $CKAN_DATASTORE_RO_DB_USER;
EOSQL
fi
