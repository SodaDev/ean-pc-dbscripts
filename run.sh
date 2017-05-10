#! /bin/bash

set -e

test -n "${MYSQL_HOST}" || { echo 'Environment variable MYSQL_HOST must be set'; exit 1; }
test -n "${MYSQL_USER}" || { echo 'Environment variable MYSQL_USER must be set'; exit 1 ; }
test -n "${MYSQL_DB}" || { echo 'Environment variable MYSQL_USER must be set'; exit 1 ; }
test -n "${MYSQL_PASS}" || { echo 'Environment variable MYSQL_PASS must be set'; exit 1; }

DB_NAME="$MYSQL_DB"

git_url='https://github.com/SodaDev/ean-pc-dbscripts.git'
workspace=/opt/data/workspace

sql_files=${workspace}/MySQL

mkdir -p ${workspace}

function checkout {
  echo 'Repository checkout'
  test -e ${workspace}/.git ||
  git clone ${git_url} ${workspace}
}

function run_query {
    echo 'Running query'
    mysql -sqN -u "${MYSQL_USER}" -p"${MYSQL_PASS}" -h "$MYSQL_HOST"  -D $DB_NAME -e "$@"
}

function run_query_from_pipe {
    echo 'Running piped query'
    mysql -sqN -u "${MYSQL_USER}" -p"${MYSQL_PASS}" -h "$MYSQL_HOST"
}

function run_query_global {
    echo 'Running global query'
    mysql -sqN -u "${MYSQL_USER}" -p"${MYSQL_PASS}" -h "$MYSQL_HOST" -e "$@"
}

function should_create_table {
  echo 'Checking tables existence'
  run_query 'show tables' | grep -q 'activepropertylist' && return 1
  return 0
}

function should_create_database {
  echo 'Checking DB existence'
  run_query_global 'show databases' | grep -q "${DB_NAME}" && return 1
  return 0
}

function create_database {
  echo 'Creating DB'
  run_query_global "create database ${DB_NAME} "
}

function create_tables {
  echo 'Creating tables'
  run_query_from_pipe < "${sql_files}/MySQL_create_eanprod.sql"
  
  langs=$(find $sql_files -type f | grep extend)
  for lang in $langs; do 
    run_query_from_pipe < $lang
  done
}


checkout 

should_create_database && create_database

should_create_table && create_tables

bash ${workspace}/EAN_MySQL_refresh.sh

