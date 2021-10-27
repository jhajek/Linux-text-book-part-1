# Lab - Chapter 07

## Objectives

The objective of this lab is to master vi commands and shell scripts

## Outcomes

At the end you will have mastered the basics of vi and now be proficient in the tools of Linux shell scripting

## Prerequisites

* You will need an additional virtual machine with Ubuntu Server 20.04 installed for this entire lab
* You will need to make sure the `vim` program is installed
* You will need to make sure the the `nano` program is installed
* You will need to clone the Textbook source code to the Ubuntu Server virtual machine in the home directory
* You will need to install the program ```vimtutor```
  * On Ubuntu by typing ```sudo apt-get install vim vim-runtime vim-gtk```
  * On Fedora by typing ```sudo dnf install vim vim-enhanced```
  * There is a good text explanation of each of the vim tutor exercises: [https://www.systutorials.com/vim-tutorial-beginners-vimtutor/](https://www.systutorials.com/vim-tutorial-beginners-vimtutor/ "vimtutor exercises")

1) Using Ubuntu Server, type the command ```vimtutor``` from the terminal. __Warning:__ ```vimtutor``` requires you to read the instructions carefully!
    i) This is a 6 part tutorial.  You need to follow all the steps of the 6 part tutorial making your changes directly in the file.
    i) __Be careful__ to save the file to an external location – otherwise IT WILL BE OVERWRITTEN each time you launch the vimtutor command. You can do this by typing ```:w  ~/Documents/vimtutor.txt``` - this way you can edit the file on your local system instead of launching the vimtutor application again.  Note you need to use ```vim``` for this assignment.
    i) Take a screenshot as you complete each sub-section (i.e. 2.1 2.2 3.1 4.1 )
1) From the textbook source code folder: ```files/Chapter-07/lab```, copy the file ```install-java-8-openjdk.sh``` to your home directory
    i)  Using vim/ex commands, find **all** occurrences of ```;``` and replace them with ```&&```
    i)  Using vim/ex commands, replace **all** occurrences of the numbers ```2.6.5``` with ```2.8.5```
    i)  Use the vim/ex command to move directly to line 18
    i)  Using vim/ex commands to append the package names ```python``` and ```python-dev``` to line 18
    i)  Save file and quit the vim editor
    i)  Take a screenshot of the command used to display the entire content of the file
1) From the textbook source code folder: ```files/Chapter-07/lab```, copy the file ```install-software.sh```to your home directory
    i) Using vim/ex commands, find all occurrences of ```python``` and replace them with ```python3```
    i) Save file and quit the vim editor
    i)  To test your work, give the shell script execute permission and execute it
1) In your home directory, using vim, create a shell script named ```first-shell.sh``` in your home directory that contains the following:
    i) Add the proper *shebang* on the first line.
    i) Add two lines of space
    i) Store the output of the command ```date``` into the shell variable named **DT**
    i) Add the command that will print out the text: "###################################"
    i) Add the command that will print out the text: "Shell successfully execute at: $DT"
    i) Add the command that will print out the text: "###################################"
    i) Save the file and quit the vim editor
    i) Execute the command to give first-shell.sh execute permission
    i) Take a screenshot of the output executing first-shell.sh
    i) Take a screenshot of the command used to print the content of the file: first-shell.sh
1) From the textbook source code folder: ```files/Chapter-07/lab```, copy the file ```install-software.sh```to your home directory
    i) Open the file install-software.sh in GNU Nano
    i) On line 5 replace my name with yours - take a before and after screenshot
    i) Save the file and quit Nano, then execute the command to show only the **first** 10 lines of the file install-software.sh
1) Using wither vim or Nano:
    i) Create a shell script named **install-textbook-dependencies.sh** in your home directory.
    i) Add the proper *shebang* on the first line, then two lines of space
    i) Type the lines at the end of this assignment into your shell script
    i) Save the file and exit from your editor
    i) Give the script execute permission and execute it
    i) To test the results, `cd` into the Linux-Text-Book-Part-1 directory (clone it if you have not) and execute the the script: `./build-linux-and-macos.sh`  (the script already have execute permission)
    i) To test if the textbook built correctly - cd into the directory: **output/pdf**.  Issue the `ls` command and you will see two PDf files.

```bash

wget https://github.com/jgm/pandoc/releases/download/2.15/pandoc-2.15-1-amd64.deb
sudo dpkg -i pandoc-2.15-1-amd64.deb

sudo apt-get install -y texlive texlive-latex-recommended texlive-latex-extra \ 
texlive-fonts-recommended texlive-fonts-extra texlive-xetex texlive-font-utils \ 
librsvg2-bin texlive-science-doc texlive-science

wget http://packages.sil.org/sil.gpg
sudo apt-key add sil.gpg
sudo apt-add-repository -y "deb http://packages.sil.org/ubuntu/ $(lsb_release -sc) main"
sudo apt-get update
sudo apt-get -y install fonts-sil-charis

sudo apt-get -y install fonts-inconsolata
sudo fc-cache -fv

```

__Deliverable:__  

Submit your GitHub URL for your repo to Blackboard.