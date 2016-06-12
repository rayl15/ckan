RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
$(eval $(RUN_ARGS):;@:)

build: prep
	@docker-compose build

up: prep
	@docker-compose rm -f
	@docker-compose up --force-recreate

prep:
	@chmod 777 data
	@rm -rf postgres/*.made.sql
	@mo docker-compose.template.yml > docker-compose.yml

stop:
	@docker-compose stop

exec:
	@docker exec -it $(shell docker ps | grep $(RUN_ARGS) | cut -d ' ' -f1)  bash
