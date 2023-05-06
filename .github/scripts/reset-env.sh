#!/bin/bash

# Path: scripts/reset-env.sh
#
# Script to reset the environment variables
# It's called by the Makefile in the command "make reset"
#
# This project is available on github : https://github.com/mathurinhauville/symfony-php-custom-docker
# @Author : https://github.com/mathurinhauville

./scripts/setup-env.sh "PATH_PROJECT;." \
                     "PROJECT_NAME;my-project" \
                     "SYMFONY_VERSION;6.2" \
                     "PHP_VERSION;8.2" \
                     "CONTAINER_NAME;my-project-symfony6.2-PHP8.2" \
                     "IMAGE_NAME;php8.2-symfony6.2" \
                     "PORT_HOST;9000"