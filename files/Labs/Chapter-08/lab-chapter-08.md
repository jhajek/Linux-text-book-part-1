# Lab - Chapter 08

## Lab Objectives

* Explore creating shell scripts  
* Explore the use of positional parameters in shell scripts
* Describe the fundamental use of control structures in shell scripts
* Explore task automation using `cron` for shell scripts

## Lab Outcomes

At the completion of this lab you will further your knowledge of shell scripting and enhance your abilities using Bash shell scripts. Sample code and text files are available in the textbook GitHub repo under `files > Chapter-08 > lab`. 

You will be writing shell scripts and your deliverable will be the shell scripts that satisfy each files requirements. Copy `names.txt` and `roster.txt` so that they are in the same directories as your shell scripts -- assume path `./`

It is recommended to do these steps once first -- then on a different virtual machine repeat the steps and make the recording. It is not acceptable to present previously finished code. Our goal is to show your mastery of the concepts.

#### Part 1

1) Create a shell script in your `HOME directory > Documents`, named: `delete-chapter-05.sh` which will delete the output of Chapter-05 lab if present, otherwise print a message saying that "Chapter 05 lab content is not present." You will need to reverse all the steps used to create each step from Chapter-05--a single `rm -rf ~/Documents/chapter-05*` will not suffice. 

1) Create a shell script in your `HOME directory > Documents` using the deliverables from the Chapter-05 lab. Take all of the commands from Chapter-05 Part-1 and combine them into a single shell script named: `chapter-05-lab.sh` and execute them. Demonstrate creating and deleting multiple times the chapter-05 lab content.

1) Create a shell script in your `HOME directory > Documents` using IF statements and primary expressions to *grade* your `chapter-05-lab.sh` script by checking for the presence of the proper directories and files being created and printing out messages in each IF to a log stating if the test passed or did not pass. Name the file: `grade-chapter-05-lab.sh` and name the log file `grade-chapter-05.log`

#### Part 2

These are a series of small shell scripts you will create to demonstrate the concepts from chapter 3-8.

1) Create a shell script that will take 3 positional parameters, append each parameter to a file named roster.txt (each of the parameters will be a name), named `l8ex1.sh`

1) Create a shell script to cat the content of the roster.txt file into an array named: `ROSTERARRAY` and echo the 2nd element of the array, named `l8ex2.sh`

1) Create a shell script that redirects the content of roster.txt into an array, uses a for loop to cycle through the array's contents, and then uses the command to make a directory for each name listed in the array in your home directory, echo a message telling the user the path of the directory just created. Final command of the script is to list the content of the home directory to show the success of the script, named `l8ex3.sh`

1) Modify the shell script from the previous question to include an `if` statement that checks for the existence of a directory. If the directory exists, echo a message: "Directory $NAME exists". Then add an else clause that if the directory does not exist, create it and echo a message that the new directory and its path have been created, named `l8ex4.sh`

1) Write a WHILE loop that will read the content of the file names.txt, (located in the files > Chapter-08 > lab folder) and create a directory based on the value on the line in the `/tmp` directory (one per users). Include an if statement to detect if the directory already exists, if it does exist, write the duplicate name out to a text file named: `duplicates.txt` located in the `/tmp` directory, named `l8ex5.sh`

1) Create a directory in your home directory named: `topsecret`. In that directory create a file named `xfile.txt`. Write a shell script to check if that file has executable permission by passing the filename as a positional parameter. If TRUE print a message. If FALSE print an error message that the positional parameter name of the file is not executable, named `l8ex6.sh`
  
1) Write a shell script to check in your `topsecret` directory to see if a given file name exists (passed in by positional parameters). If TRUE print a message else print an error message with the given file name being passed, named `l8ex7.sh`
    
1) Using `sed`, write a shell script to find the line **bind-address** located in the mariadb database server config file (you might need to install mariadb-server). The file locations are: Fedora `/etc/my.cnf.d/mariadb-server.cnf` and Ubuntu `/etc/mysql/mariadb.conf.d/50-server.cnf`. There is a line with the IP address value of `127.0.0.1`, you need to replace that value with: `0.0.0.0` and write the change back to the original file, named `l8ex8.sh`.

#### Part 3

The goal of this shell script is to add IF statement logic to prevent errors in our code in case of duplicates in relation to account creations on a server. Create the shell script in your in your `HOME directory > Documents` and name it `l8ex9.sh`.

* Write a shell script using a while loop script to read in the content of `roster.txt` into a variable named `LINE`
  * For each user check for the existence of a home directory
  * If the directory doesn't exists, use the this command to create a user account on your system
    * `sudo useradd -c "Account for $LINE" -s /usr/bin/bash -d /home/$LINE -m $LINE`
    * Write a log message telling us which account was created, redirecting output for standard error and standard out and with a timestamp
      * Name the log `l8ex9.log`
    * Add an `echo` to the screen telling which account has just been created
    * else skip the account creation 
  * Run the command to create a directory named `.ssh` owned by the user `$LINE` in their home directory
    * Use -O to check for file existence and ownership
  * Run the command to create an ssh key using an IF statement checking for the existence of the keys in the .ssh directory
      * `sudo ssh-keygen -t ed25519 -f /home/$LINE/.ssh/id_ed25519_$LINE -N ""`
      * Take note of the home directory and use the `chown` command to change the ownership of the keys in the .ssh directory to the user just created
      * Write a log message telling us that keys were created for a user, redirecting output for standard error and standard out and with a time stamp
        * Append to the log `l8ex10.log`
      * Add an `echo` to the screen telling which keys have just been created
