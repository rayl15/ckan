In a nutshell:

Set variables AWS_ACCESS_KEY_ID, AWS_SECRET_KEY, AWS_DEFAULT_REGION and install make, aws-cli, ecs-cli, nodejs. Optionally docker-compose.

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

`make ssh-core <IP>` allows to ssh into an intance.

`make ecs-compose-up` launches containers defined by 'compose/docker-compose.yml'.

`make ecs-compose-stop` stops and deletes containers.

`make delete <ID>` deletes an instance.

`make delete-cluster` deletes a cluster.
