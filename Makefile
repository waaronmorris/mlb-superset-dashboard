#################################################################################
# COMMANDS                                                                      #
#################################################################################
.PHONY: run_dev run_prod run_superset test test-setup test-data test-etl test-db test-integration test-coverage

run_dbt_dev:
	@set -a && . mlb_dbt/.env && set +a && cd mlb_dbt && dbt run --target dev

run_dbt_prod:
	@set -a && . mlb_dbt/.env && set +a && cd mlb_dbt && dbt run --target prod

run_superset:
	@docker-compose down && docker-compose up -d --build --force-recreate

# Testing commands
test-setup:
	pip install -r requirements-test.txt

test: test-setup
	pytest tests/ -v

test-data: test-setup
	pytest tests/test_data_validation.py -v

test-etl: test-setup
	pytest tests/test_etl_pipeline.py -v

test-db: test-setup
	pytest tests/test_database.py -v

test-integration: test-setup
	pytest tests/test_integration.py -v

test-coverage: test-setup
	pytest tests/ --cov=. --cov-report=html