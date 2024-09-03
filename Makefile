#################################################################################
# COMMANDS                                                                      #
#################################################################################
.PHONY: run_dev
run_dev:
	@set -a && . mlb_dbt/.env && set +a && cd mlb_dbt && dbt run --target dev

## Create a virtual environment
.PHONY: build_and_run
build_and_run:
	@docker build -t superset --target superset . --build-arg SUPERSET_ADMIN=admin --build-arg SUPERSET_PASSWORD=password
	@docker run --name superset superset

.PHONY: run
run:
	@docker run --name superset superset

.PHONY: stop
stop:
	@docker stop superset
