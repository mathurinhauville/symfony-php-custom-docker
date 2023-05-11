# Create and manage Symfony projects with custom versions of PHP and Symfony in Docker (no DB)

**This project is inspired by [@yoanbernabeu](https://github.com/yoanbernabeu) with [this project](https://github.com/yoanbernabeu/symfony6-php8-in-docker-compose)**

This is an easy way to create multiple Symfony projects with **custom versions of PHP and Symfony**. The main idea is to clone a single time this project and from him you will be able to create multiple Symfony projects with different versions of PHP and Symfony with a container for each project. 

Once the project is created you can share it with your team and they will able to **access it with a single command (make start)** without having to install PHP or Symfony and all the dependencies.

> **Note:** This project is not intended to be used in production. It's only for development.

## Requirements

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)
- [Make command](https://www.gnu.org/software/make/)
  

## Installation

First, please check [the list of PHP supported versions](https://www.php.net/supported-versions.php) and [the list of Symfony supported versions](https://symfony.com/releases).

**You can also check [this video](https://www.youtube.com/watch?v=Qws83k1iwS4) to see the process of installation and the possibilities that this project offers.**

Clone the project

```bash
git clone https://github.com/mathurinhauville/symfony-php-custom-docker.git
```

Place yourself in the repository and create a new project

```bash
make new
```

You will be asked to enter the path of your project, his name, the Symfony and PHP version and the port of the Symfony server.

For example, if you want to create a project with **Symfony 6.2** and **PHP 8.2** on the **port 9000**, you will have to enter this informations :

```
$ Path for the new project : /Users/toto/dev
$ Project name : my-project
$ Symfony version : 6.2
$ PHP version : 8.2
$ Symfony server port : 9000
$ Do you want to continue ? [y/n] y
```
>**Note:** For the Symfony version, please only specify the major and minor version of the software (such as 6.2) and don't include patch version (such as 6.2.10)

Then, a container will be created with the Symfony and PHP versions you entered and the project will be created in the path you specified.
Just after this operation, the container will be deleted.

If you want to set the environment variables manually, you can also edit the [.env](https://github.com/mathurinhauville/symfony-php-custom-docker/blob/main/.env) file and run the command [make create](https://github.com/mathurinhauville/symfony-php-custom-docker/blob/main/Makefile?plain=1#22).

Go to the Symfony project you just created

```bash
cd /Users/toto/dev/my-project
```

Start the project

```bash
make start
```
That will recreate the container and launch the symfony server.

## Enjoy
Your project is now ready to use, you can access it at this url : http://localhost:9000 (the port you entered before).

## Why it's cool ? 😎
#### Once you have created the Symfony project, you can :
- Share the project with your team and they will able to access it with a single command (make start) without having to install PHP or Symfony and all the dependencies.
- Change the PHP version of the project by editing the .env file and the command make restart 
- Also, from this repository, you can create multiple Symfony projects with different versions of PHP and Symfony.

>**Note:** If you change the Symfony version in the .env file of the Symfony project nothing will happen. The update of the Symfony version is not managed in this project for the moment.


## Usage
Once you have created the Symfony project, you can use the following commands :

Help
```bash
make help
```
Create the container and lauch the Symfony server
```bash
make start
```
Erases the container
```bash
make stop
```
Restart the container (delete and create)
```bash
make restart
```
Enter in the container
```bash
make shell
```
## How it works

- The command [new](https://github.com/mathurinhauville/symfony-php-custom-docker/blob/main/Makefile?plain=1#18) of the Makefile call the script [setup-project.sh](https://github.com/mathurinhauville/symfony-php-custom-docker/blob/main/scripts/setup-project.sh) and will ask you some informations about your project (path, name, Symfony and PHP version and port of the Symfony server). 
- Then, the informations will be saved in the [.env](https://github.com/mathurinhauville/symfony-php-custom-docker/blob/main/.env) file.
- The command [create](https://github.com/mathurinhauville/symfony-php-custom-docker/blob/main/Makefile?plain=1#22) will be automatically launched and will create the image with the PHP version that you entered before if it doesn't exist.
- A Symfony project will be created in the path you entered before.
- The [docker-compose.yml](https://github.com/mathurinhauville/symfony-php-custom-docker/blob/main/.copy/docker-compose.yml), [docker-compose.from-image.yml](https://github.com/mathurinhauville/symfony-php-custom-docker/blob/main/.copy/docker-compose.from-image.yml) and the [Makefile](https://github.com/mathurinhauville/symfony-php-custom-docker/blob/main/.copy/Makefile) from the [.copy](https://github.com/mathurinhauville/symfony-php-custom-docker/blob/main/.copy) folder and the [Dockerfile](https://github.com/mathurinhauville/symfony-php-custom-docker/blob/main/php-symfony/Dockerfile), and the [.env](https://github.com/mathurinhauville/symfony-php-custom-docker/blob/main/.env) will be copied in the Symfony project.
- The container will be deleted.
## The future of this project
For the moment the DB is not managed in this project, but I will add it in the future.
Also, I only test this project on MacOS ARM, so I will test it on Linux and Windows. **Please let me know if you have any issues.**

## Author 
[@Mathurin Hauville](https://github.com/mathurinhauville)
