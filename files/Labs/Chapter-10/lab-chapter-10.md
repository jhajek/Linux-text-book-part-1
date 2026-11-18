# Lab 10

## Lab 10 Outcomes

At the conclusion of this lab, you will be able to manage, edit, and list system processes in systemd--helping you to master the concepts of systemd.

1) Using the default GRUB settings in `/etc/default/grub`, change the setting, removing *splash quiet* on `GRUB_CMDLINE_LINUX_DEFAULT=""`. Save the changes the GRUB configuration file, and then run the OS appropriate grub update command (different for Ubuntu and Fedora). Reboot the virtual machine and explain what changed during the boot process.

1) Using the default GRUB settings in `/etc/default/grub`, change the setting, to say `GRUB_TIMEOUT_STYLE="menu"`, `GRUB_TIMEOUT=15`, and `GRUB_DEFAULT=0`. Save the changes the GRUB configuration file, and then run the OS appropriate grub update command (different for Ubuntu and Fedora). Reboot the virtual machine and explain what changed during the boot process.

1) Type the command to display your default `target` environment

1) For the `openssh-server` package on your distro type the 3 commands to enable the service to start at boot, start the service running, and check the service status

1) Install the Nginx webserver package. What is the location on the filesystem of the `.service` file?

1) Briefly explain the recommended purpose of `/etc/systemd/system` and `/lib/systemd/system`

1) Type the systemctl command to stop the Nginx service

1) Type the systemctl command that will retrieve and display the `ExecStart` property from the `nginx.service` file (not grep)

1) Type the systemctl command that will retrieve and display the `WantedBy` property from the `nginx.service` file (not grep)

1) Using the `man` command explain what `timedatectl` does?

1) Using the `man` command explain what `journalctl` does?

1) Using the `man` command explain what `resolvectl` does?

1) Using the `man` command explain what `networkctl` does?

1) Using the `man` command explain what `hostnamectl` does?

1) List the three headers or parts of a `.service` file?

1) Using the command `timedatectl status` use the `man` command to find hwo to change your system clock to `UTC`. Run the `timedatectl status` again and copy the output showing the difference

1) Use the `hostnamectl` command to modify and display the following:
   a) set-hostname on your SSH client to xyz-ssh-client (xyz is your initials)
   b) set-chassis to: vm
   c) set-deployment to: dev

1) Use one of the tools described in the **Filesystems /proc** section and print out the exact processor/cpu type your Linux system is reporting.

1) In the textbook sample code: `files > Chapter-10 > service-files` there is a `.service` file named `write-journal.service`. Issue the commands to enable and start this service. This will require you to beforehand install the pre-requisite packages and create the `write-journal.py` script: the code is in the section **Logging and Service Files**. Write a `.timer` unit file (remember to enable and start the timer unit file), which will execute your `write-journal.service` once every 5 minutes. Show logs from only the `write-journal.service` showing that 10 minutes approximately elapsed. Show the status of the systemctl timers to show the timer unit has been registered.
