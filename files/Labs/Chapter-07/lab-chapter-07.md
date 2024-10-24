# Lab Chapter-07

## Objectives

The objective of this lab is to master vi commands and shell scripts

## Outcomes

At the end you will have mastered the basics of vi and now be proficient in the tools of Linux shell scripting

### Prerequisites

* You will need to make sure the `vim` program is installed
* You will need to clone/pull the Textbook source code to the home directory in your virtual machine
* You will need to install the program ```vimtutor```
  * On Ubuntu by typing ```sudo apt-get install vim vim-runtime vim-gtk```
  * On Fedora by typing ```sudo dnf install vim vim-enhanced```
  * There is a good text explanation of each of the vim tutor exercises: [https://www.systutorials.com/vim-tutorial-beginners-vimtutor/](https://www.systutorials.com/vim-tutorial-beginners-vimtutor/ "vimtutor exercises")

#### Part 1

1) Using Ubuntu or Fedora Desktop, type the command ```vimtutor``` from the terminal: __Warning!__ `vimtutor` requires you to read the instructions carefully!
    i) This is a 6 part tutorial. You need to follow all the steps of the 6 part tutorial making your changes directly in the file.
    i) __Be careful__ to save the file to an external location – otherwise IT WILL BE OVERWRITTEN each time you launch the vimtutor command. You can do this by typing `:w  ~/Documents/vimtutor.txt` - this way you can edit the file on your local system instead of launching the vimtutor application again. Note you need to use `vim` for this assignment.
    i) Save the finished output of `vimtutor.txt` in `vim` using the `:w` command
    i) Show the output of the elements you changed

#### Part 2

1) From the textbook source code folder: `files/Chapter-07/lab`, copy the file `install-software.sh` to your home directory
    i) Using vim/ex commands, find all occurrences of `python` and replace them with `python3`
    i) Save file and quit the vim editor
    i) To test your work, give the shell script execute permission and execute it by using `sudo ./install-software.sh`
    i) Demonstrate the code change you made and the output it generated 

#### Part 3

1) Using Ubuntu Server, in your home directory, using vim, create a shell script named `first-shell.sh` in your home directory that contains the following:
    i) Add the proper `shebang` on the first line.
    i) Add two lines of space
    i) Store the output of the command `date` into the shell variable named **DT**
    i) Add the command that will print out the text: "#############"
    i) Add the command that will print out the text: "Script execution began at: $DT"
    i) Add the command that will print out the text: "#############"
    i) Save the file and quit the vim editor
    i) Execute the command to give `first-shell.sh` execute permission
    i) Demonstrate the output executing `first-shell.sh`
    i) Demonstrate the command used to print the content of the file: `first-shell.sh`
1) Using vim:
    i) Create a shell script named **install-textbook-dependencies.sh** in your home directory. You will need to add commands to do the following:
    i) Add the proper *shebang* on the first line, then two lines of space
    i) Issue the command to retrieve the `.deb` package: `https://github.com/jgm/pandoc/releases/download/3.1.3/pandoc-3.1.3-1-amd64.deb`
    i) Write the command to install this `.deb` package
    i) Write the command to update the `apt` repos
    i) Write the command to install these dependencies using the `-y` flag: `texlive texlive-latex-recommended texlive-latex-extra texlive-fonts-recommended texlive-fonts-extra texlive-xetex texlive-font-utils librsvg2-bin  texlive-science-doc texlive-science`
    i) Test your shell script by giving it execute permissions and use sudo to run it (required for permission to install packages)
1) Compile your version of the textbook
    i) Edit Line 8 of `chapter-01.md` from the textbook source code to now say: `# New Introduction by YOURNAME` 
    i) To test the results, `cd` into the Linux-Text-Book-Part-1 directory  
    i) Execute the script named: `build-linux-and-macos.sh` to build the textbook using the dependencies you installed
    i) In the `output/txt` directory run a command to display the first 20 lines of the generated file: `Understanding-Free-and-Opensource-Operating-Systems-Part-I.txt`
    i) Demonstrate the output of building the textbook

#### Part 4

1) Using the `mv` command, move your shell-script: `first-shell.sh` to `/home/vagrant/.local/bin` (replace `vagrant` with your system username).  Execute the command: by typing just `first-shell.sh`, without any slashes or sudo commands and take a screenshot of the output
    i) Demonstrate the output 
1) In Ubuntu Server, inside the Textbook sample code: `files > Chapter-07 > logs > u_ex151002.log` write a `grep` command to find each line that has `.php` in it
    i) Demonstrate the output of the command

#### Deliverable  

Take small movies of you demonstrating the required commands with your voice explaining the details.
