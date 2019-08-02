#!/bin/bash

# Touch all the servers by running the true command on them.
# This is needed so that we get rid of the known hosts issue.

for i in $(seq 1 10); do
    ssh-keyscan -t rsa "server$i" >> ~/.ssh/known_hosts
    ssh "server$i" true;
done
