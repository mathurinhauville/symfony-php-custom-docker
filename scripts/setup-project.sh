#!/bin/bash
source .env 

#----------set the environment variables for the project----------#

while true 
    do

    #set the path
    while true;
        do
        read -p "Path for the new project : " path_project

        if ! [ -e "$path_project" ]; then
            echo -e "\033[31mThe path \033[4m$path_project\033[0m \033[31mdoes not exist\033[0m"
            continue
        fi
        break
    done

    #set the project name
    while true;
        do
        read -p "Project name : " project_name

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
        read -p "Symfony version : " symfony_version

        if [ -z "$symfony_version" ]; then
            echo -e "\033[31mPlease enter a symfony version\033[0m"
            continue
        fi
        break
    done

    #set the php version
    while true;
        do
        read -p "PHP version : " php_version

        if [ -z "$php_version" ]; then
            echo -e "\033[31mPlease enter a PHP version\033[0m"
            continue
        fi
        break
    done

    #set the server port
    while true;
        do
        read -p "Symfony server port : " port_host

        if [ -z "$port_host" ]; then
            echo -e "\033[31mPlease enter the server port\033[0m"
            continue
        fi
        break
    done


    echo -e "\033[32mYour symfony project will be created in \033[4m$path_project/$project_name\033[0m \033[32mwith PHP $php_version and Symfony $symfony_version on port $port_host \033[0m"

    #validate the configuration
    read -p "Do you want to validate ? [y/n] " reply
    if [ "$reply" = "y" ] || [ "$reply" = "Y" ]; then

        #set the environment variables
        ./scripts/setup-env.sh "PATH_PROJECT;$path_project" \
                     "PROJECT_NAME;$project_name" \
                     "SYMFONY_VERSION;$symfony_version" \
                     "PHP_VERSION;$php_version" \
                     "CONTAINER_NAME;project-$project_name-symfony$symfony_version-PHP$php_version" \
                     "IMAGE_NAME;php$php_version-symfony$symfony_version" \
                     "PORT_HOST;$port_host" \

        #build from the image if she exist
        docker images --quiet $image_name > .tmp

        if [ -s .tmp ]; then
            echo -e "\033[32mCreate the container and the project from an existing image\033[0m"
            make create-from-existing-image
        else
            echo -e "\033[32mCreate the container and the project from a new image\033[0m"
            make create
        fi

        rm -f .tmp

        break
    else
        break
    fi
    continue
done