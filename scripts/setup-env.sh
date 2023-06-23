#!/bin/bash

# Path: scripts/setup-env.sh
#
# Script to set the environment variables
# It's called by the script setup-project.sh
#
# This project is available on github : https://github.com/mathurinhauville/symfony-php-custom-docker
# @Author : https://github.com/mathurinhauville

echo "###> docker configuration ###" > .env

for arg in "$@"
do
    var_name=$(echo $arg | cut -d';' -f1)
    var_value=$(echo $arg | cut -d';' -f2)
    echo $var_name=$var_value >> .env
done

echo "###< docker configuration ###" >> .env

echo "" >> .env
echo "###> mysql configuration ###" >> .env
echo "MYSQL_SERVER_VERSION=8.0.33" >> .env
echo "MYSQL_ROOT_PASSWORD=root" >> .env
echo "###< mysql configuration ###" >> .env

echo "" >> .env
echo "###> phpmyadmin configuration ###" >> .env
echo "PHPMYADMIN_VERSION=5.2.1" >> .env
echo "###< phpmyadmin configuration ###" >> .env