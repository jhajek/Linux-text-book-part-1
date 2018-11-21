# Appendix D - Final Project
![*Projects sometimes get out of hand...*](images/Chapter-Header/Appendix-D/cautionary.png "Project gets out of hand")

This Appendix lists the final project that applies all of the learned concepts and puts it together into a single deliverable.

## Objectives

* Item 1
* Item 2
* Item 3

## Outcomes

At the conclusion of this project your will...

### Description

You are to create a client server application using a webserver and a database.   The webserver will retrieve data from the database.  The database will be pre-configured to allow only connections from the webserver.

It is recommended to complete these steps manually first then taking note, write the events into a shell script for the automation process.

You will use Packer.io to build two systems that have all the necessary code, configurations, and setup needed to deploy the entire webserver and database.

### Part 1 Using Ubuntu 18.04

The database server will have:

* Install needed packages
  + zfsutils and mysql-server
* Preseed the root database password in the debconf set-selection section
* Preseed the contents of the root password in a ```~/.my.cnf``` file to use later in running database CREATE and INSERT scripts
* A second and third hard drive partition attached will be attached at creation time 
* Create a zpool called **datapool** accross /dev/sdb and /dev/sdc
  + Mount this zpool to ```/mnt/datadisk``` and change permissions and ownership so that **vagrant** owns it
* Modify the default location of the MySQL database to be on the ```/mnt/datadisk``` location
* Modify the default setting to allow MySQL to listen on external connections
* Create a zpool snapshot 
* enable mysql to start at boot and start mysql service
* Clone sample code at https://github.com/jhajek/db-samples.git (note you will need to use sed on the files to replace the default IP values)
* Run from the mysql prompt the create.sql, insert.sql, grants.sql
* Enable firewall
  + Open Firewall port connection to 3306 for only the webserver's IP
  + Open Firewall port to allow connections for SSH on port 22 from any IP

### Part 2 Using CentOS 7

The Webserver will have:

* Install Apache2 or Nginx, php, and mysql-client library (just the client)
* We will be generating a self-signed cert (follow the Digital Ocean tutorial)
  + You can generate the cert manually or there is a process to automate the creation of a self-signed cert
  + https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-apache-in-ubuntu-16-04
* Modify the Webserver configuration to serve only on 443
* Enable and start the firwall service allowing connections on port 22 and port 80 and 443
  + Enable and start the Webserver Service
* Format and create a mount point called ```/mnt/disk1``` and ```/mnt/disk2``` 
  + create and LVM volume PGs, VG, and a single LG with XFS on this volume. 
  + You will need to install the proper package to use XFS

#### Extra Options

* Consul and service discovery
* Adding HTTP/2 to the webbrowser support
* Using a NoSQl Database instead of MySQL/MariaDB

## Deliverable

Create a folder in your private Github repo named **final-project** submit all Packer build scripts, preseed/kickstarts, and shell scripts needed to run and build this application.  Include a Readme.md with a screenshot that matches this screenshot and list any additional instructions or notes.

![*Final Project Output*](images/Appendix-D/output/final-results.png "Final Project Result")


