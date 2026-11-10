# Lab - Chapter 09

At the outcome of this lab you will be able to successfully understand how to apply the sudo/root user paradigm. You will understand the binary logging mechanism of journald. You will be able to add, delete, and modify user accounts. Finally, you will be able to successfully setup and establish remote connections.

Using the examples and exercises in this chapter you will be able to succesfully and securely connect remotely to a remote server. You will be able to isntall a web server and run it as a service. You will be able to troubleshoot issues using the system logs and the journal and you will be able to modify a sudoers file.

Pre-reqs:

* You will use two different vms for this lab. 
  * For instance, one Ubuntu Desktop and one Fedora Workstation instance (2 VMs)
  * Designate one of them your client and one your server
* Located at the end of this chapter are critical virtual machine setup steps, complete the additional steps under the header: __Additional Network Interface Setup for SSH__
  * These steps are required in order to make this Lab work
* You can find the ip address of your VMs from their terminal with the command: `ip address show`
  * On VirtualBox look for interface XX: `enp0s8`
  * On Parallesl look for interface YY: `enp0s6`
* Install any additional packages that the Lab requires

### Lab - Part One

Write a single shell script that executes the following statements and takes a single positional parameter where you enter a username: which will be **controller**

1) Using the command to add a user name `${1}` to your system, using the system default values and display the content of the `/etc/passwd` file to show that the user has been created

1) Using the the command to add a group named *itmo356* to your system. Then use the command to modify the user and append this additional group to the user controller you just created.  Issue the command that shows all of the groups a user is a member of.

1) Using the command to modify the user, `${1}` to add them to a *superuser* group (`sudo` on Ubuntu or `wheel` on Red Hat based)

1) Issue the commands to create a file named: `/etc/sudoers.d/disable-password-user`, make sure to have an if statement that check for the existence of this file.

1) Issue the commands to append the appropriate string to give the user, `${1}` `NOPASSWD:` ability in the /`etc/sudoers.d/disable-password-user` file

### Lab - Part Two

This portion of the lab requires some pre-reqs. It will be assumed that this portion is completed before you begin the lab deliverable.

* The next questions require some setup:
  * You need two virtual machines for this part
  * You will need to modify the Network settings to add a **Host-Only Network Interface**

  * Install **openssh-server** on Ubuntu (Server) via apt and Fedora via dnf
  * On both servers make sure to issue two additional commands to start the ssh server: `sudo systemctl enable sshd` and `sudo systemctl start sshd`
  * Use the command `ip address show` to find your IP addresses
  
1) On your client system, issue the command create an `ed25519` public key pair. 

1) On your client system issue the command to transfer that private key securely to your server via the `ssh-copy-id` command

1) From the client system, issue the command to connect remotely to the server system via password.  While remotely conneced to the server system create a file named: `/c/sshd/sshd_config.d/disable=-password.conf`.

1) On the server via the remot connection dit the cntents of the `/etc/sshd/sshd_condif.d/diable-password.conf` to set `PasswordAuthentication No` 

1) exit your remote session to the server

1) Reconnect via SSH to your server without using the password demonstrating that you have enabled Public key auth only

1) From your client system remotely connect to your server system via SSH, issue the command to install the `apache2` webserver. On Ubuntu, the package is named `apache2` but on Fedora and Red Hat based operating systems it is named: `httpd`.

1) Remotely connected to your server, issue the commmands to enable and start the apache2 webserver. Then issue the `status` option via systemcl to show that the `apache2` server is in a running state.

1) On your client system open the Friefox webbrowser and browse to `http://` with the address ip address of the server and dispaly the welcome page.

1) Remotely connect to the server via SSH and modify the `index.html` page adding your name to the HTML. On your client system reload the webpage and demonstrate the change you have made.

1) Remotely connected to your server, and using `vim` create in the proper location a simple html file named: `helloworld.html`. In the file add the basic structure of an html file along with the words, "Hello World.". From your client system in the browser go to this new URL and display the content.

1) On the client system, in the browser change the URL from the previous steps and add /cats.html at the end (this will fail and cause a 404 error). Remotely connected to your server, using the logs files, show this connections details in the `access.log`

1) Remotely connected to your server now install the webserver package for `nginx`. You will receive an error message once it starts. Use the `sudo systemctl status nginx` command to see the status of the nginx webserver service.

1) Use the `journalctl` command for the `nginx.service` to display the error message.

1) Use the `sudo systemctl disable` command to stop the `nginx` service from starting at boot.

### Extra Assignment Lab - Part Three

#### SSH Client and Server Hardening Guides

Complete the commands mentioned from the section titled: `SSH Client and Server Hardening`. Save the audit output and then complete the Hardening Guide below and run the audit again and explain the difference between the results and what has changed. You may research the details of the algorithms. Compare the default results of Ubuntu Desktop and Fedora Desktop. Are there any differences?

Using the link provided, both client and server hardening guides are located at [https://www.ssh-audit.com/hardening_guides.html](https://www.ssh-audit.com/hardening_guides.html "SSH hardening guides"). Use the Ubuntu version closest to the current version and for Fedora Linux make use of the Rocky Linux guides.
