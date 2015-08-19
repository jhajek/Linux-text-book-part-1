# Linux basic commands and File system structure
![Understanding the Technology and Philosophy of Unix/Linux](http://imgs.xkcd.com/comics/2038.png "Understanding the Technology and Philosophy of Unix/Linux")

  The main use and power of an operating system to this day is still the Shell.  The shell is a way for a user to directly interface with the operating system.    We will cover more about specific shells and features in Chapter 8.  

__Chapter 5 Objectives__

  *  Understand the function of the Linux Shell and its relation to the Operating System.
  *  Learn how to read the structure of commands on the commandline
  *  Learn the Linux commandline nomenclature
  *  Understand the Linux Standard Base and what makes a distro a Linux distro
  *  Understand the difference between absolute and relative paths
  *  Know basic tools for moving and modifying the contents of the filesystem.

__Outcomes__

  At the completion of this chapter you will understand how to use the Linux shell for modifying the contents of the operating system.  You will understand the nature of the filesystem and how to navigate it--understadning the system path.  You will know basic commands for manipulating content in the filesystem.

## Shell

  Show picture of seashells
  
  (insert diagram about shell OS interaction)

Many may say, *"Hey I have a nice point and click GUI why do I need to use the crusty old commandline?"*  That is a valid question.  In reality the GUI is syntactic sugar on top of the Shell. Anything you click on in a GUI in reality is executing a command in the shell.  In certain cases using the shell may have more avaialble features for your command then in the GUI.  The GUI by definition cannot have more capability than the shell.  

In the shell is where we can enter basic commands for navigation and file manipulation.  Some of the basic commands we will cover are as follows:

*  ```cd - used to change directory```
*  ```ls - used to list the content of a directory```
*  ```cp - used to cp the contents of a file, can also be used to copy and rename a file```
*  ```mv - used to rename a file in place```
*  ```mkdir - used to create or make a new directory``` 
*  ```touch - used to create a new blank file or to update the timestamp of an existing file without opening it```
*  ```cat - technically used to concatenate the contents of two files, but will accept nothing as the second paramter thereby just being used to display the content of a file```
*  ```less - used for paging the contents of a large file, also supports scrolling up as well as down```
*  ```date - used for outputting the current date and time in various customizable formats```
*  ```man - the manual command used to find out how to use the detailed structure of a command```
*  ```pwd - used to print out your present working directory--your location in the filesystem tree.```
*  ```file - used to find out what the content type a file is``` 

## Basic Commands

(show screen shot of ls command with ls ls -la ls -la /etc/  man ls

  There is a common nomenclature of commands in Linux.  There is an executable that is part of the system function located in /bin, files such as ls cd touch are all precompiled binaries located on the system.  To enter a command you type the name of the binary, as you use Linux more and more you will begin to memorize the tool names.  Each command can have options or sometimes called flags and then may or may not accept arguments.
  

### - Command nomencvlature
  
  ```ls -la /etc```
  
  The first two letters __```ls```__ make up the command for listing the contents of a directory.  The command must be followed by a space. Then next letters are preceeded by a __dash__, to tell the shell interpreter that these letters are options.  Options are usually single letter representations of functionality.  The __```-l```__ options tells the ls command to give a long listing of a directory with details and the __"-a"__ tells the shell to print all files in the directory including hidden files.  Options can be combined in most cases into a single string preceeded bya dash.  So __```-la```__ can also be writted as __```-l -a```__.  Additonally there are options that use full english lanugage structure, which are usually preceeded by __two dashes__ and then a more descriptive english phrase.  Ask the students to find one?
   
  The final value of __/etc__ in the command  ```ls -la /etc``` is an argument passed to the ```ls``` command telling the ls command to list the contents of the ___/etc__ directory.  If this value is left empty the shell assumes you mean the ```pwd``` or your current location/.

### - Manual (man) command - your best friend

 __Purpose of manual command__
 
 __history of maunal command

        
### - File System structure
   
__What is a Filesystem?__ 
  
   A way for the Opertaing system to access and manage files     
   Upside down tree
   Top of the tree / (root)
  
  Add what each of these locations holds - have the students cd into these directories and do ls and file commands
   
   * /etc
   * /bin
   * /sbin
   * /tmp
   * /var
   * /usr
   * /mnt
  
  talk about Red Hat  Explain the sym-linking of /usr/sbin and /usr/bin
   
   optional non-standard 
   /opt from Unix
   /media Ubuntu and Red Hat - an obvious place to put mounted USB, CD-ROm and other added devices
   
### - POSIX and Linux Standard Base
   
__POSIX__

Need for POSIX standard and what it does, and almost sacredness of Linux supporting POSIX standards

Quote from Poettering about dropping the fantasy UNIX and breaking POSIX to enhance Linux capabilities.

__LSB__

Similar to POSIX but additionally unique to Linux in defining what a distro needs to be officially called a Linux distro.  

## Explanation of PATH

     * Absolute vs Relative
     * Go over these concepts with above simple commands

## - 3 P's

  Path 
  Permission 
  dePendencies

## - Chapter Conclusions and Review

  Conclusion goes here

### - Review Questions

  * Questions go here

### - Podcast Questions

 * Questions go here

### - Lab

 * Lab goes here 
   