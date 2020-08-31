# Lab - Chapter 05

The objectives of this lab is to use the shell commands we learned in this chapter and understand their proper usage and form. The outcome will your ability to successfully use the Linux Shell for navigation, file creation, and file modification. Resist the temptation to use the GUI file manager and a web browser.  All actions will be done through the shell unless noted.  All work can be done on either Ubuntu desktop or Fedora desktop unless noted.

1) From the commandline and in your home directory use your systems package manager (yum or apt) and install the `git` client.  
    1. issue the command ```git --version``` and take a screenshot of the output
1) Navigate to this location: `~/Documents`.  Issue the command ```git clone https://github.com/jhajek/Linux-text-book-part-1.git```  (If you have done this command previously, no need to redo it).
    1. Take a screenshot of the output of the ```ls``` command
1) Issue the ```cd``` command to change directory into Linux-text-book-part-1.  Issue the command to display what type of file ```./title/metadata.yaml``` is.  Issue that same command to display what type of file ```Appendix-A``` is.
    1. Take a screen shot of the output of the previous commands.
1) Use the ```wget``` command to retrieve a copy of the Packer.io binary for Linux.  Use this URL as the argument for ```wget```:[https://releases.hashicorp.com/packer/1.4.3/](https://releases.hashicorp.com/packer/1.4.3/ "Packer Download URL")
    1. Take a screenshot of the ```ls``` command after you have executed the previous command.
1) Use the ```unzip``` command to unzip the binary and extract the packer executable.  Issue the move command, `mv` to move the executable to this location: ```/usr/local/bin```.  **Hint:** you will need to use `sudo` to get the permission needed for this operation.
    1. To show this was successful take a screenshot of the output of the command ```packer -v```.
1) Use the ```wget``` command to retrieve an archived copy of the Hadoop binaries from the web.  You can use this address as an argument to your wget command: [https://www-us.apache.org/dist/hadoop/common/hadoop-2.9.2/hadoop-2.9.2.tar.gz](https://www-us.apache.org/dist/hadoop/common/hadoop-2.9.2/hadoop-2.9.2.tar.gz "Hadoop URL")
    1. Take a screenshot of the ```ls``` command after you have executed the previous command.
1) Use the ```tar -xvzf``` command to extract the files, we will cover ```tar``` in a later chapter.  ```tar``` is the command ```-xvzf``` is the options and you need to provide the argument of the ```hadoop*.tar.gz```
    1. Take a screenshot of the output of the ```ls``` command to show the extracted hadoop directory.  
1) Find the command that is used to rename a file or directory and rename the Hadoop directory to be just hadoop
    1. Take a screenshot of the output of the ```ls``` command.
1) What would be the command to delete the file hadoop*.zip?
    1. Issue the command ```ls```, then type the command to remove the .tar.gz file, the type the ```ls``` command again to show it has been remove.  Take a screenshot of the combined output of all 3 previous commands.
1) Using a Web Browser from your GUI, navigate to and open the file named ```chapter-05-file-path-exercise.html``` located under the directory ```./Linux-text-book-part-1-master/files/Chapter-05/images/```:  Note that the images on the web page are broken.   Take a look at the source code (view source) and move the **stallman.jpg**  to the proper directory to make the webpage render that image properly in a single command using the command line.  
    1. Take a screenshot of that single command and a screenshot of the web browser showing the **stallman.jpg** image properly rendering.
1) Using the commandline again, move the **ms-loves-linux.png** image to the proper directory using the ```mv``` command in a single command:
    1. Take a screenshot of that single command and a screenshot of the output of the web browser showing both the **stallman.jpg** and the **ms-loves-linux.png** images properly rendering.
1) Assume your PWD is your Home directory: In a series of commands, ```cd``` to Documents, then create a directory named ```packer-scripts```.  Under this directory create 5 sub-directories, ```ubuntu16-04```, ```ubuntu18-04```, ```fedora28```, ```centos7```, ```OmniOS```.  
    1. With your PWD as ```~/Documents/packer-scripts```, execute the command that will give a long listing of the contents of the directory.  Take a screenshot of this command as well as the output.
1) the the `git` command and clone your own repository to your Linux system.  In the folder created for this class, issue the commands to create directories for each chapter of the book starting from 01 and upto 15.  For example: **chapter-01, chapter02**.  Then issue the command to create a file named `Readme.md` in each directory (**Note:** if you already have a folder for a particular chapter and a Readme.md created for previous assignments then you can skip created that entry).
1) Using the `man ssh` command, find the command line option that will display verbose version information about ssh.  
    1. take a screenshot of the `ssh` command and option displaying verbose version information.
1) Use the man command for the `cp` command to find how to do a recursive, verbose, and interactive `cp` command.
    1. Issue the stated command above to copy the directory `~/Documents/Linux-text-book-part-1/Appendix-D/` to `~/Documents/` and take a screenshot of the command and output.
1) Use the command to rename the folder `~/Documents/Appendix-D` to `~/Documents/Appendix-E`.
    1. Take a screenshot of the command and its output
