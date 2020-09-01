# Lab - Chapter 10

__Objectives:__

* Modify GRUB settings
* Use `systemctl` to start, stop, and examine processes in systemd
* Use `systemd-analyze` to understand what services are loading during system boot
* Change systemd targets.
* Use the `nice` command to modify a process' priority.
* List the kernel modules currently loaded on your Linux system.

__Outcomes:__

At the conclusion of this lab, you will be able to manage, edit, and list system processes in systemd--helping you to master the concepts of systemd.

1) Change the default GRUB settings in Ubuntu by adding a background image (preferably dark) and removing or disabling the `quiet splash` option. Make sure to execute `update-grub` before rebooting or else your changes won't be written.

1) Use the `systemd-analyze` tools to print out the most recent boot time for your system.

1) Install MariaDB server, `sudo dnf install mariadb-server`.
   a) Use the command `systemctl status <servicename>` after MariaDB is installed to display its current status, enable the service via `systemctl`, and then start the service. Finally, reboot your system.

1) With MariaDB enabled, use the `systemd-analyze` tools to print out the most recent boot time for your system again and compare if adding this service increased boot times.

1) Use `systemd-analyze blame` to collect start times of each element after installing and enabling the MariaDB service.

1) Use `systemctl` to enable and start the httpd.service (Fedora).

1) Use `systemctl` to SIGHUP the httpd.service (Fedora).

1) Change the `systemd` target to the systemd commandline-only level, display the `systemd` default target level, and then change back to the GUI target (or runlevel5).

1) Using systemctl and the `--show` option, display the "After" and "Wants" properties of the sshd.service.

1) Use the `nice` command to set the priority of a process - create/compile a C infinite loop program and `nice` it to lowest priority and then highest priority.  Open a second terminal tab/window and use `htop` (install it if needed) to display that process' system usage.

1) Launch multiple tabs in Firefox using this command: `firefox -new-tab -url krebsonsecurity.com -new-tab -url twit.tv/floss/`
   a) Find the process IDs via `ps -ef` and kill those tabs/processes with a `kill -2` command.
   b) Repeat the above launch command and this time use systemd and the proper cgroups to kill the FireFox processes.

1) Using `lsmod` and `grep`, list all of the kernel modules loaded on your system that contain VirtualBox (search for `vb*`).

1) Run the systemd `systemctl` command to list the VirtualBox kernel modules that are loaded.

1) Run the command that will list all the PCI devices attached to your system.

1) Type one of the two commands mentioned in the chapter to display info about your CPU hardware.

1) Using `systemctl`, find the cgroup for the apache2 webserver (known as httpd on Fedora) and issue a SIGHUP to the entire cgroup.

1) Using `systemd-cgls`, list and filter the output to show the sub-process IDs for the httpd.service or apache2.service.

1) Use the `timedatectl` command to change the clock of your system to UTC.

1) Use the `hostnamectl` command to:
   a) set-hostname to itmo-556-xyz (xyz is your initials)
   b) set-location to: d1r1u22
   c) set-chassis to: vm
   d) set-deployment to: development

1) Install a copy of Devuan Linux from [devuan.org](https://devuan.org "Devuan Linux"). Take a screenshot of the `ps -ef` command focusing on PID 1.
   a) Install the OpenRC init system via `sudo apt-get install openrc`
   b) The install process asks you to run a command after successful install: ```for file in /etc/rc0.d/K*; do s=`basename $(readlink "$file")` ; /etc/init.d/$s stop; done```
   c) Explain what this command is doing.
   d) Reboot the system and take a screenshot of the output of the `ps -ef` command focusing on PID 1.

1) What would be the command to change the systemd target runlevel to recovery mode?  Execute this command and take a screenshot of the result.

1) Review the content of the mysql.service file. List the contents of the `[Install]` header that must load before and after the mysql service starts.

1) Using GCC `sudo dnf install gcc` or `sudo apt-get install build essential`, create and compile a simple C++ code that is an infinite loop -- just put `while true` in the body of main.   Execute this script (note you could do this in Python as well, your choice).  Use ```systemd-cgtop``` to display the usage and capture that output.
   a) use the `ps` and various filters to show only information related to this process.
   b) use the `systemd-cgls` command and filters to display the process information
   c) use the kill command from systemd to kill the cgroup related to the infinite loop process.

1) Find the sample file located in: files > Chapter-10 > python > write-journal.py and copy it to any directory but NOT your home directory (you can use `/usr/local/bin`). Create a systemd service file called write-journal.service.  Have the service file execute this python script (use absolute paths).  Use the commands to **enable** and **start** the service.  Use the `sudo journalctl -xe` command to show the output in the systemd logs at boot and after the system has loaded.
