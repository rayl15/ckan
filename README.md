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

To use oauth2, get client id and secret by following these steps:

1. Create a new project: https://console.developers.google.com/project
2. Choose the new project from the top right project dropdown (only if another project is selected)
3. In the project Dashboard center pane, choose **"Enable and manage APIs"**
4. In the left Nav pane, choose **"Credentials"**
5. In the center pane, choose **"OAuth consent screen"** tab. Fill in **"Product name shown to users"** and hit save.
6. In the center pane, choose **"Credentials"** tab.
   * Open the **"New credentials"** drop down
   * Choose **"OAuth client ID"**
   * Choose **"Web application"**
   * Authorized JavaScript origins: `https://internal.yourcompany.com`
   * Authorized redirect URIs is the location of oath2/callback: `https://internal.yourcompany.com/oauth2/callback`
   * Choose **"Create"**

Copy client id and secret to env variables

- CKAN_OAUTH2_CLIENT_ID
- CKAN_OAUTH2_CLIENT_SECRET

After starting the server put the IP address in /etc/hosts as internal.yourcompany.com, to access later as https://internal.yourcompany.com

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
