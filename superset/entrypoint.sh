#!/bin/bash
set -e

superset fab create-admin \
              --username "admin" \
              --password "admin" \
              --firstname Superset \
              --lastname Admin \
              --email admin@example.com
superset db upgrade
superset init
#  superset set_database_uri -d DW -u duckdb:////app/superset_home/mlb.duckdb
superset import-datasources --path superset_home/assets/dataset_import.zip -u admin

exec gunicorn --bind  "0.0.0.0:8088" --access-logfile '-' --error-logfile '-' --workers 1 --worker-class gthread --threads 20 --timeout 60 --limit-request-line 0 --limit-request-field_size 0 "superset.app:create_app()"