# docker-compose-cluster
A simple Linux cluster implemented using docker-compose

## Creating New SSH keys
To create a new public and private SSH key you can use the following
command.

    ssh-keygen -b 2048 -t rsa -f id_rsa_cluster -q -N ""
