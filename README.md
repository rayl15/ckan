In a nutshell:

Install mo from https://github.com/tests-always-included/mo

Set variables AWS_ACCESS_KEY_ID, AWS_SECRET_KEY, AWS_DEFAULT_REGION and install make, aws-cli, ecs-cli, nodejs. Optionally docker-compose.

To use RDS set the following env variables:

- RDS=true
- PGUSER (e.g. masterusername)
- PGHOST (e.g. dbinstance.abcdefg.eu-central-1.rds.amazonaws.com)
- PGPORT (e.g 5432)
- PGPASSWORD (e.g. masterpassword)

For testing purposes set following variables as is:

- CKAN_DB_NAME=ckan_default
- CKAN_DB_USER=ckan_default
- CKAN_DATASTORE_DB_NAME=datastore_default
- CKAN_DATASTORE_RW_DB_USER=ckan_default
- CKAN_DATASTORE_RO_DB_USER=datastore_default
- CKAN_DB_USER_PASS=pass
- CKAN_DATASTORE_RW_DB_USER_PASS=pass
- CKAN_DATASTORE_RO_DB_USER_PASS=pass

For NFS set the following variable, for example:

- NFSADDRESS=localhost:/data

ecs-cli from the official repo doesn't support "restart: no" yet, custom built one is [here](http://beehub.nl/home/xaduha/public/bin/ecs-cli).

    1. npm install --save
    2. make ssh-keygen
    3. make cluster
    4. make create
    5. sleep 120
    6. make ecs-compose-up
    7. make ps

`make cluster` creates an empty ECS cluster named 'default'.

`make create` adds EC2 instances (with VPCs, Security groups) to a cluster 'default', defined by 'formation/Template.cloudformation'.

`make list` shows running instances, their IDs and IPs.

`make ssh <IP>` allows to ssh into an intance.

`make ecs-compose-up` launches containers defined by 'compose/docker-compose.yml'.

`make ecs-compose-stop` stops and deletes containers.

`make delete <ID>` deletes an instance.

`make delete-cluster` deletes a cluster.
