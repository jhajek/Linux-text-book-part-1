# Lab - Chapter 12

Structure of Assessment: For this assessment you will need to execute various setup steps and capture those commands as part of the final deliverable 

## Outcomes

In this assessment you will using Linux shell scripting to create a WordPress Blog on an Ubuntu Server 22.04 LTS 

### Lab Pre-requisites 

* You will need to create a fresh Ubuntu 22.04 LTS server virtual machine.
  * You will need to enable an additional host-only network interface 
  * (before first installation boot) and install and enable openssh-server.   
* You can execute the setup commands remotely from a newly created Fedora 39 Workstation virtual machine 
  * that also has an additional host-only network enabled.   
* For the next set of questions, you will need to SSH into the Ubuntu 22.04 LTS from your Fedora install 
  * Then configure various pieces of software then answer questions based on those installs on the Ubuntu Server 22.04 LTS remotely  

#### Deliverable: 

Submit a screenshot of the final blog post and the shell script that scripts the following to your week-14 folder in your private GitHub repo. These 11 steps need to be in your final shell script.

#### Part One - Shell Script

* Install all needed WordPress pre-reqs via the apt package manager (including vim, unzip, libapache2-mod-php, and php-mysqli).
  *  You won't need all of these but you can see here which ones WordPress requires -- [Server Dependencies list](https://make.wordpress.org/hosting/handbook/server-environment/ "website link for extra dependencies")
* Use the MySQL inline option (-e) to create a database named: `wp`
* Use the MySQL inline option (-e) to create a non-root user named: `wp-user`
* Use the MySQL inline option (-e) to grant the user, wp-user, the proper permissions needed for WordPress (section 12.5.2.6)
* Retrieve the WordPress Installer Zip file 
* Extract the WordPress code 
* Move the extracted wordpress directory to `/var/www/html/`
* Rename the file wp-config-sample.php to wp-config.php in the `/var/www/html/wordpress` directory 
* Using the sed command find and replace in `/var/www/html/wordpress/wp-config.php` the place holders on line 23, 26, and 29 
* Install `firewalld` via the apt package manager – enable and start the service and permanently open port 80/tcp for http traffic on the public zone
* Using the `chown` command change the ownership of the directory `/var/www/html/wordpress` to have owner and group be `www-data`, which is the apache2 webserver's username
  * Make sure to use the `-R` flag to recursively change the ownership in all sub-directories as well

#### Part Two - Manual Configuration Steps

* From your Fedora system, open a web browser and navigate to http://IP-of-ubuntu-server/wordpress 
  * Complete the manual portion to setup a WordPress User, login to your new WordPress installation. 
  * Create a single new blog post that posts a picture of you and the University Logo at the bottom of your post 
    * The image in located in the textbook sample code: files > Chapter-14 > logos > illinois-tech-logo.jpg
