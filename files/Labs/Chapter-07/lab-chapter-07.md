# Lab Chapter 7

## Objectives

* The objective of this lab is to master vi commands and shell scripts

## Outcomes

At the end you will have mastered the basics of vi and now be proficient in the tools of Linux shell scripting

### Prerequisites

* You will need to make sure the `vim` program is installed
* You will need to clone/pull the Textbook source code to the home directory in your virtual machine
* You will need to install the program `vimtutor`
  * On Ubuntu by typing `sudo apt install vim vim-runtime vim-gtk`
  * On Fedora by typing `sudo dnf install vim vim-enhanced`
  * There is a good text explanation of each of the vim tutor exercises: [https://www.systutorials.com/vim-tutorial-beginners-vimtutor/](https://www.systutorials.com/vim-tutorial-beginners-vimtutor/ "vimtutor exercises")

### Part 1

1) Using Ubuntu or Fedora Desktop, type the command ```vimtutor``` from the terminal: __Warning!__ `vimtutor` requires you to read the instructions carefully!
    1. This is a 6 part tutorial. You need to follow all the steps of the 6 part tutorial making your changes directly in the file.
    1. __Be careful__ to save the file to an external location – otherwise IT WILL BE OVERWRITTEN each time you launch the vimtutor command. You can do this by typing `:w  ~/Documents/vimtutor.txt` - this way you can edit the file on your local system instead of launching the `vimtutor` application again. Note you need to use `vim` for this assignment.
    1. Save the finished output of `vimtutor.txt` in `vim` using the `:w` command
    1. Show the output of the elements you changed

### Part 2

1. Using Ubuntu or Fedora Desktop, from the textbook source code folder: `files/Chapter-07/lab`, copy the file `install-software.sh` to your home directory
    1. Using vim/ex commands, find all occurrences of `python` and replace them with `python3`
    1. Save file and quit the vim editor
    1. To test your work, give the shell script execute permission and execute it by using `sudo ./install-software.sh`
    1. Demonstrate the code change you made and the output it generated 

### Part 3

1. Using Ubuntu Server for all of Part 3, in your home directory, using `vim`, create a shell script named `first-shell.sh` that contains the following:
    1. Add the proper `shebang` on the first line
    1. Add two lines of space
    1. Store the output of the command `date` into the shell variable named **DT**
    1. Add the command that will print out the text: "#############"
    1. Add the command that will print out the text: "Script execution began at: $DT"
    1. Add the command that will print out the text: "#############"
    1. Save the file and quit the vim editor
    1. Execute the command to give `first-shell.sh` execute permission
    1. Demonstrate the output executing `first-shell.sh`
    1. Demonstrate the command used to print the content of the file: `first-shell.sh`
1. Using Ubuntu server and with vim:
    1. Create a shell script named **install-textbook-dependencies.sh** in your home directory. You will need to add commands to do the following:
    1. Add the proper *shebang* on the first line, then two lines of space
    1. Issue the command to retrieve the `.deb` package from the commandline based on your CPU architecture:  
    `https://github.com/jgm/pandoc/releases/download/3.1.3/pandoc-3.1.3-1-amd64.deb`
    or
    `https://github.com/jgm/pandoc/releases/download/3.1.3/pandoc-3.1.3-1-arm64.deb`
    1. Issue the command to install this `.deb` package (Chapter 3.8.1.2 DEB package install)
    1. Issue the command to update the `apt` repos
    1. Issue the command to install these dependencies using the `-y` flag: ```texlive texlive-latex-recommended texlive-latex-extra texlive-fonts-recommended texlive-fonts-extra texlive-xetex texlive-font-utils librsvg2-bin texlive-science texlive-science-doc```
    1. Test your shell script by giving it execute permissions and use sudo to run it (required for permission to install packages)
1. Using Ubuntu server compile your version of the textbook
    1. Edit Line 8 of `chapter-01.md` from the textbook source code to now say: `# New Introduction by YOURNAME` 
    1. To test the results, `cd` into the Linux-Text-Book-Part-1 directory  
    1. Execute the script named: `build-linux-and-macos.sh` to build the textbook using the dependencies you installed
    1. In the `output/txt` directory run a command to display the first 20 lines of the generated file: `Understanding-Free-and-Opensource-Operating-Systems-Part-I.txt`
    1. Demonstrate the output of building the textbook

### Part 4

1. Using Ubuntu Desktop in your home directory, retype the script you created in Part 3.1, `first-shell.sh`, and using the command to move a file, move that script to `/usr/local/bin`. Note that `/usr/local/bin` is owned by root, and an extra command will be needed to successfully move your shell script. Execute the command: by typing just `first-shell.sh`, without any slashes or sudo commands and take a screenshot of the output
    1. Demonstrate the output 
1. Using an OS of your choice, inside the Textbook sample code: `files > Chapter-07 > logs > host2.deny` write a script that will cut the second column, sort the values numerically and redirect the modified output to a file named: `sorted-ips.txt`.  Execute this script.
    1. Demonstrate the output of the command
