RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
$(eval $(RUN_ARGS):;@:)

PATH:=$(PATH):../bin:../node_modules/.bin

build: prep
	@docker-compose build

up: prep
	#@docker-compose rm -f
	@docker-compose up --force-recreate

prep:
	@chmod 777 data
	@rm -rf postgres/*.made.sql
	@unset RDS && mo docker-compose.template.yml > docker-compose.yml

stop:
	@docker-compose stop

exec:
	@docker exec -it $(shell docker ps | grep $(RUN_ARGS) | cut -d ' ' -f1)  bash

get:
	@curl -s -X GET http://$(RUN_ARGS):8000/api/3/action/datastore_search?resource_id=_table_metadata | jq .

post:
	@curl -s -X POST http://$(RUN_ARGS):8000/api/3/action/datastore_create -H "Authorization: $(MY_API_KEY)" -d '{"resource": {"package_id": "$(MY_PACKAGE_ID)"}, "fields": [ {"id": "a"}, {"id": "b"} ], "records": [ { "a": 1, "b": "xyz"}, {"a": 2, "b": "zzz"} ]}' | jq .

getresource:
	@curl -s -X GET http://$(RUN_ARGS):8000/api/3/action/datastore_search?resource_id=$(MY_RESOURCE_KEY)
