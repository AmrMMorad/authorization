# Authorization
We need to develop a RESTful web service for providing authorization for users (identified by email and password) of different roles (identified by “name”) to resources (identified by “name”) with actions (can be READ, UPDATE, DESTROY).
The service is intended to be part of a microservice architecture that is accessed by  many other microservices. For Authentication, we will use JWT.
We need to implement 2 endpoints:
/login
Input (email and password)
Response (JWT token)

/authorize (authenticate and authorize)
Input (JWT token, role, resource, action)
Reponse
200 OK in case user have access
401 in case user don’t have access

We need to design Data Structure to meet the requirements of users and roles.
This assignment is deveoped using Sinatra + Sequel (instead of Rails)

## Environment
For the environment, we need to do the following:

#### Install Ruby
Ruby can be installed [here](https://www.ruby-lang.org/en/documentation/installation/). This code is written using Ruby 2.4

#### Install RubyGem
RubyGems can be installed [here](https://rubygems.org/pages/download). RubyGems is a package management framework for Ruby

#### Install bundler
The following command used to install bundler: 
	
	gem install bundler

Bundler is used to provide a consistent environment for Ruby projects. It tracks and installs the needed gems and versions.

#### Install MySQL
MySQL can be installed easily using that [link](https://dev.mysql.com/doc/refman/5.7/en/installing.html). This link explains how to install it on different environments.

## Installation instructions
First, we need to install the required gems by:

    bundle install

## Usage instructions
To run the code we need to do the following:

### Create database schema
Open the mysql database installed before and run the following command:
	CREATE DATABASE authorization
This creates a schema called authorization

### Adjust database.yml
This file contains the default database connection string for the different environments. The values of the username, password and even the database name can be changed according to your settings. Note: If you will change the database name, do not forget to create a schema with that name (review previous step)

### Run the migrations
Open the terminal in the project folder and run the following command:
	sequel -m db/migrate/ config/database.yml
This command runs the migrations and creates the needed tables and the associations between them.

### Run the server
Open the terminal in the project folder and run the following command:
	rackup
This command runs the server and initialize the tables with the needed test data. You can find the test data in seeds folder under config/seeds

### Send the requests to test
[Postman](https://www.getpostman.com/) is used to test the webservice. You can find its installation steps [under](https://blog.bluematador.com/posts/postman-how-to-install-on-ubuntu-1604/) for linux
To test login locally:
post localhost:9292/login
add to the body the email and password.
The response will be either 200 (ok) and the JWT token will be shown in the response body or will be 401 (unauthorized).

To test authorize locally:
post localhost:9292/authorize
add to the body the JWT token, role, action and the resource.
The response will be either 200 (ok) or will be 401 (unauthorized).

## Database structure
The following tables are used to implement the needed requirements:
### Users
This table contains the basic information for the user such as the email and password.

### Roles
This is considered the main table in the schema. This contains the role name in addition to a reference to the action that this roles accomplishes and another reference to the resource that this role is applied to. This can be considered a simple version of [RBAC](https://en.wikipedia.org/wiki/Role-based_access_control) (Role Based Access Control) which assumes many to many relationship.

### Roles_Users
This is considered the relation between the users and roles. This is considered the many-to-many realization of that reltionship.

### Actions
This table contains the basic information about the actions could be done on resources like name.

### Resources
This table contains the basic information about the resources like name.