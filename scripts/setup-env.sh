#!/bin/bash

# Path: scripts/setup-env.sh
#
# Script to set the environment variables
# It's called by the script setup-project.sh
#
# This project is available on github : https://github.com/mathurinhauville/symfony-php-custom-docker
# @Author : https://github.com/mathurinhauville

echo "###> docker configuration ###" > .env.docker

for arg in "$@"
do
    var_name=$(echo $arg | cut -d';' -f1)
    var_value=$(echo $arg | cut -d';' -f2)
    echo $var_name=$var_value >> .env.docker
done

echo "###< docker configuration ###" >> .env.docker

echo "" >> .env.docker
echo "###> mysql configuration ###" >> .env.docker
echo "MYSQL_SERVER_VERSION=8.0.33" >> .env.docker
echo "MYSQL_ROOT_PASSWORD=root" >> .env.docker
echo "###< mysql configuration ###" >> .env.docker

echo "" >> .env.docker
echo "###> phpmyadmin configuration ###" >> .env.docker
echo "PHPMYADMIN_VERSION=5.2.1" >> .env.docker
echo "###< phpmyadmin configuration ###" >> .env.docker