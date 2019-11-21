# Appendix D - Final Project

![*Projects sometimes get out of hand...*](images/Chapter-Header/Appendix-D/cautionary.png "Project gets out of hand")

This Appendix lists the final project that applies all of the learned concepts and puts them together into a single deliverable.

## Objectives

* Understand and demonstrate how to use the concepts of automation by building and deploying servers using Packer and Vagrant
* Understand how to install software via shell script
* Understand how to preseed values for using MySQL database
* Understand and display knowledge of configuring the firewall service
* Understand how to create and disk partitions, create filesystems, and mount those partitions

## Outcomes

At the conclusion of this project, you will have successfully demonstrated the basic installation and system administration concepts talked about in this book.  Congratulations.

### Description

You are to create a client-server application using a webserver and a database.   The webserver will retrieve data from the database.  The database will be pre-configured to allow only connections from the webserver.

It is recommended to complete these steps manually first then taking notes, write the commands into shell scripts for the automation process. You will use Packer to build two systems that have all the necessary code, configurations, and setup needed to deploy the entire webserver and database.

### Part 1 Using Ubuntu 18.04

The database server will have:

* Using the Vagrantfile, configure the system to use a *Private Network* with the IP: 192.168.33.10
* Rename the host to: *dbhost*
  * Add an entry to `/etc/hosts` file of: 192.168.33.10   dbhost.example.com dbhost
  * Add an entry to `/etc/hosts` file of: 192.168.33.11   webhost.example.com webhost
* Install needed packages
  * `zfsutils` and `mysql-server`
* Preseed the root database password in the debconf set-selection section
* Preseed the contents of the root password in a ```~/.my.cnf``` file to use later in running database CREATE and INSERT scripts
* A second and third hard drive partition attached will be attached at creation time
* Create a zpool called **datapool** across /dev/sdb and /dev/sdc
  * Mount this zpool to ```/mnt/datadisk``` and change permissions and ownership so that user **vagrant** owns it
  * Add an entry for this disk to ```/etc/fstab``` to be mounted at boot time
* Modify the default location of the MySQL database to be on the ```/mnt/datadisk``` location
* Modify the default setting to allow MySQL to listen on external connections
* Create a zpool snapshot
* Enable mysql to start at boot and start the mysql service
* Find the 3 sample SQL files in the source code for the text.  In files > Appendix-D.  Copy these files into your Git repo and make the changes needed in the code relating to the FQDNs for database connections. (The database connection rules have the wrong IPs).
* Run from the mysql prompt the create.sql, insert.sql, grants.sql
* Enable firewall (firewalld or ufw)
  * Open Firewall port connection to 3306 for only the webserver's IP
  * Open Firewall port to allow connections for SSH on port 22 from any IP
* Choose one of the Secrets Management methods discussed in Chapter 13.

### Part 2 Using CentOS 7

The Webserver will have:

* Using the Vagrantfile, configure the system to use a *Private Network* with the IP: 192.168.33.11
* Rename the host to: *webhost*
  * Add an entry to `/etc/hosts` file of: 192.168.33.10   dbhost.example.com dbhost
  * Add an entry to `/etc/hosts` file of: 192.168.33.11   webhost.example.com webhost
* Install Apache2 or Nginx, php, php-mysql, and mysql-client library (just the client)
* We will be generating a self-signed cert (follow the Digital Ocean tutorial)
  * You can generate the cert manually or there is a process to automate the creation of a self-signed cert
* Modify the Webserver configuration to serve only on 443
* Enable and start the firewall service allowing connections on port 22 and port 80 and 443
  * Enable and start the Webserver Service
* Attach two additional virtual disks
* Format and create a mount point called ```/mnt/disk2``` and ```/mnt/disk3``` using LVM and XFS
  * Create an LVM volume PVs, VG, and LGs and a single LG with XFS on this volume.
  * Using the sample in chapter 11, create a systemd .mount file to mount this partition at boot time
  * You will need to install the proper package to use XFS
* Choose one of the Secrets Management methods discussed in Chapter 13.

#### Final Demonstration

Upon successful automated completion, open the webpage in a browser on your host system, display the 3 entries, now add one more quote from yourself and successfully post it to demonstrate mastery of the technology and concepts.

#### Optional Extra Project Components

* Adding HTTP/2 to the web browser support
* Using a NoSQL Database instead of MySQL/MariaDB

#### Notes

Here is a sample of using a multiline ```cat``` to create a text file

```bash

cat << EOT >> /home/vagrant/.bashrc

########## Inserted by Jeremy
export JAVA_HOME=/usr
export HADOOP_HOME=/home/vagrant/hadoop-2.6.5
export HADOOP_CLASSPATH=/usr/lib/jvm/java-8-oracle/lib/tools.jar
EOT
```

```bash
# This is sample code to add to a provisioner
# script that will pre-seed the password for a database.
export DEBIAN_FRONTEND=noninteractive
FRISTPASS="mariadb-server mysql-server/root_password password $DBPASS"
SECONDPASS="mariadb-server mysql-server/root_password_again password $DBPASS"
echo $FIRSTPASS | sudo debconf-set-selections
echo $SECONDPASS | sudo debconf-set-selections
```

Sample code is located in files > Appendix-D > packer-scripts. There are two packer build templates:

* ```centos-7-vanilla-multi-disks.json```
* ```ubuntu18041-vanilla-multi-drives.json```

These have the code needed for attaching additional disks at boot time via packer.  The pressed and ks directories are needed to make the ```packer build``` commands to work.  In addition, the ```post-processor``` shell scripts are in the directory ```../scripts``` you can use the ```post_install_vagrant.sh``` and the script ```post_install_vagrat-centos-7.sh``` for post-install customization via shell script.

## Deliverable

Create a folder in your private GitHub repo named **final-project** submit all Packer build scripts, preseed/kickstarts, and shell scripts needed to run and build this application.  Include a Readme.md with a screenshot that matches this screenshot and list any additional instructions or notes.

![*Final Project Output*](images/Appendix-D/output/final-results.png "Final Project Result")
