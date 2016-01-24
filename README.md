In a nutshell:

1. make install
2. make configure-aws
3. make ssh-keygen
4. make cluster
5. make create
6. sleep 120
7. make ecs-compose-up
8. make ps

(requires make, aws-cli, nodejs, jq)

`make cluster` creates an empty ECS cluster named 'default'.

`make create` adds EC2 instances (with VPCs, Security groups) to a cluster 'default', defined by 'formation/Template.cloudformation'.

`make list` shows running instances, their IDs and IPs.

`make ssh-core <IP>` allows to ssh into an intance.

`make ecs-compose-up` launches containers defined by 'compose/docker-compose.yml'.

`make ecs-compose-stop` stops and deletes containers.

`make delete <ID>` deletes an instance.

`make delete-cluster` deletes a cluster.
