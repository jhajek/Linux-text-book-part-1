# Appendix A

![*How standards are made...*](images/Chapter-Header/Appendix-A/standards.png "Git Commit")

## Desktop Screenshots

The next few pages show a series of desktop screenshots covered in Chapter 4

* Mate Linux Desktop
* Pop!_os Desktop
* Cinnamon Desktop
* Budgie Desktop
* XFCE
* LXQT

### Mate Desktop

![*Ubuntu Mate*](images/Appendix-A/Ubuntu-mate-desktop.png "Ubuntu Mate Desktop")

\newpage

### Cinnamon Desktop

![*Ubuntu Cinnamon*](images/Appendix-A/Ubuntu-cinnamon-desktop.png "Ubuntu Cinnamon Desktop")

\newpage 

### Pop!_os Desktop

![*Pop!_OS Gnome Desktop*](images/Appendix-A/popos-desktop.png "Pop!_OS Gnome Desktop")

\newpage

### Pop!_os Cosmic Desktop

![*Pop!_OS Cosmic Desktop*](images/Appendix-A/popos-cosmic-desktop.png "Pop!_OS Cosmic Desktop")

\newpage

### Budgie Desktop

![*Fedora Budgie Desktop*](images/Appendix-A/Fedora-budgie-desktop.png "Fedora Budgie Desktop")

\newpage

### XFCE Desktop

![*Ubuntu XFCE Desktop*](images/Appendix-A/ubuntu-xfce-desktop.png "Ubuntu XFCE Desktop")

\newpage

### LXQT Desktop

![*Ubuntu LXQT Desktop*](images/Appendix-A/ubuntu-lxqt-desktop.png "Ubuntu lxqt Desktop")

## POSIX Standard

The best place I found a short (trust me this is short) summary of what POSIX is and does was from an answer on StackOverflow, I encourage you to read the entire post and see if you can tell me what POSIX is in 3 sentences. From the discussion I highlighted this one answer that does the best. [http://stackoverflow.com/questions/1780599/i-never-really-understood-what-is-posix](http://stackoverflow.com/questions/1780599/i-never-really-understood-what-is-posix "Attribution")[^48].

### Most important things POSIX 7 defines

1) [C API](http://pubs.opengroup.org/onlinepubs/9699919799/functions/contents.html "C API")

* Extends ANSI C with things like: networking, process and thread management, file IO, regular expressions, ...
  * E.g.: write, open, read, ...
* Those APIs also determine underlying system concepts on which they depend.
* Many Linux system calls exist to implement a specific POSIX C API function and make Linux compliant, e.g. ```sys_write, sys_read, ...```
* Major Linux desktop implementation: glibc.

1) [CLI utilities](http://pubs.opengroup.org/onlinepubs/9699919799/utilities/contents.html "CLI utilities")

* E.g.: cd, ls, echo, ...
* Many utilities are direct shell front ends for a corresponding C API function, e.g. mkdir.
* Major Linux desktop implementation: GNU Coreutils for the small ones, separate GNU projects for the big ones: sed, grep, awk, ... Some CLI utilities are implemented by Bash as built-ins.

1) [Shell language](http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18 "Shell language")

* E.g., ```a=b; echo "$a"```
* Major Linux desktop implementation: GNU Bash.

1) [Environment variables](http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap08.html#tag_08 "Environment Variables")

* E.g.: HOME, PATH.

1) [Program exit status](http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_08 "Program Exit Status")

* ANSI C says 0 or EXIT_SUCCESS for success, EXIT_FAILURE for failure, and leaves the rest implementation defined.
* POSIX adds:
  * 126: command found but not executable.
  * 127: command not found.
  * 128: terminated by a signal.
* But POSIX does not seem to specify the 128 + [SINGAL_ID rule used by Bash](http://unix.stackexchange.com/questions/99112/default-exit-code-when-process-is-terminated)

1) [Regular expression](http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap09.html#tag_09 "Regular Expressions")

* There are two types: BRE (Basic) and ERE (Extended). Basic is deprecated and only kept to not break APIs.
* Those are implemented by C API functions, and used throughout CLI utilities, e.g. grep accepts BREs by default, and EREs with -E.
  * E.g.: ```echo 'a.1' | grep -E 'a.[[:digit:]]'```

1) [Directory structure](http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap10.html#tag_10 "Directory Structure")

* E.g.: ```/dev/null, /tmp```
* The [Linux FHS](http://refspecs.linuxfoundation.org/FHS_3.0/fhs/ch01.html "FHS" greatly extends POSIX.

1) [Filenames](http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap03.html#tag_03_267 "Filenames")

* ```/``` is the path separator
* ```NUL``` cannot be used
* ```.``` is ```cwd```, ```..``` is  ```parent directory```
* minimum filename length that must be accepted is 14, 256 for full paths
* portable filenames should only contain: a-zA-Z0-9._-
* [See also: what is Posix compliance for filesystem?](http://stackoverflow.com/questions/18550253/what-is-posix-compliance-for-filesystem)

1) [Command line utility convention](http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap12.html "Utility Convention")

* Not mandatory, used by POSIX, but almost nowhere else, notably not in GNU. But true, it is too restrictive, e.g. single letter flags only.
* A few widely used conventions:
  * single dash means stdin where a file handle is expected: __-__
  * double dash terminates flags:  __--__
* See also: [Are there standards for Linux command line switches and arguments?](http://stackoverflow.com/questions/8957222/are-there-standards-for-linux-command-line-switches-and-arguments)

#### Who conforms to POSIX?

Many systems follow POSIX closely, but few are actually certified by the Open Group which maintains the standard. Notable certified ones include:

* AIX (IBM)
* HP-UX (HP)
* Solaris (Oracle)
* OSX (Apple)
  
Most Linux distros are very POSIX compliant, but not certified because they don't want to pay the compliance check fee.

#### Footnotes

[^48]: The answer was written by StackOverflow user [Siro-Santilli](http://stackoverflow.com/users/895245/ciro-santilli-%e5%85%ad%e5%9b%9b%e4%ba%8b%e4%bb%b6-%e6%b3%95%e8%bd%ae%e5%8a%9f-%e7%ba%b3%e7%b1%b3%e6%af%94%e4%ba%9a-%e5%a8%81%e8%a7%86)
    The question was asked by StackOverflow user [Claws](http://stackoverflow.com/users/193653/claws)
    and is licensed under CC BY-SA 3.0 ( http://creativecommons.org/licenses/by-sa/3.0/ ).
    Question URL: http://stackoverflow.com/questions/1780599/i-never-really-understood-what-is-posix
