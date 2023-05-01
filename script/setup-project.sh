#!/bin/bash
source .env 

while true 
    do
    while true;
        do
        read -p "path for the new project : " path_project

        if ! [ -e "$path_project" ]; then
            echo -e "\033[31mThe path \033[4m$path_project\033[0m \033[31mdoes not exist\033[0m"
            continue
        fi
        break
    done

    while true;
        do
        read -p "project name : " project_name

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

    while true;
        do
        read -p "Symfony version : " symfony_version

        if [ -z "$symfony_version" ]; then
            echo -e "\033[31mPlease enter a symfony version\033[0m"
            continue
        fi
        break
    done

    while true;
        do
        read -p "PHP version : " php_version

        if [ -z "$php_version" ]; then
            echo -e "\033[31mPlease enter a PHP version\033[0m"
            continue
        fi
        break
    done

    echo -e "\033[32mYour symfony project will be created in \033[4m$path_project/$project_name\033[0m \033[32mwith PHP $php_version and symfony $symfony_version\033[0m"

    read -p "Do you want to continue ? [y/n] " reply
    if [ "$reply" = "y" ] || [ "$reply" = "Y" ]; then
        if grep -q "^PATH_PROJECT=" .env; then
            sed -i~ '/^PATH_PROJECT/d' .env
        fi
        
        if grep -q "^PROJECT_NAME=" .env; then
            sed -i~ '/^PROJECT_NAME/d' .env
        fi

        if grep -q "^CONTAINER_NAME=" .env; then
            sed -i~ '/^CONTAINER_NAME/d' .env
        fi
       
        if grep -q "^SYMFONY_VERSION=" .env; then
            sed -i~ '/^SYMFONY_VERSION/d' .env
        fi

        if grep -q "^PHP_VERSION=" .env; then
            sed -i~ '/^PHP_VERSION/d' .env
        fi

        echo -e "PATH_PROJECT=$path_project" >> .env
        echo -e "PROJECT_NAME=$project_name" >> .env
        echo -e "CONTAINER_NAME=dev.$project_name" >> .env
        echo -e "SYMFONY_VERSION=$symfony_version" >> .env
        echo -e "PHP_VERSION=$php_version" >> .env

        rm .env~
        make call-by-script
        exit 0
    else
        exit 1
    fi
    continue
done