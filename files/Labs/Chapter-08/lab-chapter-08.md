# Lab - Chapter 08

## Lab Objectives

* Explore creating shell scripts  
* Explore the use of positional parameters in shell scripts
* Describe the fundamental use of control structures in shell scripts
* Explore task automation using `cron` for shell scripts

## Lab Outcomes

At the completion of this lab you will further your knowledge of shell scripting and enhance your abilities using Bash shell scripts. Sample code and text files are available in the textbook GitHub repo under `files > Chapter-08 > lab`. You will be writing shell scripts and your deliverable will be the shell scripts that satisfy each files requirements. Copy `names.txt` and `roster.txt` so that they are in the same directories as your shell scripts -- assume path `./`

#### Part 1

1) Create a shell script in your `HOME directory > Documents`, named: `delete-chapter-05.sh` which will delete the output of Chapter-05 lab if present, otherwise print a message saying that "Chapter 05 lab content is not present"

1) Create a shell script in your `HOME directory > Documents` using the deliverables from the Chapter-05 lab. Take all of the commands from Chapter-05 Part-1 and combine them into a single shell script named: `chapter-05-lab.sh` and execute them

1) Create a shell script in your `HOME directory > Documents` using IF statements and primary expressions to *grade* your `chapter-05-lab.sh` script by checking for the precense of the proper directories and files being created and printing out log messages. Name the file: `grade-chapter-05-lab.sh`

## Part 2

1) Create a shell script that will take 3 positional parameters, append each parameter to a file named roster.txt (each of the parameters will be a name), named `l8ex1.sh`

1) Create a shell script to cat the content of the roster.txt file into an array named: ROSTERARRAY and echo the 2nd element of the array, named `l8ex2.sh`

1) Create a shell script that redirects the content of roster.txt into an array, uses a forloop to cycle through the array's contents, and then uses the command to make a directory for each name listed in the array in your home directory, echo a message telling the user the path of the directory just created. Final command of the script is to list the content of the home directory to show the success of the script, named `l8ex3.sh`

1) Modify the shell script from the previous question to include an `if` statement that checks for the existence of a directory. If the directory exists, echo a message: "Directory $NAME exists". Then add an else clause that if the directory does not exist, create it and echo a message that the new directory and its path have been created, named `l8ex4.sh`

1) Write a WHILE loop that will read the content of the file names.txt, (located in the files > Chapter-08 > lab folder) and create a directory based on the value on the line in the `/tmp` directory (one per users). Include an if statement to detect if the directory already exists, if it does exist, write the duplicate name out to a text file named: `duplicates.txt` located in the `/tmp` directory, named `l8ex5.sh`

1) Create a directory in ```~``` named ```topsecret```.  In that directory create a file named `xfile.txt`.  Write a shell script to check if that file has executable permission by passing the filename as a positional parameter.  If TRUE print a message.  If FALSE print an error message that the positional parameter name of the file is not executable, named `l8ex6.sh`
  
1) Write a shell script to check in the `~/topsecret` directory to see if a given file name exists (passed in by positional parameters).  If TRUE print a message else print an error message with the given file name being passed, named `l8ex7.sh`
    
1) Using `awk` and other tools, how would you find which ip caused the most HTTP 404 errors? Take a screenshot of the command and the output.  Use these two files in ```files/Chapter-08/logs```: u_ex150721.log, u_ex151002.log, named `l8ex8.sh`

1) Using `awk` and other tools, how would you capture the top 5 offending IPs? Use these two files in ```files/Chapter-08/logs```: u_ex150721.log, u_ex151002.log, write a shell script named `l8ex9.sh`

1) Using `sed`, write a shell script to find the line **bind-address** located in the mariadb database server config file (you might need to install mariadb-server). The file locations are: Fedora ```/etc/my.cnf.d/mariadb-server.cnf``` and Ubuntu ```/etc/mysql/mariadb.conf.d/50-server.cnf```. Comment out the value, change the IP value to 0.0.0.0, and write the change back to the original file, named `l8ex10.sh`

## Part 3

The goal of this shell script is to add IF statement logic to prevent errors in our code in case of duplicates in relation to account creations on a server. Create the shell script in your in your `HOME directory > Documents` and name it `l8ex12.sh`.

* Write a shell script using a while script to read in the content of roster.txt into a variable named $LINE
  * For each user check for the existance of a home directory
  * If the directory doesn't exists, use the this command to create a user account on your system
    * `sudo useradd -c "Account for $NAME" -s /bin/bash -d /home/$NAME -m $NAME`
    * Write a log message telling us which account was created, redirecting output for standard error and standard out and with a timestamp
      * Name the log `l8ex11-log.sh`
    * Add an `echo` to the screen telling which account has just been created
    * else skip the account creation 
  * Run the command to create a directory named `.ssh` owned by the user `$NAME` in their home directory
    * Use -O to check for file existance and ownership
  * Run the command to create an ssh key using an IF statement checking for the existance of the keys in the .ssh directory
      * `sudo ssh-keygen -t ed25519 -f /home/$NAME/.ssh/id_ed25519_$NAME -N ""`
      * Take note of the home directory and use the `chown` command to change the ownership of the keys in the .ssh directory to the user just created
      * Write a log message telling us that keys were created for a user, redirecting output for standard error and standard out and with a time stamp
        * Append to the log `l8ex11-log.sh`
      * Add an `echo` to the screen telling which keys have just been created
  * Name the script: `l8ex11.sh`