# Appendix D - Final Project
![*Projects sometimes get out of hand...*](images/Chapter-Header/Appendix-D/cautionary.png "Project gets out of hand")

This Appendix lists the final project that applies all of the learned concepts and puts it together into a single deliverable.

## Objectives

* Item 1
* Item 2
* Item 3

## Outcomes

At the conclusion of this project your will...


### Deliverable

Place Deliverable Here

### Part 1

You are to create a client server application using a webserver and a database.   The webserver will retrieve data from the database.  The database will be pre-configured to allow only connections from the webserver.

It is recommended to complete these steps manually first then taking note, write the events into a shell script for the automation process.

You will use Packer.io to build two systems that have all the necessary code, configurations, and setup needed to deploy the entire webserver and database.

The database server will have:

* Install needed packages
  + zfsutils and mysql-server
* Preseed the root database password in the debconf set-selection section
* Preseed the contents of the root password in a ~/.my.cnf file to use later in running database CREATE and INSERT scripts
* Enable firewall
  + Open Firewall port connection to 3306 for only the webserver's IP
* A second and third hard drive partition attached 
* Create a zpool called **datapool** accross /dev/sdb and /dev/sdc
  + Mount this zpool to ```/mnt/datadisk``` and change permissions and ownership so that **vagrant** owns it
* Modify the default location of the MySQL database to be on the ```/mnt/datadisk``` location
* Modify the default setting to allow MySQL to listen on external connections
* Create a zpool snapshot 
* enable mysql to start at boot and start mysql service
* Clone sampel code at https://github.com/jhajek/db-samples.git




### Part 2