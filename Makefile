RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
$(eval $(RUN_ARGS):;@:)

pwd:=$(shell pwd)
PATH:=$(PATH):./node_modules/.bin
HOME=./keys
timestamp=`date +%s`
random:=$(shell bash -c 'echo $$RANDOM')

DOCKERNS := axetwe

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

configure-aws:
	@aws configure

list-tasks:
	@aws ecs list-tasks --cluster default

stop-task:
	@aws ecs stop-task --cluster default --task $(RUN_ARGS)

list-clusters:
	@aws ecs list-clusters

cluster:
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

task:
	@aws ecs run-task --task-definition $(RUN_ARGS)

delete:
	@aws cloudformation delete-stack --stack-name $(RUN_ARGS)

list:
	@aws ec2 describe-instances \
		--filters Name=instance-state-name,Values=running \
		--query 'Reservations[].Instances[].[Tags[?Key==`aws:cloudformation:stack-name`] | [0].Value, InstanceId,PublicIpAddress,InstanceType,Placement.AvailabilityZone,State.Name]' \
		--output table

delete-aws:
	@aws cloudformation delete-stack --stack-name $(RUN_ARGS)

delete-ecs:
	@aws cloudformation delete-stack --stack-name $(RUN_ARGS)

create: cloud-config
	@cp formation/Template.cloudformation Result.cloudformation
	@cfnpp
	@aws cloudformation create-stack --stack-name core${random} --template-body file://.//Result.cloudformation

create-ecs-cluster:
	@aws ecs create-cluster --cluster-name default

locations-aws:
	@aws ec2 describe-regions --output table

clean:
	@rm -rf ./node_modules/*

bash:
	@docker run -it $(DOCKERNS)/$(RUN_ARGS) bash

runcmd:
	@docker run -it $(DOCKERNS)/$(RUN_ARGS)

exec:
	@docker exec -it `docker ps | grep $(DOCKERNS)/$(RUN_ARGS) | cut -d ' ' -f1`  bash

stop:
	@docker stop `docker ps | grep $(DOCKERNS)/$(RUN_ARGS) | cut -d ' ' -f1`
