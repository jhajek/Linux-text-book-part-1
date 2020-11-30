# Appendix D - Final Project

![*Projects sometimes get out of hand...*](images/Chapter-Header/Appendix-D/cautionary.png "Project gets out of hand")

This Appendix lists the final project that applies all of the learned concepts and puts them together into a single deliverable.

## Objectives

* Demonstrate the advantages of automation by building and deploying servers
* Demonstrate how to install software via a shell script
* Demonstrate how to preseed values for using MySQL database
* Display knowledge of configuring the firewall service
* Display knowledge to create disk partitions, create filesystems, and mount those partitions at boot

## Outcomes

At the conclusion of this project, you will have successfully demonstrated the basic installation and system administration concepts talked about in this book.  Congratulations.

### Description

You are to create a client-server application using a webserver and a database.   The webserver will retrieve data from the database.  The database will be pre-configured to allow only connections from the webserver.

It is recommended to complete these steps manually first, then taking notes, write the commands into shell scripts for the automation process. You will use Packer to build two systems that have all the necessary code, configurations, and setup needed to deploy the entire webserver and database.

I recommend using the [OBS Studio project](https://obsproject.com/ "OBS Studio Project") for screen capture.  It is a cross platform OpenSource solution used for major podcast production, but is simple enough that can be used for screen recordings.  Deliver the Recording format using your school Google Drive account and enable access for me to retrieve it.

For deliverables, create a folder in your repo under itmo-556, named **final**.

### Part 1 - Using Ubuntu 18.04

Using Packer and Vagrant extending the sample templates, you will create a single pre-configured standalone Vagrant box (virtual machine), that will have WordPress basic installation configured upon the first `vagrant up` command.  The settings to make WordPress work automatically will be configured in the Packer **provisioner** shell script.

The following software will be installed and configured in the provisioner script of Packer:

1) Using deb-conf pre-seed the root database password
1) Install Apache2 webserver and MySQL server
1) From the WordPress.org tutorial, install any needed pre-req software
1) Using `sed`, modify user variables in the WordPress configuration file to allow for WordPress to work without the need for a user to manually configure WordPress
1) Change the hostname to **wp-host-xyz** xyz are your initials.
1) Change the timezone to UTC

The following actions need to take place to configure the Vagrant box:

1) Using Vagrant add the artifact generated from the output of the Packer command, name the box **wp**
1) Initialize the vagrant box using the name value as: `--name wp`
1) Modify the `Vagrantfile`, configure the system to use a *Private Network* with the IP: 192.168.33.100

The following actions need to be captured live in a short video:

1) Use the command `vagrant up` command to launch the Vagrant box (this command may take a few minutes to run that is fine you can just let the video run)
1) Open a Web Browser and navigate to the IP address set in the Vagrantfile
1) Display the working WordPress "hello world" message
1) Log into WordPress and create a simple post entitled, "Final" with content that says "done." Post it and return to the Welcome Screen showing the newly made post.
1) Close the browser tab
1) Issue the command `vagrant ssh` to ssh into the **wp** box
1) Display the changed hostname
1) Using the `timedatectl` command, display the timezone
1) Exit the ssh session
1) Issue a `vagrant halt` command -- this is last command to capture end video
1) Push all code used to construct this deliverable to GitHub (not the video) under the final folder, into a sub-folder named: **final-part-one**

### Part 2 - Using Fedora 32/Centos 8

Using two Virtual Machines (they can be constructed manually or in an automated fashion) from either Fedora or CentOS.  

  * Add an entry to `/etc/hosts` file of: 192.168.33.10   dbhost.example.com dbhost
  * Add an entry to `/etc/hosts` file of: 192.168.33.11   webhost.example.com webhost
* Install needed packages
  * `zfsutils` and `mysql-server`
* Preseed the root database password in the debconf set-selection section
* Preseed the contents of the root password in a ```~/.my.cnf``` file to use later in running database CREATE and INSERT scripts
* Create a second and third hard drive partition attached will be attached at creation time
* Create a zpool called **datapool** across /dev/sdb and /dev/sdc
  * Change permissions and ownership of `/datapool` so that user **vagrant** owns it
* Modify the default location of the MySQL database to be on ```/datapool```
* Modify the default setting to allow MySQL to listen on external connections
* Create a zpool snapshot
* Enable mysql to start at boot and start the mysql service
* Find the 3 sample SQL files in the source code for the text.  In files > Appendix-D > sql.  Copy these files into your Git repo and make the changes needed in the code relating to the FQDNs for database connections. (The database connection rules have the wrong IPs you need to adjust these).
* Run from the MySQL prompt the create.sql, insert.sql, create-user-with-grants.sql
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
* You will create an XFS formatted LVM logical volume using /dev/sdb and /dev/sdc.
  * Create an LVM volume: PVs, VG, and LGs and a single LG and format with XFS on this logical volume (Chapter 11).
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
