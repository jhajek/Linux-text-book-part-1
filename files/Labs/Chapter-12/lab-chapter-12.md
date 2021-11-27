# Lab - Chapter 12

## Pre-reqs and Assumptions

Using two virtual machines, while powered off, in the VirtualBox settings, enable a second bridged network interface and set the type to **Bridged Adapter** (details are in last chapter and the VirtualBox networking details are in chapter 03).

1) Use the command to identify the IP address of each of the two systems

   a. Capture a screenshot of both systems IP addresses
   b. Use the `ping` tool to ping the each others IP and its results (ctrl +C to quit), take a screenshot of the results
   b. Modify the `/etc/hosts` file and add an entry for both system in both systems give them the hostname host1 and host2
   c. Execute the `ping` command again this time using the hostname declared in the `/etc/hosts` file and capture a screenshot of the results

2) Use the command to display you MAC address of the network connection used in question 1, and in your screenshot highlight the MAC address

3) Use the command to display your IP address of the network connection used in question 1, and in your screenshot highlight the Netmask/CIDR block

4) On Ubuntu Desktop, Fedora Desktop, and Ubuntu Server -- determine if you are running Systemd-Networkd or Network-Manager. On each system run these commands and take a screenshot of each results:

   a. `sudo systemctl status systemd-networkd`
   b. `sudo systemctl status NetworkManager`

5) On Ubuntu and Fedora Desktop, use the command: `sudo systemctl status firewalld` check to see if firewalld is enabled, if its not installed, use the package manager to install the package `firewalld`

6) Using firewalld, open port 22 permanently to allow SSH connections to your Fedora system, take a screenshot of the command `sudo firewalld-cmd --list-all` to show the port is open

7) Using firewalld, open port 80 permanently to allow SSH connections to your Fedora system, take a screenshot of the command `sudo firewalld-cmd --list-all` to show the port is open

8) If needed, install Nginx Webserver, and enable the proper firewall port (443) to serve pages over **https** following [this Digital Ocean configuration tutorial](https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-nginx-in-ubuntu-20-04-1 "Digital Ocean Self-signed Nginx cert config").  Take a screenshot of the webbrowser showing the [https://127.0.0.1](https://127.0.0.1 "https example")

9) On an OS of your choice, install Node.js version 16.x and use NPM to install the `express` package.  Using the sample, "Hello World" code provided in the chapter, take a screenshot of the output of opening a browser on your Virtual Machine at the URL: http://127.0.0.1:3000 -- **Note** - from the directory where your app.js file is you will need to run `node app.js` to start the server and make sure that port 3000 is open in the firewall

10) Going to [Wordpress.org](https://wordpress.org "Wordpress install") and download the latest tar.gz file.  Follow the 5 minute setup to configure a working WordPress blog -- installing all the needed dependencies, initialize the WordPress system and create a simple blog post named: "Hello World" as the screenshot to prove the work was done on the OS of your choice
