# Midterm Project

## Objectives

* Explore creating shell scripts  
* Explore the use of positional parameters in shell scripts
* Describe the fundamental use of control structures in shell scripts

## Outcomes

At the completion of this lab you will further your knowledge of shell scripting and enhance your abilities using Bash shell scripts. Sample code and text files are available in the textbook GitHub repo under `files > Chapter-08 > lab`. You will be writing shell scripts and your deliverable will be the shell scripts that satisfy each files requirements. Copy `names.txt` and `roster.txt` so that they are in the same directories as your shell scripts -- assume path `./`.

## Part 1

1) Create a shell script in your `HOME directory > Documents`, named: `delete-chapter-05.sh` which will delete the output of Chapter-05 lab if present, otherwise print a message saying that "Chapter 05 lab content is not present"

1) Create a shell script in your `HOME directory > Documents` using the deliverables from the Chapter-05 lab. Take all of the commands from Chapter-05 Part-1 and combine them into a single shell script named: `chapter-05-lab.sh` and execute them

1) Create a shell script in your `HOME directory > Documents` using IF statements and primary expressions to *grade* your `chapter-05-lab.sh` script by checking for the presence of the proper directories and files being created and printing out log messages. Name the file: `grade-chapter-05-lab.sh`

## Part 2

The goal of this shell script is to add IF statement logic to prevent errors in our code in case of duplicates in relation to account creations on a server. Create the shell script in your in your `HOME directory > Documents` and name it `midterm.sh`.

* Write a shell script using a while script to read in the content of roster.txt into a variable named $LINE
  * For each user check for the existence of a home directory
  * If the directory doesn't exists, use the this command to create a user account on your system
    * `sudo useradd -c "Account for $NAME" -s /bin/bash -d /home/$NAME -m $NAME`
    * Write a log message telling us which account was created, redirecting output for standard error and standard out and with a timestamp
      * Name the log `midterm-useradd-log.sh`
    * Add an `echo` to the screen telling which account has just been created
    * else skip the account creation 
  * Run the command to create a directory named `.ssh` owned by the user `$NAME` in their home directory
    * Use -O to check for file existence and ownership
  * Run the command to create an ssh key using an IF statement checking for the existence of the keys in the .ssh directory
      * `sudo ssh-keygen -t ed25519 -f /home/$NAME/.ssh/id_ed25519_$NAME -N ""`
      * Take note of the home directory and use the `chown` command to change the ownership of the keys in the .ssh directory to the user just created
      * Write a log message telling us that keys were created for a user, redirecting output for standard error and standard out and with a time stamp
        * Append to the log `midterm-keygen-log.sh`
      * Add an `echo` to the screen telling which keys have just been created
  * Name the script: `l8ex11.sh`