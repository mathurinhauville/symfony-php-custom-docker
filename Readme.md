# Symfony and PHP in docker with custom version (no DB)

**This project is inspired by [@yoanbernabeu](https://github.com/yoanbernabeu)** with this [project](https://github.com/yoanbernabeu/symfony6-php8-in-docker-compose)

This is an easy way to have multiple projects with custom versions of PHP and Symfony. The main idea is to clone a single time this project and from him you will be able to create multiple projects with different versions of PHP and Symfony with a container for each project.

> **Note:** This project is not intended to be used in production. It's only for development.

## Installation

Clone the project

```bash
git clone https://github.com/mathurinhauville/php-symfony.git
```

Create a new project 

```bash
make new
```

You will be asked to enter the path of your project, his name, the Symfony and PHP version you want to use and the port of the Symfony server.

For example, if you want to create a project with **Symfony 6.2** and **PHP 8.1.0** on the **port 9000**, you will have to enter this informations :

```
$ Path for the new project : /Users/toto/dev
$ Project name : my-project
$ Symfony version : 6.2
$ PHP version : 8.1.0
$ Symfony server port : 9000
$ Do you want to continue ? [y/n] y
```
Then, a container will be created with the Symfony and PHP version and the project will be created in the path you entered.
Just after this operation, the container will be deleted.

Go to the project 

```bash
cd /Users/toto/dev/my-project
```

Start the project

```bash
make start
```
That will recreate the container and launch the symfony server.

## Ready to use
Your project is now ready to use, you can access it at this url : http://localhost:9000 (the port you enter before, 9000 in this example).

## Usage
The project is base with a Makefile, so you can use the following commands :

Create the container and lauch the Symfony server
```bash
make start
```
Erases the container
```bash
make stop
```
Restart the container
```bash
make restart
```
Enter in the container
```bash
make shell
```
