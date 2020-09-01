# Lab - Chapter 13

## Part 1

Create a folder structure for 1 Ubuntu Bionic64 vagrant box and 1 CentOS 7 vagrant box.  In each of these folders use the ```vagrant init``` command to create a ```Vagrantfile```.  Upon succesfully executing the `vagrant up` command in both directories, take a screenshot of the output of the ```vagrant box list``` command.

## Part 2

Run the packer json build templates for CentOS 7 and Ubuntu 18.04 from the textbook source code located in ```files > Chapter 13 > packer-build-tempates```, for each template execute ```packer build centos-7-vanilla-json``` and ```packer build ubuntu18041-vanilla.json```.  Once these Vagrant boxes are built, use the ```vagrant box add``` command to add them to your Vagrant system.  Run the ```vagrant init``` command with the proper options to create a Vagrantfile and then run the ```vagrant up``` command to instantiate the box. Issue the command ```vagrant ssh``` and once logged in take a screenshot of the output of the command ```free --giga``` to list the amount of memory in the virtual machine.

Upon completion take a screenshot of the output of the ```vagrant box list``` command to show that these steps completed successfully.

## Part 3

Edit the Vagrantfile for both Vagrant boxes to run at 3072 RAM (3 GB) each.  Issue the command to reload and re-provision the virtual machines.  Upon successfully issuing this command, issue the ```vagrant ssh``` command and again execute the ```free --giga``` command to show that the memory adjustment actually took place. Take a screenshot of the results.

## Part 4

Utilize the ```vagrant destroy``` command.  On each of the four Vagrant boxes that have been created in the previous steps, execute the command to install the Apache2 webserver:

* ```sudo apt-get install apache2```
* ```sudo yum install httpd```

Take a screenshot of the output of the ```sudo systemctl status apache2``` or ```sudo systemctl status httpd``` command. Exit the Vagrant box.  Issue a ```vagrant destroy``` command, then a ```vagrant up``` command.  Issue the ```vagrant ssh``` command and reissue the above systemctl commands to show that all 4 boxes have been destroyed and rebuilt.  Take a screenshot of the results.
