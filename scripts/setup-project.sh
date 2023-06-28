#!/bin/bash

# Path: scripts/setup-project.sh
#
# Script to read the environment variables and set them with the script setup-env.sh
# It's called by the Makefile on the command "make new"
#
# This project is available on github : https://github.com/mathurinhauville/symfony-php-custom-docker
# @Author : https://github.com/mathurinhauville

bind TAB:menu-complete
trap cleanup SIGINT

# stop properly the script
function cleanup() {
  rm -f .tmp
  ./scripts/reset-env.sh
  exit 0
}

while true; do
  echo -e "\033[34m1) Project configuration\033[0m"

  #set the path for the new project
  while true; do
    read -e -p "[1/3] Path for the new project : " path_project

    if ! [ -e "$path_project" ]; then
      echo -e "\033[31mThe path \033[4m$path_project\033[0m \033[31mdoes not exist\033[0m"
      continue
    fi
    break
  done

  #set the project name
  while true; do
    read -p "[2/3] Project name : " project_name

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

  #set the timezone
  while true; do
    read -p "[3/3] Timezone (click enter for UTC) : " timezone

    if [ -z "$timezone" ]; then
      timezone="UTC"
    fi
    break
  done

  echo -e "\033[34m2) PHP configuration\033[0m"

  #set the php version
  while true; do
    read -p "[1/1] PHP version (click enter for latest) : " php_version

    if [ -z "$php_version" ]; then
      php_version="latest"
    fi
    break
  done

  echo -e "\033[34m3) Symfony configuration\033[0m"

  #set the symfony version
  while true; do
    read -p "[1/2] Symfony version (click enter for 6.3) : " symfony_version

    if [ -z "$symfony_version" ]; then
      symfony_version="6.3"
    fi
    break
  done

  #set the server port
  while true; do
    read -p "[2/2] Symfony server port (click enter for 9000) : " port_host

    if [ -z "$port_host" ]; then
      port_host="9000"
    fi
    break
  done

  echo -e "\033[34m4) Mysql configuration\033[0m"

  #set the mysql server version
  while true; do
    read -p "[1/3] Mysql server version (click enter for 8.0.33) : " mysql_version

    if [ -z "$mysql_version" ]; then
      mysql_version="8.0.33"
    fi
    break
  done

  #set the mysql root password
  while true; do
    read -p "[2/3] Mysql root password (click enter for root) : " mysql_password

    if [ -z "$mysql_password" ]; then
      mysql_password="root"
    fi
    break
  done

  #set the database name
  while true; do
    read -p "[3/3] Mysql database name (click enter for app) : " database_name

    if [ -z "$database_name" ]; then
      database_name="app"
    fi
    break
  done

  echo -e "\033[34m4) Phpmyadmin configuration\033[0m"

  #set the phpmyadmin version
  while true; do
    read -p "[1/1] Phpmyadmin version (click enter for latest) : " phpmyadmin_version

    if [ -z "$phpmyadmin_version" ]; then
      phpmyadmin_version="latest"
    fi
    break
  done

  #recapitulatif des informations saisies :
  echo -e "\033[34mPATH_PROJECT=$path_project\033[0m"
  echo -e "\033[34mPROJECT_NAME=$project_name\033[0m"
  echo -e "\033[34mTZ=$timezone\033[0m"
  echo -e "\033[34mPHP_VERSION=$php_version\033[0m"
  echo -e "\033[34mSYMFONY_VERSION=$symfony_version\033[0m"
  echo -e "\033[34mPORT_HOST=$port_host\033[0m"
  echo -e "\033[34mMYSQL_SERVER_VERSION=$mysql_version\033[0m"
  echo -e "\033[34mMYSQL_ROOT_PASSWORD=$mysql_password\033[0m"
  echo -e "\033[34mDATABASE_NAME=$database_name\033[0m"
  echo -e "\033[34mPHPMYADMIN_VERSION=$phpmyadmin_version\033[0m"

  #validate the configuration
  read -p "Do you want to validate ? [y/n] " reply
  if [ "$reply" = "y" ] || [ "$reply" = "Y" ]; then

    last_char=${path_project: -1}
    if [[ "$last_char" = "/" ]]; then
      path_project=${path_project%?}
    fi

    #set the environment variables
    ./scripts/setup-env.sh "PATH_PROJECT;$path_project" \
      "PROJECT_NAME;$project_name" \
      "TZ;$timezone" \
      "PHP_VERSION;$php_version" \
      "SYMFONY_VERSION;$symfony_version" \
      "PORT_HOST;$port_host" \
      "MYSQL_SERVER_VERSION;$mysql_version" \
      "MYSQL_ROOT_PASSWORD;$mysql_password" \
      "DATABASE_NAME;$database_name" \
      "PHPMYADMIN_VERSION;$phpmyadmin_version"

    #create the project
    #make create

    break
  else
    break
  fi
  continue
done
