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

This project will deploy and customize the existing Ubuntu 1804 packer build template located in the files > Appendix-D directory. You will configure the provisioner file under the **scripts** directory to customize the Packer build script, `post_install_vagrant.sh`. The purpose is to deploy a single node WordPress install.  Upon completion of the build task, you will import the Packer artifact (from the build directory) the Vagrant box (virtual machine) that was created and that will have WordPress basic installation configured upon the first `vagrant up` command.  The settings to make WordPress work automatically will be configured in the Packer **provisioner** shell script.

#### Packer Provisioner Requirements

The following software will be installed and configured in the provisioner script of Packer:

1) Using deb-conf pre-seed the root database password (yes you can hardcode the root password: ilovebunnies)
1) Install Apache2 webserver and MySQL server
1) From the WordPress.org tutorial, using `wget` retrieve the latest install zip file, install it, along with any needed pre-req software
1) Using `sed` and/or other tools, modify user variables in the WordPress configuration file to allow for WordPress to work without the need for a user to manually configure WordPress
1) Change the hostname to **wp-host-xyz**: xyz are your initials.
1) Change the timezone to UTC
1) During the Packer build, a second hard drive was attached. Install btrfs-progs and format that device.

#### Vagrant Requirements

The following actions need to take place to configure the Vagrant box:

1) Using Vagrant add the artifact generated from the output of the Packer command, name the box **wp**
1) Initialize the vagrant box using the name value as: `--name wp`
1) Modify the `Vagrantfile`, configure the system to use a *Private Network* with the IP: 192.168.33.100

#### Video Demonstration Requirements

The following actions need to be captured in a short video:

1) Use the command `vagrant up` command to launch the Vagrant box (this command may take a few minutes to run that is fine you can just let the video run)
1) Open a Web Browser and navigate to the IP address set in the Vagrantfile
1) Display the working WordPress "hello world" message
1) Log into WordPress and create a simple post entitled, "Final" with content that says "done." Post it and return to the Welcome Screen showing the newly made post.
1) Close the browser tab
1) Issue the command `vagrant ssh` to ssh into the **wp** box
1) Display the changed hostname
1) Using the `timedatectl` command, display the timezone
1) Exit the ssh session
1) Issue a `vagrant halt` command -- this is last command to capture -- after end the video
1) Push all code used to construct this deliverable to GitHub (not the video) under the **final-project** folder

## Deliverable

Create a folder in your private GitHub repo named **final-project** submit:

* All Packer build scripts, preseed/kickstarts, and provisioner shell scripts needed to run and build this application.  
* Include all Vagrant files needed to start the Vagrant box
* To blackboard submit the URL to your GitHub repo as well as a URL to the video recording (preferably uploaded to your Google Drive account)

### Points breakdown

Total point is 100.

* 80 points for the code
  * 10 points for the each of the 7 items required in Packer Provisioner Script Requirements
  * 10 points for completing all of the Vagrant Requirements
* 20 points for the video demonstrating the successful working code and the demonstration of a successful blog post
