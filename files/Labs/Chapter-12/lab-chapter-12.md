# Lab - Chapter 12

Structure of Assessment: For this assessment you will need to execute various setup steps and capture those commands as part of the final deliverable.

### Outcomes

This lab will have you installing and configuring your own Wordpress blog. This has setup steps that require you install and configure a webserver, a database, and many packages of pre-reqs. For this lab, we wil use `Nginx` and you can select if you use Ubuntu Desktop of Fedora Workstation.

#### Part One - Wordpress Install

```bash
# Pre-reqs needed for Ubuntu Desktop
sudo apt install -y nginx mariadb-server php8.5 php8.5-cli php8.5-mysql php8.5-curl php8.5-gd php8.5-mbstring php8.5-xml php8.5-zip

# Pre-reqs needed for Fedora Desktop
sudo nginx mariadb-srver php php-cli php-common php-json php-mbstring php-opcache php-gd php-xml php-zip php-mysqlnd

# On either distro execute the commands to start and enable both mariadb-server and nginx
sudo systemctl start nginx mariadb-server
sudo systemctl enable nginx mariadb-server
```

Following the [Wordpress Blog installation instructions](https://developer.wordpress.org/advanced-administration/before-install/howto-install/ "webpage for Wordpress Installations") we will now commence to setup our database to get ready for Wordpress.
* Start the MySQL service and from the section of this chapter entitled: **Inline SQL commands**
  * Use the MySQL inline option (-e) to create a database named: `wordpress_db`
  * Use the MySQL inline option (-e) to create a non-root user named: `wp_user`
  * Use the MySQL inline option (-e) to grant the user, `wp_user`, the proper permissions needed for WordPress
* From the command line using the `wget` command, retrieve the WordPress Installer Zip file 
  * [https://wordpress.org/latest.zip](https://wordpress.org/latest.zip "webpage for latest download of Wordpress")
* Move the entire extracted wordpress directory 
  * Into `/var/www/html/` if you are using Ubuntu Desktop
  * Into `/usr/share/nginx/html/` if you are using Fedora Desktop
* In the moved directory, rename the file `wp-config-sample.php` to `wp-config.php` in the `/var/www/html/wordpress` directory or `/usr/share/nginx/html/wordpress` 
  * Using the `sed -i` command find and replace in `./wp-config.php` the place holders on line 23, 26, and 29: see textbook section: **8.5.2.1 sed infile find and replace using -i**
  * Use the values you created when setting up the Mariadb server 
* Install `firewalld` via the apt package manager
  * Enable and start the `firewalld service` and permanently open port `80/tcp` or `http` on the public zone

#### Part Two - Manual Configuration Steps

* From your HOST system, open a web browser and navigate to http://IP-of-ubuntu-server/wordpress 
  * Complete the manual portion to setup a WordPress User, login to your new WordPress installation. 
  * Create a single new blog post that posts a picture of you and the University Logo at the bottom of your post 
    * The image in located in the textbook sample code: files > Chapter-12 > logos > illinois-tech-logo.jpg
