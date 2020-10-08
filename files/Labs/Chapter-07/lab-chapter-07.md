# Lab - Chapter 07

## Lab Objectives

The objective of this lab is to master vi commands and shell scripts

## Lab Outcomes

At the end you will have mastered the basics of vi and now be proficient in all the tools of Linux shell scripting

## Prerequisites

You will need to install the program ```vimtutor``` for the first part.   You can do that on Ubuntu by typing ```sudo apt-get install vim vim-runtime vim-gtk``` and on Fedora by typing ```sudo dnf install vim vim-enhanced```. There is a good text explanation of each of the vim tutor exercises: [https://www.systutorials.com/vim-tutorial-beginners-vimtutor/](https://www.systutorials.com/vim-tutorial-beginners-vimtutor/ "vimtutor exercises")

1) To begin type the command ```vimtutor``` from the commandline. __Warning:__ ```vimtutor``` requires you to read the instructions carefully.
    i) This is a 6 part tutorial.  You need to follow all the steps of the 6 part tutorial making your changes directly in the file.
    i) __Be careful__ to save the file to an external location – otherwise IT WILL BE OVERWRITTEN each time you launch the vimtutor command. You can do this by typing ```:w  ~/Documents/vimtutor.txt``` - this way you can edit the file on your local system instead of launching the vimtutor application again.  Note you need to use ```vim``` for this assignment.
1) Inside of the ```files/Chapter-07/lab``` folder using ```vim``` open ```install-java-8-openjdk.sh```.  You will be using vim to modify this file
    i)  Use the ex command to find all occurrences of ```;``` and replace them with ```&&```.
    i)  Using vim commands replace all occurrences of the numbers ```2.6.5``` with ```2.8.5```.
    i)  Using vim to append the packages ```python``` and ```python-dev``` to line 18.  
    i)  In the shell script,  ```install-java-8-openjdk.sh```,  using `vim`, insert a comment above each line explaining what the command is doing.
1) In vim using create a shell script named ```created-shell-script.sh``` to run in Ubuntu with the following requirements, you will need to reference chapter 03-07 as well: (resist writing it in notepad)
    i) Create a script with the proper shebang on the first line.
    i) Type the command to update package repositories.
    i) type the command to install the ```java 8 openjdk``` and the ```software-properties-common``` package with the flag to auto accept 'Yes' to any question.
    i) Type and chain the commands to use ```wget``` and retrieve this tarball: [http://archive.apache.org/dist/hadoop/common/hadoop-2.8.5/hadoop-2.8.5.tar.gz](http://archive.apache.org/dist/hadoop/common/hadoop-2.8.5/hadoop-2.8.5.tar.gz "hadop 2.8.5 tarball") then extract it--in one line.
    i) Type the command to install these packages with the auto accept flag turned on: ```pkgconf wget liblzo2-dev sysstat iotop vim libssl-dev libsnappy-dev libsnappy-java libbz2-dev libgcrypt11-dev zlib1g-dev lzop htop fail2ban```
    i) Type the command to upgrade the Ubuntu distribution and redirect the standard output to `/tmp/distupgrade.out`
    i) Create a shell variable named RESULT, set the result of the command ```sudo find / -name tools.jar``` to this value and run the command to display the content of the ```$RESULT``` variable to the screen.
    i) Add these lines to the END of your shell script:

```bash
cat << EOT >> ~/.bashrc

########## Inserted by User ##########
export JAVA_HOME=/usr
export HADOOP_HOME=$HOME/hadoop-2.8.5
export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin
export HADOOP_CLASSPATH=/usr/lib/jvm/java-8-openjdk-amd64/lib/tools.jar
EOT
```

Source the ```.bashrc``` file with the command ```. ~/.bashrc```, execute the command ```hadoop version``` if version information outputs successfully then you have succeeded.

__Deliverable:__  

Submit your GitHub URL for your repo to Blackboard.

1) Push the file ```install-java-8-openjdk.sh``` in your chapter-07 folder > itmo-556 GitHub repo.  
1) Push the file ```vimtutor.txt``` to your chapter-07 folder > itmo-556 GitHub repo.  
1) Push the file ```created-shell-script.sh``` to your chapter-07 folder > itmo-556 GitHub repo.  
