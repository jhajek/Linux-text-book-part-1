# Package Managers and Package Installation
![Understanding the Technology and Philosophy of Unix/Linux](http://imgs.xkcd.com/comics/2038.png "Understanding the Technology and Philosophy of Unix/Linux")
Tar xkcd cartoon


__Chapter 10 Objectives__

  * Learn the features of dnf, yum, and apt to install packages and dependecies in Linux
  * Understand the nature of gcc and GNU tools make 
  * Undderstand how to use the Python lanuguage interpreter in order to run python based install scripts 
  * Understand how to use tar, gzip, and bzip2 for extracting packages containing source code
  * Compiling code from source
  * Using Python setup.py install tools
  
__Outcomes__

  At the conclusion of this chapter you will be able to install packages and manage dependecies through using standard package managers dnf, yum, and apt.  You will also be comfortable compiling software from source using a tar ball and python setup tools.

## Package Managers

  * yum 
  * dnf 
  * apt 

## Tar Balls and Compression Tools


### Extracting a Tar Ball


## Compling and Installing source code

C
### GNC GCC


### GNU Make


### Using Python to Install Python Based Programs



## Automating the Install Answer Process With Preseed and Kickstart  

  All the previous steps took maybe 10 to 15 minutes if you are on a fast machine; which is not bad at all.  But let us say you will be creating multiple virtual machines for research purposes. Or perhaps you will be recreating the same virtual machine many times.  There is a way to automate the install process.  This is called an *answer file* in the Windows world.  For Red Hat based systems this is called *kickstart* and Debian and Ubuntu use a file format called *preseed*.  None of these formats are compatible with each other but there has been some work to get limited kickstart support for Ubuntu.  
    
  [Debian/Ubuntu pressed template](https://help.ubuntu.com/lts/installation-guide/amd64/apb.html "Preseed")
  
  [Kickstart documentation](https://docs.fedoraproject.org/en-US/Fedora/18/html/Installation_Guide/s1-kickstart2-file.html) - it can be generated from scratch or upon a succesful install a default kickstart is located in /root/anaconda-ks.cfg
  
  
screen shot showing you need to host the file on the web somewhere or include the file in install media

 