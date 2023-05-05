#!/bin/bash

echo "###> docker configuration ###" > .env
echo "### @author : https://github.com/mathurinhauville/symfony-php-custom-docker" >> .env

for arg in "$@"
do
    var_name=$(echo $arg | cut -d';' -f1)
    var_value=$(echo $arg | cut -d';' -f2)
    echo "$var_name=\"$var_value\"" >> .env
done

echo "###< docker configuration ###" >> .env