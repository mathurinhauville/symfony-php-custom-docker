#!/bin/bash

source .env.docker

echo "###> docker configuration ###" > .env.docker

for arg in "$@"
do
    var_name=$(echo $arg | cut -d';' -f1)
    var_value=$(echo $arg | cut -d';' -f2)
    echo $var_name=$var_value >> .env.docker
done

echo "###< docker configuration ###" >> .env.docker