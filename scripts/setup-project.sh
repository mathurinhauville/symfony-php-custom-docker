#!/bin/bash

bind TAB:menu-complete
trap cleanup SIGINT

# stop properly the script
function cleanup() {
  exit 0
}

#---------------------------------------------PROJECT SETUP---------------------------------------------#

#set the path for the new project
while true; do
  echo -e "\n\033[32mPath for the new project (e.g. \033[33m/dev\033[0m):\033[0m"
  read -e -p "> " path_project

  if ! [ -e "$path_project" ]; then
    echo -e "\033[31mThe path \033[4m$path_project\033[0m \033[31mdoes not exist\033[0m"
    continue
  fi
  break
done

#set the project name
while true; do
  echo -e "\n\033[32mProject name (e.g. \033[33mmy-project\033[0m):\033[0m"
  read -e -p "> " project_name

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
echo -e "\n\033[32mTimezone\033[0m [\033[33mUTC\033[0m]:"
read -e -p "> " timezone

if [ -z "$timezone" ]; then
  timezone="UTC"
fi

#---------------------------------------------PHP SETUP---------------------------------------------#

#set the php version
echo -e "\n\033[32mPHP version\033[0m [\033[33m8.2\033[0m]:"
read -e -p "> " php_version

if [ -z "$php_version" ]; then
  php_version="8.2"
fi

#---------------------------------------------SYMFONY SETUP---------------------------------------------#

#set the symfony version
echo -e "\n\033[32mSymfony version\033[0m [\033[33m6.3\033[0m]:"
read -e -p "> " symfony_version

if [ -z "$symfony_version" ]; then
  symfony_version="6.3"
fi

#set the server port
echo -e "\n\033[32mSymfony server port\033[0m [\033[33m9000\033[0m]:"
read -e -p "> " port_host

if [ -z "$port_host" ]; then
  port_host="9000"
fi

#---------------------------------------------MYSQL SETUP---------------------------------------------#

# ask if the user want to setup mysql
echo -e "\n\033[32mSetup mysql (\033[33myes / no\033[0m) ?\033[0m [\033[33myes\033[0m]:"
read -e -p "> " mysql

if [ -z "$mysql" ]; then
  mysql="yes"
fi

if [ "$mysql" = "yes" ]; then

  #set the mysql server version
  echo -e "\n\033[32mMysql server version\033[0m [\033[33m8.0.33\033[0m]:"
  read -e -p "> " mysql_version

  if [ -z "$mysql_version" ]; then
    mysql_version="8.0.33"
  fi

  #set the mysql root password
  echo -e "\n\033[32mMysql root password\033[0m [\033[33mroot\033[0m]:"
  read -e -p "> " mysql_password

  if [ -z "$mysql_password" ]; then
    mysql_password="root"
  fi

  #set the database name
  echo -e "\n\033[32mMysql database name\033[0m [\033[33mapp\033[0m]:"
  read -e -p "> " database_name

  if [ -z "$database_name" ]; then
    database_name="app"
  fi

  #---------------------------------------------PHPMYADMIN SETUP---------------------------------------------#

  # ask if the user want to setup phpmyadmin
  echo -e "\n\033[32mSetup phpmyadmin (\033[33myes / no\033[0m) ?\033[0m [\033[33myes\033[0m]:"
  read -e -p "> " phpmyadmin

  if [ -z "$phpmyadmin" ]; then
    phpmyadmin="yes"
  fi

  if [ "$phpmyadmin" = "yes" ]; then

    #set the phpmyadmin version
    echo -e "\n\033[32mPhpmyadmin version\033[0m [\033[33mlatest\033[0m]:"
    read -e -p "> " phpmyadmin_version

    if [ -z "$phpmyadmin_version" ]; then
      phpmyadmin_version="latest"
    fi
  fi
fi

#---------------------------------------------.ENV SETUP---------------------------------------------#

# remove the last slash if exists
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
make create
