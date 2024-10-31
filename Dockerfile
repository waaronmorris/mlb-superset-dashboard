FROM python:3.11-slim as dbt

ARG CLOUDFLARE_BUCKET
ARG CLOUDFLARE_ACCOUNT_ID
ARG CLOUDFLARE_CLIENT_ACCESS_KEY
ARG CLOUDFLARE_CLIENT_SECRET
ARG CLOUDFLARE_TOKEN_VALUE

COPY mlb_dbt /app

# Install any needed packages specified in requirements.txt
WORKDIR /app
RUN pip install -r requirements.txt

RUN dbt deps
RUN dbt seed
RUN dbt build --target production

WORKDIR /

#CMD ["cp", "app/mlb.duckdb", "/superset_home"]

# Zip Folder
FROM alpine as zip

WORKDIR /app

COPY superset/assets/dataset_import /app/assets/dataset_import

# Zip Superset/assets/dashboard_export/ to daashboard_export.zip
RUN apk add zip
RUN cd assets && zip -r dataset_import.zip dataset_import

FROM apache/superset:latest as superset

ARG SUPERSET_ADMIN
ARG SUPERSET_PASSWORD

COPY superset /app

WORKDIR /app

RUN pip install -r requirements.txt

ENV SUPERSET_CONFIG_PATH /app/superset_config.py

USER root

#copy to superset_home/assets/dashboard_export.zip
COPY --from=zip /app/assets/dataset_import.zip /app/superset_home/assets/dataset_import.zip

#Copy duckdb files from dbt container
COPY --from=dbt app/mlb.duckdb /app/superset_home/mlb.duckdb

RUN chown -R superset:superset /app/superset_home
RUN chmod -R 777 /app/superset_home/mlb.duckdb

COPY superset/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

USER superset

EXPOSE 443

ENTRYPOINT ["/entrypoint.sh"]




