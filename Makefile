RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
$(eval $(RUN_ARGS):;@:)

PATH:=$(PATH):./node_modules/.bin
HOME=./keys
random:=$(shell bash -c 'echo $$RANDOM')

usage:
	@echo Please read README.md

ssh-keygen:
	@ssh-keygen -b 2048 -t rsa -f keys/id_rsa -q -N ""
	@sed -e s/ssh-rsa/' - ssh-rsa'/g keys/id_rsa.pub > keys/id_rsa.pub.snippet

install:
	@npm install --save

cloud-config:
	@cat cloud-config.template.yml keys/id_rsa.pub.snippet > \
	  Result.cloudformation.d/resources/EcsInstanceLcWithoutKeyPair/userdata

ssh:
	@ssh -i keys/id_rsa core@$(RUN_ARGS)

ps:
	@ecs-cli ps

template:
	@rm -f keys/docker-compose.yml
	@sed \
		-e "s|CKAN_SQLALCHEMY_URL.*$|CKAN_SQLALCHEMY_URL=${CKAN_SQLALCHEMY_URL}|g" \
		-e "s|CKAN_DATASTORE_WRITE_URL.*$|CKAN_DATASTORE_WRITE_URL=${CKAN_DATASTORE_WRITE_URL}|g" \
		-e "s|CKAN_DATASTORE_READ_URL.*$|CKAN_DATASTORE_READ_URL=${CKAN_DATASTORE_READ_URL}|g" \
		-e "s|PGUSER.*$|PGUSER=${PGUSER}|g" \
		-e "s|PGPORT.*$|PGPORT=${PGPORT}|g" \
		-e "s|PGHOST.*$|PGHOST=${PGHOST}|g" \
		-e "s|PGPASSWORD.*$|PGPASSWORD=${PGPASSWORD}|g" \
		compose/docker-compose.template.yml > keys/docker-compose.yml

up: ecs-compose-up

stop: ecs-compose-stop

ecs-compose-up: template
	@ecs-cli compose -f keys/docker-compose.yml up

ecs-compose-stop: template
	@ecs-cli compose -f keys/docker-compose.yml stop

policies:
	@aws iam attach-role-policy --role-name=ecsInstanceRole --policy-arn=arn:aws:iam::aws:policy/AmazonRDSFullAccess
	@#aws iam attach-role-policy --role-name=ecsInstanceRole --policy-arn=arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess

put:
	@echo disabled
	@#aws s3 cp compose/environment s3://${bucket}/shared/environment

list-tasks:
	@aws ecs list-tasks --cluster default

stop-task:
	@aws ecs stop-task --cluster default --task $(RUN_ARGS)

list-clusters:
	@aws ecs list-clusters

cluster:
	@ecs-cli configure -c default
	@aws ecs create-cluster --cluster-name default

delete-cluster:
	@aws ecs delete-cluster --cluster default

list-services:
	@aws ecs list-services --cluster default

delete-service:
	@aws ecs delete-service --service $(RUN_ARGS)

zero-service:
	@aws ecs update-service --desired-count 0 --service $(RUN_ARGS)

register-definition:
	@aws ecs register-task-definition --cli-input-json file://.//$(RUN_ARGS)

list-definitions:
	@aws ecs list-task-definitions

describe:
	@aws ecs describe-task-definition --task-definition ecscompose-compose:$(RUN_ARGS)

deregister:
	@echo deregistering definition number $(RUN_ARGS)
	@aws ecs deregister-task-definition --task-definition ecscompose-compose:$(RUN_ARGS)

task:
	@aws ecs run-task --task-definition $(RUN_ARGS)

delete:
	@aws cloudformation delete-stack --stack-name $(RUN_ARGS)

list:
	@aws ec2 describe-instances \
		--filters Name=instance-state-name,Values=running \
		--query 'Reservations[].Instances[].[Tags[?Key==`aws:cloudformation:stack-name`] | [0].Value, InstanceId,PublicIpAddress,InstanceType,Placement.AvailabilityZone,State.Name]' \
		--output table

create: cloud-config
	@cp formation/Template.cloudformation Result.cloudformation
	@./node_modules/.bin/cfnpp
	@aws cloudformation create-stack --stack-name core${random} --template-body file://.//Result.cloudformation

locations-aws:
	@aws ec2 describe-regions --output table

clean:
	@rm -rf ./node_modules/*
