# Final Projects

![*Projects sometimes get out of hand...*](../../images/Chapter-Header/Appendix-D/cautionary.png "Project gets out of hand")

The list of final projects that applies all of the learned concepts and puts them together into a single deliverable.

## Objectives

* Demonstrate familiarity with creating shell scripts and bash syntax
* Demonstrate understanding of the ZFS Filesystem and commands to create and manage zpools
* Demonstrate how to install software via a shell script
* Demonstrate how to configure industry standard software (Wordpress)

## Outcomes

At the conclusion of this project, you will have successfully demonstrated the basic installation and system administration concepts talked about in this book.  Congratulations.

### Assumptions and pre-reqs

For this final deliverable you will need to use a fresh install of either Fedora or Ubuntu Desktop or Ubuntu Server - you will only need one instance. Attach 2 Virtual Disks of 2 GB before you start this install.  Also before starting the install of your virtual machine add an additional network interface to VirtualBox and create a bridged network so a DHCP address is received.

You will need to use the `-y` flag when you install packages via the package manager to auto answer yes to the install questions.  If you restore snapshots -- you will have to re-add your disks and re-enable your bridged network adapter.

Copy the `final-project` folder from the Textbook sample code to your own private GitHub repo.

### Requirements

This final project will consist of writing a single shell script that will accomplish all of the defined tasks below.  Essentially taking parts of lab 8-12 and automating them into one single shell script -- with a small amount of manual work.  You will submit your shell-script to Blackboard and push it to your private GitHub repo.  During the final exam period you will demonstrate it live on a clean OS install.

You will create a single shell script (use the template provided in files > final-project > final-XYZ.sh), rename the shell script (the XYZ replace with your initials, and place your name the section requested in the header of the script).

You will need the `git` package pre-installed and issue the command to clone your your own private repo to the Virtual Machine and `cd` into your `itmo-356 > files > final-project` directory, execute the `final-XYZ.sh` shell script and it will execute the following 8 sections:

#### Section One - Chapter 8

1. From section 8.3.2.1, issue the command to read the contents of the file roster.txt into a shell variable named: NAMES

#### Section Two - Chapter 8 & 9

1. From section 8.3.4.4, create a for loop that will loop through the Array NAMES using NAME as the instance variable and do two things:
1. Issue the `useradd` command to create a user account for each of the items in the array NAMES
1. `sudo useradd -c "User for ITMO-356 Final" -d /home/$NAME -m $NAME`
1. Echo to the screen a message: User $NAME was created
1. After the loop in complete, issue a command to display the content of the `/etc/passwd` file to show the new accounts have been created

#### Section Three - Chapter 9

1. Issue the command to show the IP addresses of the system
1. Install the Apache2 webserver (Ubuntu: apacehe2 or Fedora: httpd)
1. Enable and start the service if on Fedora
1. Using the `systemctl` command display the status of the Apache2/httpd service

#### Section Four - Chapter 10 and 11

1. For Ubuntu create a ZFS 2 disk mirrored pool named: datapool with the two disks you attached before you started the install
1. This requires you to prior install `zfsutils-linux` via the apt package manager for Ubuntu
1. Type the command based on your distro: `sudo zpool status`
1. Or if on Fedora create a Btrfs mirrored pool named: datapool with the two disks you attached before you started the install
1. Type the command `sudo btrfs filesystem show` to display details of the filesystem you just created (no need to mount)

#### Section Five - Chapter 12

1. Install NodeJS 16.x per the instructions in section 12.4.4 of the textbook
1. Issue the command: `node -v` to display the version of NodeJS
1. Issue the npm command to install the package: `express`

#### Section Six - Chapter 11 and 12

1. Issue the apt-get command to install firewalld and to enable and start the service
1. Issue the firewall-cmd command to permanently open these services: http and https
1. Issue the firewall-cmd command to permanently open port 3000/tcp
1. Reload the firewalld service to accept changes
1. Issue the ~~firewalld-cmd~~ `firewall-cmd --zone=public --list-all`  to show the open ports

#### Section Seven - Chapter 11 and 12

1. Install these packages via apt-get: apache2 mariadb-server php php-mysql
1. Restart the Apache2 service via `systemctl` to initialize the PHP language interpreter
1. Issue the mysql command to import the SQL files for creating a database and creating a user: `sudo mysql -u root < create-database.sql` and `sudo mysql -u root < create-user-and-grant-permissions.sql`

#### Section Eight - Chapter 8, 9 & 12

1. Using the `wget` command: retrieve the Wordpress tarball from [https://wordpress.org/latest.tar.gz](https://wordpress.org/latest.tar.gz "Wordpress Tarball link")
1. Extract the tarball -- using the command `tar -xvzf latest.tar.gz`
1. Rename/move the file in the `wordpress` directory using relative paths: `wp-config-sample.php` to `wp-config.php`
1. Use the `sed` command to find and replace the value: `database_name_here` with the value `wp` (section 8.5.2) in the `wp-config.php` in the `wordpress` directory
1. Use the `sed` command to find and replace the value: `username_here` with the value `worker` (section 8.5.2) in the `wp-config.php` in the `wordpress` directory
1. Use the `sed` command to find and replace the value: `password_here` with the value `cluster` (section 8.5.2) in the `wp-config.php` in the `wordpress` directory
1. Move the directory, `wordpress`, to the `/var/www/html` directory

### Live Demo Requirements

Log into the system and run your shell script and show the following:

1. Log into the virtual machine and complete the Wordpress installation.  Share your IP address and I will connect and make a post.

### Points breakdown

Point total is 100 points.

* 80 points for the code
  * 10 points for the each of the 8 items required
* 10 points for demonstrating working code during the final exam period and the demonstration of a successful blog post
* 10 points for me successfully running your script recreating what you demonstrated

## Deliverable

Create a folder in your private GitHub repo, under the itmo-356 directory, create a folder named **final-project** and in the directory push:

* Your shell-script named: `final-XYZ.sh` -- XYZ is your initials
* And all the supporting files needed to execute your script successfully
* Submit to Blackboard the URL to this file
