#!/bin/bash

# Path: scripts/setup-project.sh
#
# Script to read the environment variables and set them with the script setup-env.sh
# It's called by the Makefile on the command "make new"
#
# This project is available on github : https://github.com/mathurinhauville/symfony-php-custom-docker
# @Author : https://github.com/mathurinhauville

source .env 
bind TAB:menu-complete
trap cleanup SIGINT

# stop properly the script
function cleanup() {
    rm -f .tmp
    ./scripts/reset-env.sh
    exit 0
}

while true 
    do

    #set the path for the new project
    while true;
        do
        read -e -p "[1/6] Path for the new project : " path_project

        if ! [ -e "$path_project" ]; then
            echo -e "\033[31mThe path \033[4m$path_project\033[0m \033[31mdoes not exist\033[0m"
            continue
        fi
        break
    done

    #set the project name
    while true;
        do
        read -p "[2/6] Project name : " project_name

        if [ -z "$project_name" ]; then
            echo -e "\033[31mPlease enter a project name\033[0m"
            continue
        fi

        if [ -d $path_project/$project_name ]; then
            echo -e "\033[31m$project_name already exists in $path_project\033[0m"
            continue
        fi

        if [[ ! "$project_name" =~ ^[a-zA-Z0-9_-]+$ ]]; then
            echo -e "\033[31mIncorect format for \033[4m$project_name\033[0m"
            continue
        fi
        break
    done

    #set the symfony version
    while true;
        do
        read -p "[3/6] Symfony version : " symfony_version

        if [ -z "$symfony_version" ]; then
            echo -e "\033[31mPlease enter a symfony version\033[0m"
            continue
        fi
        break
    done

    #set the php version
    while true;
        do
        read -p "[4/6] PHP version : " php_version

        if [ -z "$php_version" ]; then
            echo -e "\033[31mPlease enter a PHP version\033[0m"
            continue
        fi
        break
    done

    #set the server port
    while true;
        do
        read -p "[5/6] Symfony server port : " port_host

        if [ -z "$port_host" ]; then
            echo -e "\033[31mPlease enter the server port\033[0m"
            continue
        fi
        break
    done

    echo -e "\033[34m[6/6] Your symfony project will be created in \033[4m$path_project/$project_name\033[0m \033[34mwith PHP $php_version and Symfony $symfony_version on port $port_host \033[0m"

    #validate the configuration
    read -p "Do you want to validate ? [y/n] " reply
    if [ "$reply" = "y" ] || [ "$reply" = "Y" ]; then

        #set the environment variables
        ./scripts/setup-env.sh "PATH_PROJECT;$path_project" \
                     "PROJECT_NAME;$project_name" \
                     "SYMFONY_VERSION;$symfony_version" \
                     "PHP_VERSION;$php_version" \
                     "PORT_HOST;$port_host"

        #create the project
        make create
        
        break
    else
        break
    fi
    continue
done