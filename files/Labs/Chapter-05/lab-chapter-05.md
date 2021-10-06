# Lab - Chapter 05

The objectives of this lab are to use the shell commands we learned in this chapter and understand their proper usage and form. The outcome will help your ability to successfully use the Linux Shell for navigation, file creation, and file modification. Resist the temptation to use the GUI file manager and a web browser.  All actions will be done through the shell unless noted.  

**Note:** All work should be done on either Ubuntu desktop or Fedora desktop unless noted and using the Terminal.

The following commands are intentionally out of order as you will be issuing commands to fix the order.

1) Opening a terminal, `cd` to the **Documents** directory. Issue the `pwd` command to find your present working directory (or current location)
1) Still in the **Documents** directory, use the `mkdir` command to create a directory named: **itmo356**
1) `cd` into the itmo356 directory.  Issue the command to show your present working directory. Create the below hieracrchy of sub-directories.  Once created take a screen shot of the output of the `ls` command in the distros directory
1) distros > BSD
1) distros > Debian (yes this spelling should be capital)
1) distros > redhat
1) Inside of each of the three directories just created we will need to create some text files.  Take a screenshot of the `ls` listing the contents of each directory showing how to create the files and listing them in the directory.
1) In the directory BSD use the command to create a file: Create three files names: oracle-linux.txt openbsd.txt netbsd.txt
1) In the directory Debian use the command to create a file: Create three three names: ubuntu.txt freebsd.txt devuan.txt
1) In the directory redhat use the command to create a file: Create three files names: fedora.txt rhel.txt debian.txt
1) At the same level as distro distros level -> omnios.txt
1) In the text files created you will notice that a few of them are out of place, such as a debian.txt is in the redhat folder.  Issue the command to move the text files to the correct locations and show a directory listing before and after the move command.  (*Hint*: ls mv ls)
1) Use the `mv` command to rename the Debian directory to have a lowercase "D"
1) Use the `rm` command to delete oracle-linux.txt file
1) Use the `mkdir` command to create a directory at the distros level named: **illumos** and move the omnios.txt file into **illumos**
1) `cd` to the distros BSD directory - what would be the command using a relative path to change your pwd to redhat?
1) From the redhat directory - what would be the command using the relative path to change your pwd to your home directory?
1) From your home directory - what would be the command using the relative path to change your pwd to the debian directory created earlier?
1) From the debian directory - what would be the command using an absolute path to change your pwd to /etc/ssh/ssh_config?
1) Use the `man` command to figure out how to display the format of the `date` command as month, day, year combined to look like: 10152021
1) Using the file: `/var/log/syslog`:  Type the command to display the last 10 lines of this file
1) Using the file: `/var/log/syslog`:  Type the command to display the first 10 lines of this file
1) Using the file: `/var/log/syslog`:  Using the `man` command on the previous question, find how to display the last 25 lines of this file
1) Using the file: `/var/log/syslog`:  Type the command to display the enitre contents of this file backwards (last line to first)
1) Using the file: `/var/log/syslog`:  Use one of the commands to allow for paging through one of these commands (hit 'q' to quit the paging command)
1) Clone the textbook source code into your virtual machine.  `cd` into Documents and issue the command: `git clone https://github.com/jhajek/Linux-text-book-part-1.git`.  (*Hint:* You may have to use your distro package manager to install the `git` tool)
1) Issue the `cd` command to change directory into Linux-text-book-part-1.  Issue the command to display what type of file `./title/metadata.yaml` is.  
1) Issue that same command to display what type of file `Appendix-A` is.
1) Using in the book source code, under files > chapter-05 > sample-script: copy the file sample-command to your home directory. Use the command to the give the script execute permission `+x`.  Issue the `ls -l sample-script/sample-command` command to show the permissions of just the `sample-command` file 
1) Move the file `sample-command` to the location `/usr/local/bin` (**Note:** you will need to add the `sudo` command in front to give yourself root privileges to move a file to this location)
1) Then from the command line (any location) execute the command: `sample-command`, and if successful you will receive a message of success
1) Execute the `ssh-keygen` command on the command line (from any location) and accept all the default values (just hit enter for now, we will cover RSA in depth later in the text).  This command generates two files that are part of an RSA keypair, located in `~/.ssh`
1) `cd` into that directory and type the command to show the long listing of the directory
1) From the textbook sample code > Files > Chapter-05 > sample-scripts > copy the file `date-time-script.sh` to your home directory.  `cd` to your home directory and execute the shell script you just copied (which will print out the current datetime) with the command: `./date-time-script.sh`.  You get an error message stating **permission is denied**: Explain why?
1) Type the command to enable your user to be able to execute this command and capture the results
1) From the textbook sample code > Files > Chapter-05 > sample-textfiles > distro-list.txt : issue the command to display the content of the distro-list.txt to the screen
1) Issue the command using a relative path to copy the file distro-list.txt to distros directory you made under the itmo356 folder
1) Issue the command to show the listing of the distros directory content and showing that the file was copied
1) Use the `wget` command to retrieve a copy of the Packer.io binary for Linux.  Use this URL as the argument for `wget` [https://releases.hashicorp.com/packer/1.7.6/packer_1.7.6_linux_amd64.zip](https://releases.hashicorp.com/packer/1.7.6/packer_1.7.6_linux_amd64.zip "Packer Download URL")
1) Use the `unzip` command to unzip the binary and extract the packer executable.  Issue the move command, `mv` to move the executable to this location: `/usr/local/bin`.  **Hint:** you will need to use `sudo` to get the permission needed for this operation and you may need to install the `unzip` application using your package manager. To show this was successful take a screenshot of the output of the command `packer -v`.
