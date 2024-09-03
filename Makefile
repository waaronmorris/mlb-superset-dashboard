#################################################################################
# COMMANDS                                                                      #
#################################################################################
.PHONY: run_dev
run_dbt_dev:
	@set -a && . mlb_dbt/.env && set +a && cd mlb_dbt && dbt run --target dev

.PHONY: run_prod
run_dbt_prod:
	@set -a && . mlb_dbt/.env && set +a && cd mlb_dbt && dbt run --target prod


