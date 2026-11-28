# Lab - Chapter 12

## Outcomes

This lab will have you installing and configuring your own Wordpress blog. This has setup steps that require you install and configure a webserver, a database, and many packages of pre-reqs.

### Pre-reqs and Assumptions

* Assume that you have a second `Host-Only` network adapter attached to the VM you will use for this lab.
* Install needed services as required
* You may have to disable or stop additional services if they are already running
* For this lab, we wil use `Nginx` as our webserver
* You will use `Ubuntu Server` as your Wordpress blog server
  * Configure, install, and enable openssh server
* From your `SSH client` configure Password-less Key Authentication to your Ubuntu Server instance
  * Execute and demonstrate all commands below while remotely connected to the Ubuntu Server from your Linux Desktop OS.

### Part One - Wordpress Install

```bash
# Pre-reqs needed for Debian/Ubuntu Desktop and Server
sudo apt install -y nginx mariadb-server php8.5 php8.5-cli php8.5-mysql php8.5-curl 
php8.5-gd php8.5-mbstring php8.5-xml php8.5-zip

# Pre-reqs needed for Fedora Desktop
sudo nginx mariadb-server php php-cli php-common php-json php-mbstring php-opcache 
php-gd php-xml php-zip php-mysqlnd

# On either distro execute the commands to start and enable both
# mariadb-server and nginx
sudo systemctl start nginx mariadb-server
sudo systemctl enable nginx mariadb-server
```

Following the [Wordpress Blog installation instructions](https://developer.wordpress.org/advanced-administration/before-install/howto-install/ "webpage for Wordpress Installations") we will now commence to setup our database to get ready for Wordpress.

* Start and enable the `mariadb-server` service
* Start and enable the `nginx` service
* From the section of this chapter entitled: **Inline SQL commands**
  * Use the `mysql` command inline option (-e) to create a database named: `wordpress_db`
  * Use the `mysql` inline option (-e) to create a non-root user named: `wp_user`
  * Use the `mysql` inline option (-e) to grant the user, `wp_user`, the proper permissions needed for WordPress
* From the command line using the `wget` command, retrieve the WordPress Installer Zip file 
  * [https://wordpress.org/latest.zip](https://wordpress.org/latest.zip "webpage for latest download of Wordpress")
* Move the entire extracted wordpress directory 
  * Into `/var/www/html/` if you are using Ubuntu Desktop
  * Into `/usr/share/nginx/html/` if you are using Fedora Desktop
* In the moved directory, rename the file `wp-config-sample.php` to `wp-config.php` in the `/var/www/html/wordpress` directory or `/usr/share/nginx/html/wordpress` 
  * Using the `sed -i` command find and replace in `./wp-config.php` the place holders on line 23, 26, and 29
  * See textbook section: **8.5.2.1** sed infile find and replace using -i
  * Use the values you created when setting up the Mariadb server 
* Install `firewalld` via the apt package manager
  * Enable and start the `firewalld service` and permanently open port `80/tcp` or `http` on the public zone

### Part Two - Render the Blog Webpage

* From your HOST system, open a web browser and navigate to http://IP-of-ubuntu-server/wordpress 
  * Complete the manual portion to setup a WordPress User, login to your new WordPress installation. 
  * Create a single new blog post that posts a picture of you and the University Logo at the bottom of your post 
  * The image in located in the textbook sample code: files > Chapter-12 > logos > illinois-tech-logo.jpg
