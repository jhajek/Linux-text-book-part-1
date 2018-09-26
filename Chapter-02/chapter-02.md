# History of Unix and Linux

![*At the end of class if your instructor has done their job, you will find this cartoon funny.  If you already understand this cartoon you get an "A".*](images/Chapter-Header/Chapter-02/open_source.png "A GNU Dawn")

### Objectives

  * Understand how and why the Unix Operating System was created
  * Understand the contributions of Ken Thompson and Dennis Ritchie to Unix
  * Understand the contributions of Richard Stallman to Unix, Linux, GNU, the FSF, and *Free/Libre Software*
  * Understand the contributions of Linus Torvalds to the creation of Linux
  * Understand and explain how the AT&T and BSD lawsuit enabled the proliferation of Linux
  * Be able to describe and differentiate the five phases of Unix maturity
  * Understand the nature of modern commercial distributions of Linux and Unix operating systems
  * Understand the principles and key differences of *Free/Libre Software* and *Opensource Software*

### Outcomes

At the completion of this chapter a student will understand and be able to explain the history of the environment in which Unix and Linux were created. You will be able to relate key names; *Thompson, Ritchie, Stallman, and Torvalds* to their respective technological contributions to free and opensource software.  You will be able to understand what a distribution is and how free and opensource software relates to proprietary software.

*Convention Note*

In this chapter the terms **Linux** and **Unix** are generally inter-changable from a conceptual standpoint. For a large part of this book the conventions are the same - their history is intertwined. Though this book focuses on Linux we would be depriving you of the spectrum of free and opensource software we left Unix and BSD out. If you are curious the name is pronounced *"Lin-ucks;"* [link to audio pronunciation,](https://upload.wikimedia.org/wikipedia/commons/0/03/Linus-linux.ogg "Pronunciation of Linux") and Unix; *"Yoo-nix."*

## Where it Began and Why it Matters Now

Marc Andreesen, founnder of the Netscape Communicator browser (precursor to FireFox) famously said, "Software is eating the world."  The majority of that is Free/Libre Opensource software and the majorioty of it is Linux or Unix based.  This trend of software and philosophy of software started over 40 years ago in Unix has come to predominate the technology scene today. There is a good chance you have one your pocket Google's Android OS, or a laptop with Apple's MacOS (formerly OSX) which is based off on BSD Unix.  Even Microsoft Windows 10 has a Linux compatibility layer now. 

When we take a look all operating systems, at a foundational level all operating systems have three basic components. An operating system can be boiled down to three main parts:   

### The Kernel  [^1]

![*Kernel_Layout.svg*](images/Chapter-02/Kernel/Kernel_Layout.svg.png "Kernel Layout")

In the same way all plants require a seed or a kernel to grow, any computer operating system must contain a kernel.  This is a small piece of code that forms the core of your operating system.  You the user will not interact with the kernel, but devices you use, like a keyboard, mouse, touchscreen, or a Wi-Fi network card will do so when you take any action on the system.  How do the devices talk to the kernel?  They speak to the kernel via *device drivers*.  The figure above describes a two way flow of data; the user interacts with the operating system and the operating system, via drivers, interacts with the kernel.  The kernel is the hardware abstraction layer that handles all interfaces from the operating system to the hardware.  Without the concept of device drivers and a kernel, each manufacturer's computer would have to be custom built to communicate with the CPU.  The kernel abstracts away this concern.  The majority of operating system code and drivers is built in C or C++.

Take the Windows operating system for instance in which you have just one version, 7, 8, 10, etc. etc.  How many of you have an AMD processor?  Have an Intel processor?  What kind of network card or motherboard brand? You may not even know off the top of your head.  There is no need to know because of the Windows kernel or Linux Kernel abstracts these differences away.   

### Programming Language and Compiler Tools

Once you have a kernel to interface with the hardware, you need a programming lanugage or standard library that will let you build tools and code libraries to put the system to use.  In Unix and Linux most system tools and commands are built using the C language.  These tools such as gcc (GNU C Compuler) help you to compile and build other tools and programs.    

### User Interface and User Tools

All operating systems need a way for a user to interface with the kernel.  This is where the *shell* and *user applications* (sometimes called user-land) come into play.  The shell is a way for the user to send commands to the operating system--which executes these commands through the kernel and returns output to your screen.  Unix originally didn't have a graphical user interface but it always had a shell, which we will cover more about in chapter 5.  Even after CRT monitors became prevalent the GUI command line shell still was the standard interface.  X Windows is the standard windowing toolkit that allows for GUIs, *Graphical User Interfaces* to exist across Linux and Unix and will be covered more in chapter 5.     

User tools include all tooling or commands (executable binaries) needed to function in an operating system: copy, delete, move, make directory, kill a process, open a text editor to modify a file, issue a compile command to the C compiler, redirect output from the screen to a file, etc, etc.  

User applications like a web browsers and email clients are seen as user created tooling that is an amalgamation of many smaller tools to accomplish a larger task. With out these user tools and user interface, your computer would be essentially useless with no way to interact with it.

#### Linux is the same as Unix but...

Based on these three component we see that Unix is a complete operating system, but Linux is not. Linux just a kernel, missing items 2 and 3 from the above list. Despite this, you will hear people refer to it as an operating system. Depending on your audience you need to know both facets.  The Linux kernel plus someone else's *User Interface and User Tools* plus a *Programming Language* and *Compiler Tools* makes up a Linux distribution or simply called for short a *Linux distro*.

#### Who Uses Unix and Linux Today?  

  * [Facebook](http://royal.pingdom.com/2010/06/18/the-software-behind-facebook/ "Facebook architecture")
  * [Oracle](https://en.wikipedia.org/wiki/Oracle_Linux "Unbreakable Oracle Linux")
  * [Google](http://highscalability.com/google-architecture "You Tube Architecture" )
  * [Amazon](http://highscalability.com/blog/2007/9/18/amazon-architecture.html "Amazon Architecture")
  * [NYSE -New York Stock Exchange](https://en.wikipedia.org/wiki/New_York_Stock_Exchange "NYSE architecture")
  * [CME - Chicago Mercantile Exchange](https://en.wikipedia.org/wiki/Chicago_Mercantile_Exchange "CME architecture")
  * [Netflix](http://highscalability.com/blog/2015/11/9/a-360-degree-view-of-the-entire-netflix-stack.html "Netflix arch")
  * [WhatsApp](http://highscalability.com/blog/2014/2/26/the-whatsapp-architecture-facebook-bought-for-19-billion.html "whatsApp Architecture")
  * [Microsoft](https://en.wikipedia.org/wiki/History_of_Linux#Competition_from_Microsoft "2009 submitted 12,00 Lines of Code to the Linux Kernel")
  * [Pretty much every top website except stackoverflow.com](http://highscalability.com/all-time-favorites/ "Architectures")

Some would argue that without free and opensource software that companies like Google and Facebook never could have existed because the cost of buying the equivalent software would be prohibitive.

### Thompson, Ritchie, and Bell Labs

Many people supported and worked on what would become known as the Unix operating system but two names have received most of the credit for the creation, promotion, and use of Unix.  *__Know these names.__*

#### Ken Thompson and Dennis Ritchie

![*Ken Thompson and Dennis Ritchie*](images/Chapter-02/People/Ken-Thompson/Ken_n_dennis.jpg "Ken and Dennis")

Without Thompson and Ritchie[^2], there would be no Unix and most likely no Linux today.  Until recently both were employeed as Distinguished Engineers at Google.  Dennis Ritchie passed away in 2011 (same year as Steve Jobs). Ken Thompson is still working and recently helped produce the [Go programming language](http://golang.org/ "Golang") while at Google.

To begin this story we need to go back to 1968.  At the time, the combined might of all the brightest minds of General Electric, MIT, ARPA, and Bell Labs came together to try to build a multi-user operating system called *MULTICS*.  Now today those aren't names that come to mind when you think of computer companies.  Yet in 1968/1969 General Electric and the government (ARPA) were the large funders and suppliers of computing (The PC market we know of today doesn't come into existence until 1984!).

[Bell Labs](https://en.wikipedia.org/wiki/Bell_Labs "Bell Labs") at the time was basically the idea shop of the United States--where the best and brightest went to invent everything we take for granted today. Bell Labs was spun off by AT&T and became Lucent Technologies, which became Alcatel-Lucent and now is owwned by Nokia. One could argue that Google, Netflix, and Facebook have taken its place where the brightest minds go to invent new things in America.  No wonder that Dennis Ritchie, Ken Thompson, Brian Kernighan and even James Gosling (creator of the Java programming language) are and were employees at Google.

Like all projects that try to do too much, MULTICS stalled in gridlock between the different companies and the demands of the government.  This left one crafty engineer with free time and (for those days) a true rarity - unused computers; PDP-7s to be exact.  Ken Thompson had an insiders view of the innovative things MULTICS was trying to accomplish and why the inner workings of the MULTICS project went wrong. Thompson also had a job to do as a Bell Labs researcher.  On his own time, he began to use these PDP-7s and program his own multi-user operating system, but with a different twist.  It was designed by him, and solved daily work and coding problems he had.  

In 1969-70, the *"Unix"* concept had never been attempted.  Thompson had no idea that his pet work project was going to become part of a computing revolution.  Whereas MULTICS and other computer systems were designed by committees and based on marketable features--due to the nature of the up front financial investment, Unix was simple and easy to build because it solved only a small set of problems--which turned out to be the same problems every engineer had.  The overall reason that Unix took hold was that it was designed by engineers to solve other problems that engineers were having--enabling them to get work done.  

Unix differences from existing commercial Operating Systems

  * Written by Ken Thompson on his spare time
  * No company owned it or committee designed it for commercial purposes
  * Built by engineers
  * Solved problems that engineers had
  * Had a consistent design philosophy
  * Designed to be portable and work on many hardware vendor platforms

Thompson's Unix success was also a byproduct of its main design philosophy:

  *  Everything is a file
    + This means that everything can be read from or written to: all the way from devices to text files
  *  Unix is portable
    + Tools and OS code can be recompiled for different environments because everything is written in C.
  * I/O is redirectable between small executables
    + Small tools that do one and only one thing well
    + Output of one command becomes the input of another command.
    + Complex applications are built by chaining the output of small executables together with *pipes* -> "|"

The best demonstration of these tenants was during a coding challenge issued by [Jon Bently](https://en.wikipedia.org/wiki/Jon_Bentley_\(computer_scientist\ "Jon Bently") in 1986 to:

> *Read a file of text, determine the n most frequently used words, and print out a sorted list of those words along with their frequencies.*

There were two answers to the problem.  [Donald Knuth](https://en.wikipedia.org/wiki/Donald_Knuth "Donald Knuth") a preeminent computer scientist, called the "father of analysis algorithms" tackled the problem by originating an ingenious new programming language, lengthy documentation, and code to solve the problem.  Comparatively, [Doug McIlroy](https://en.wikipedia.org/wiki/Douglas_McIlroy "Doug McIlroy"), who was Thompson and Rithcie's manager, wrote a six line Unix shell script to do the same work Knuth did in his massive work. We will talk more about Doug McIlroy and his contributions to Unix in chapter 6. Here is his answer:

```bash
tr -cs A-Za-z '\n' |
tr A-Z a-z |
sort |
uniq -c |
sort -rn |
sed ${1}q
```

#### PDP-7

![*PDP-7 restored and running*](images/Chapter-02/PDP-7/320px-Pdp7-oslo-2005.jpg "Restored PDP-7")

Between 1970 and 1974 Unix grew from a pet project into a real product and one of its crowning achievements--its portability across hardware came to life.  Unix was originally written in assembly language for the PDP-7. It needed to be as low level code as possible because disk storage space was a *HUGE* problem in those days.  The code was good and highly optimized, but the problem with writing in low level assembly means that the code is optimized to only run on a PDP-7 system in this instance.  Not on a PDP-11 or a DEC VAX, or an IBM 360, etc, etc.

So what you gain in efficiency you lose in portability.  What good would it have been if Unix could only be used on a PDP-7[^3]? It would have stayed a Bell Labs pet project and become an obscure entry on a Wikipedia page today.

While Thompson was building Unix to solve his own workloads, his fellow engineers at Bell Labs got wind of what he was doing and asked to have access to his system.  These new people contributed additional functionality to solve their work problems.  Enter Dennis Ritchie, who championed Ken Thompson's Unix in Bell Labs.  Ritchie was a computer language creator and saw the utility of Thompson's Unix, but realized it was trapped by its use of PDP-7 assembler language.  Today we take for granted high level programming languages like C, C++, Python, and Java.  In the early 1970's none of these languages existed.

Ritchie's initial work at Bell Labs was on a high level programming language that could would allow a user to write one piece of code and compile it on different computer architectures. In 1970 this was generally not possible and a radical idea. His initial work was on a [language called "B"](https://en.wikipedia.org/wiki/B_\(programming_language\) "B Language") which was derived from a language called BCPL.  B was designed to execute applications and operating system specific tasks but didn't handle numeric data (a feature designed to save precious hard drive space). B was also missing other features you would expect in a modern programming languages.   

The next logical step was that Thompson and Ritchie went to work extending "B" with all the features they would need to make an operating system fully function and portable.  They called this language surprisingly, "C" -- the same "C" language you know today.  C was different from assembler in that is resembled assembler code syntax but a high enough level of abstraction that the "C" code was an independent language.  With the advent of C - Unix was rewritten in this language.  With the creation of C compilers for different hardware, Unix could now be built and be recompiled on different architectures, PDP-7, PDP-11, DEC VAX, DEC Alpha, IBM 360, SUN SPARC, eventually Intel and x86, etc, etc.  

### Assembler and C Language Comparison

[Hello World](http://en.literateprograms.org/Hello_World_%28Assembly_Intel_x86_Linux%29 "x86 Linux Intel Assembly") in x86 Intel Assembly for Linux.

```nasm
section .data
msg	db	"Hello World!",0x0a

len	equ	$-msg

section .text
	global _start

_start:

  mov	ebx,0x01
	mov	ecx,msg
	mov	edx,len
	mov	eax,0x04
	int	0x80

	mov	ebx,0x00
	mov	eax,0x01
	int	0x80
```

[Hello World](https://gist.github.com/adrianratnapala/1321776 "Linux assembly") in x86_64 Intel Assembly for Linux

```nasm
hello:
	.string	"Hello world!\n"
	.globl	_start

_start:
        # write(1, hello, 13)
        mov     $1, %rdi
        mov     $hello, %rsi
        mov     $13, %rdx
        mov     $1, %rax
        syscall

        # _exit(0)
        xor     %rdi, %rdi
        mov     $60, %rax
        syscall
```

[C Language equivalent of above code](https://en.wikipedia.org/wiki/List_of_Hello_world_program_examples#C "C Hello World")

```gcc
#include <stdio.h>

int main(void)
{
    printf("Hello, world!");
}
```

Since Ritchie created "C" to solve all the problems Unix had -- it became the defacto language of Unix and from that point on pretty much all operating systems are designed in "C" after Thompson and Ritchie showed that you could use a high level language to make Unix portable across many platforms.  Recently a project to restore the original UNIX assembly code from a tape and documents recovered from 1972 has begun and is [hosted on Google code](https://code.google.com/p/unix-jun72/source/browse/trunk/src/cmd/init.s "Initial Unix Code").

#### Brian Kernighan

![*Brian Kernighan in 2012 at Bell Labs*](images/Chapter-02/People/Brian-Kernighan/320px-Brian_Kernighan_in_2012_at_Bell_Labs_2-2.jpg "Brian Kernighan in 2012 at Bell Labs")

Thompson didn't have a name for his project initially, another related figure, Brian Kernighan[^4], can be credited with giving it the name UNIX.  This was a play on words--MULTI vs UNI in the name. Kernighan also helped write the original C language textbook along with Dennis Ritchie (Published in 1978, called K&R C which some of you might have used when in school).

![*K&R C*](images/Chapter-02/People/Brian-Kernighan/The_C_Programming_Language_First_Edition_Cover.svg.png "K&R C book cover")

## First Phase of Unix Maturity -- OS Implementation

By 1974/75 internal use of Unix at Bell Labs is high amongst engineers.  Word is starting to spread about it as Bell Labs engineers move on and into academia. Other Bell Labs divisions and universities got wind of this and begin to request Unix install *"tapes"* for their own use.  *Tapes* meant giant mounted magnetic tape reels that contained all the operating system code.  By law AT&T was prohibited from getting into the computer business so they took a hands-off approach to Unix at the time.  AT&T left it curiously as Thompson and Ritchie's pet project.  Many Universities at this time--wanting to teach computing and operating systems began to request copies of Unix to teach in their Operating Systems classes.  This was attractive to universities because Unix was a fully operational and working system but the main draw was that the source code was freely given away by Ken Thompson.  You sent him a letter, paid for shipping, and you got a reel within a week or so.  Thompson had no concept of "ownership" and freely shared his project with anyone who was interested.  This was evidence of free and opensource software even before the term was coined a decade later.

In 1975 Ken Thompson took a sabbatical from Bell Labs and went back to his Alma Mater, Berkeley, in California.  Installing the Version 6 Unix Release.  The students at Berkeley started adding their own features to improve it to solve their own problems.  One student in 1978, Bill Joy, added vi and the C Shell (two things still in use today in modern Linux and Unix) and people started referring to the changes made to the Unix at Berkeley as BSD Unix (Berkeley System Distribution Unix).

By 1980, with many copies of Thompson's Unix now in circulation and nearly a decade of work there started to be fragmentation of the original Unix and many universities adding on their own customizations. At this time the Berkeley System Distribution of Unix was beginning to vary widely in functionality and quality from commercial AT&T UNIX. Since the code was technically proprietary under AT&T's ownership there was no way to contribute code back to AT&T and this led to fragmentation.  Another interesting problem AT&T had was that by the end of the 70's all those students who had learned Unix in college went to work in corporations and began to request Unix to be used as their corporate hardware platforms at work. Unix was the only operating system of its kind that could do this.  Now AT&T had a financial motive to commercialize Unix.  By 1982 AT&T released Unix System III, followed by System V in 1983, as a commercial product for sale to commercial companies, while creating a multi-hundred dollar academic licensed fee for universities.  By the dawn of the 1980s the first phase of Unix maturity was complete. The operating system, its code, and it's design philosophy were well proven and in wide use across universities and commercial enterprises. Into the 1980s the focus of Unix takes a dramatic shift to users and application creation.

## Second Phase of Unix Maturity -- Unix Users, Application Development, and Licensing

The next phase of Unix history revolves around the important work done by developers to create applications and standards around the Unix operating system to increase productivity and accessibility.  There are many people who contributed to this phase but among the names we will discuss there is none more important than Richard Stallman, also known as RMS.

### Richard Stallman and GNU

![*Richard Stallman*](images/Chapter-02/People/Richard-Stallman/Richard_Stallman_at_CommonsFest_Athens_2015_2.JPG "Richard Stallman")

Richard Stallman[^5] was a researcher at MIT in the early 1980's.  He was part of what you would call today a *"hacker culture"* that was constantly researching and developing new tools and applications.  They were explorers eager to solve problems.  As Richard Stallman progressed in his studies at MIT he began to encounter events that he saw as counter intuitive to the hacker culture that had been created at MIT Artificial Intelligence Lab by 1984.  This lab had a strong culture of sharing software and ideas amongst its students, faculty, and employees.  By 1984 a number of small events began to erode this free environment.  One such issue was the introduction of account passwords for every computer user.  We take passwords for granted these days, but in the early 1980s they weren't standard issue and the implementation of them seemed draconian to users who had always used computers without passwords.

Another event which bothered Richard Stallman was the removal of the capability to modify a network printer's firmware to send an email in case of a paper jam.  This was a large problem as the networked printer was 2 floors up from the lab and involved quite a walk. THe original printer allowed access to their firmware code and Richard Stallman improved it and added a feature to send emails when a paper jam occurred.  The next version of the printer prevented the users from inspecting the firmware and changing or modifying the code--hence locking the lab into a proprietary device.  Worse--there was no mechanism for the lab to contribute its improvement to the printer back to the company.

Stallman disagreed with these concepts as they hindered the ability of the users to inspect the code and improve it, and share it to serve their needs. By 1983 Stallman began to argue that the users of the software's freedom were being trampled upon. To make matters worse, by 1984 AT&T began to withhold the source code of Unix and restricted the access of those in the academic world to be able to use the AT&T source code. Users were now beholden to the closed nature of the products they were using--even if they had paid for the software.  Stallman saw this as a moral injustice and set about making it his life's work to rectify this issue.

### The GNU Manifesto

By late 83/84 Stallman's desire to see free/libre software became a manifesto--an open declaration against proprietary code. This manifesto aimed to reverse engineer all the functionality, capability, and tooling of the then popular Unix operating system __BUT__ without the proprietary and restrictive licenses that commercial Unix operating systems entailed.  There by giving the world access to a *free* (as in freedom) operating system.  He would call it __GNU__  (guh-noo) or *GNU's Not Unix*.  Everything done under the GNU project would have the source code *free* for analysis, study, modification, and redistribution. Stallman always intended *free software* to fight perceived injustices relating to software.  The term *free software* has nothing to do with cost or money. Through the manifesto, Stallman wanted to let people know his project was Unix-like in functionality and operation and free as in freedom in relation to the source code and redistribution of it. 

He felt strongly enough to announce the GNU project publicly in the fall of 1983, and to quit his job working in the MIT lab in 1984 to avoid conflict of interests in pursuit of this work.  The [GNU Manifesto](http://www.gnu.org/gnu/manifesto.html "GNU Manifesto") was officially published on October 3rd, 1985 and issued a general call to free software arms. Here is the opening paragraph from the manifesto:

#### Why I Must Write GNU

> *"I consider that the Golden Rule requires that if I like a program I must share it with other people who like it. Software sellers want to divide the users and conquer them, making each user agree not to share with others. I refuse to break solidarity with other users in this way. I cannot in good conscience sign a nondisclosure agreement or a software license agreement. For years I worked within the Artificial Intelligence Lab to resist such tendencies and other inhospitalities, but eventually they had gone too far: I could not remain in an institution where such things are done for me against my will."*

> *"So that I can continue to use computers without dishonor, I have decided to put together a sufficient body of free software so that I will be able to get along without any software that is not free. I have resigned from the AI Lab to deny MIT any legal excuse to prevent me from giving GNU away."*

It is easy to write a manifesto but hard to lead a revolution they say. Stallman was one of those rare minds that could do both; a brilliant programmer who had the will and the raw skills and capability to build an entire operating system from scratch and give it away for free and he would get almost all the way there.

### Free Software Foundation and the GPL

In late 1985 the [FSF](http://www.fsf.org/ "FSF") -- *Free Software Foundation*, was formed to be the holder of all the intellectual property of the GNU project with the motto:

> *“Our mission is to preserve, protect and promote the freedom to use, study, copy, modify, and redistribute computer software, and to defend the rights of Free Software users.”*

With this, they wrote the GPL - GNU Public Lisence, which is a legally enforceable copyleft license.  Copyleft is a play on the word copyright, which a copyright restricts the rights of a user.  Copyleft, on the other hand enshrines and enforces certain rights to the user of the software.  The **4 software freedoms** that the GPL licensed software enshrines are:

1) the freedom to use the software for any purpose,
1) the freedom to change the software to suit your needs,
1) the freedom to share the software with your friends and neighbors, and
1) the freedom to share the changes you make.

> In using the term “Free software,” it means software that respects users' freedom and community. Roughly, it means that the users have the freedom to run, copy, distribute, study, change and improve the software. Thus, “free software” is a matter of liberty, not price. To understand the concept, you should think of “free” as in “free speech,” not as in “free beer”. We sometimes call it “libre software,” borrowing the French or Spanish word for “free” as in freedom, to show we do not mean the software is gratis[^114]. 

#### GCC, BASH, and GNU Coretools

In 1984 RMS started his work of creating a free Unix-like operating system.  Since Unix was built upon the C programming language, the first thing needed to build a kernel, a shell, or any tooling was a *C compiler*.  This project was called GCC (GNU C Compiler) which was a *"free"* version of the proprietary Unix AT&T "cc" program (C Compiler).  

After GCC was finished, Stallman could begin to build other tools with this *free* C compiler.  He needed an extensible text editor to edit files and with which to run GCC to build software. A few years prior, in 1981, James Gosling had created the Gosling Emacs editor; [gmacs](https://en.wikipedia.org/wiki/Gosling_Emacs "Gosling Stallman and Emacs").  We will learn more about editors in chapter 7. This name should be familiar because James Gosling would later go on to create the Java programming language while at Sun in 1994.  Stallman almost single-handedly rewrote all of Gosling's code to produce a *"free"* version of gmacs which he called GNU __Emacs__.  This program is over 30 years old and still in use and active development to this day.

The next step the GNU project took was to begin reverse engineering all the basic Unix tools and commands needed to accomplish tasks: such as [ls, grep, awk, mv, make and cp.](https://en.wikipedia.org/wiki/GNU_Project "Commands")   Eventually an entire "zoo" of projects was created and are available at [GNU Project website](https://www.gnu.org "GNU Website"). [Other GNU tools](http://www.gnu.org/manual/blurbs.html) were added by contributors and volunteers over the years.  BY 1991 the GNU Bash shell was completed.  A shell is the way the user interacts with the operating system to issue command.  This was the last major tool that needed completing to have an entire function *free* Unix-like operating system.

The GNU project did remarkably well in quality and quantity of *free* programs considering there were created mostly by volunteers with little funding and no corporate backing. They had pretty much reverse engineered, and in some cases improved, all the components of Unix by 1991 (8 years of work). The last thing the project was  missing was the most critical piece... they didn't have a kernel for their operating system.  Turns out that writing a kernel is much harder than it looks.  

#### GNU Hurd -- The Kernel That Was Not to Be

In their grand ambitions the GNU project was started in 1985 to create a kernel for the soon to come GNU operating system called [GNU Hurd](http://www.gnu.org/software/hurd/ "GNU Hurd"). The name GNU Hurd is also another clever recursive hack, as the name GNU has a double meaning.  There is a [large goat like animal called a gnu](https://en.wikipedia.org/wiki/Wildebeest "GNU"), which lives in herds that roam the plains of Africa.  The name *Hurd* came from the similarities of a herd of animals and the design of the GNU Kernel would be a "herd" of small micro-processes communicating together, like a herd of gnus (the animal).  It seems that GNU developers really love cleaver hacks.  It it something that you have to get used to in opensource as the spirit of bad puns and clever hacks has carried on to this day.

Hurd made some false starts in its initial micro-kernel development phase causing multiple versions to be created and scrapped.  What they were trying to do was really innovative but really complicated and difficult to make work reliably. In retrospect Hurd was never finished.  By 1998 The GNU project had all but stopped active development and promotion of GNU Hurd as the kernel for its *free* operating system.  The GNU project realized that the Linux Kernel had accomplished what GNU had working on for 13 years in a mere 4 years.

GNU Hurd still exists and is in a usable alpha stage. It is [downloadable today](http://www.gnu.org/software/hurd/ "GNU HURD Download") by joining it with the Debian Linux distribution applications--all GPL compliant mind you.

The GNU project instead recommends using the Linux kernel instead and joining the GNU tools with it to form GNU/Linux.  In some ways this is the realization of Stallman's dream of a *free* operating system and yet some ways this was his biggest disappointment that Linus Torvalds and not the GNU project finished the kernel.  By 1991 a new name comes onto the scene, Linus Torvalds and the Linux kernel come along and make the next leap in the *free* and opensource operating system world by introducing the Linux kernel.

### Free and Opensource State in the 1990s

#### Professor Andrew Tanenbaum and Minix

Before we talk about the Linux kernel, we need to talk about the state of other free adn opensource operating systems at this time.  One main one comes to mind: the Minix operating system.  With the closing off of the AT&T Unix source code in 1984 to academics and researchers in the university - they were left without source code to show as examples in classes.  

![*Professor Andrew S. Tanenbaum*](images/Chapter-02/People/Andrew-Tanenbaum/AndrewTanenbaum2-2.png "Professor Andrew S. Tanenbaum")

[Professor Tanenbaum](http://www.cs.vu.nl/~ast/ "Tanebaum's website") [^6] was teaching at Vrije Universiteit in Amsterdam - and began to write and implement his own *free* Unix-like operating system initially for teaching and research purposes.  It was 12,000 lines of C code and system call compatible with commercial Unix.  The name [Minix](http://www.minix3.org/ "Minix 3 website") was a combination of "minimal" and "Unix."  Minix 1.0 and 1.5 were released in 1987 and 1991 respectively. Minix 1.0 and 1.5 were freely available to anyone as the source code came in the appendix to a [textbook about operating systems](https://en.wikibooks.org/wiki/Minix_3 "Minix") written by Tanenbaum in 1987.  Minix was designed to run on older x86 Intel processors (286 and 386 systems) and in version Minix 1.5 a port was included for Sun Sparc processors.

These were common desktop stations in use at the university at that time.  Any enterprising student could find and old 286 PC or old Sun Sparc Station to run Minix on. The source code for Minix 3 is currently available in a [Git repository](http://git.minix3.org/index.cgi "Minix Git") and is still being developed and researched.  In 1991 many people believed that Minix could have been a viable alternative to commercial Unix and become the still missing GNU Hurd kernel.  But the Minix creator, Professor Tanenbaum, was not interested in moving into competition: the code was nowhere near as mature as the Unix code base, which by 1991 had been in existence for almost 20 years!  Minix appeared on the radar but was not the missing piece to the GNU puzzle.

### Linus Torvalds and Linux

![*Linus Torvalds*](images/Chapter-02/People/Linus-Torvalds/320px-LinuxCon_Europe_Linus_Torvalds_03.jpg "LinuxCon Europe Linus Torvalds 03")

In 1991, Linus Torvalds was a graduate student at the University of Helsinki in Finland.  As a student Torvalds was using Unix for his courses on the university's [Sun SparcStations](https://en.wikipedia.org/wiki/SPARCstation "SparcStations").  He was not pleased with Sun's Unix, called SunOS, but felt it was the best of the commercial Unix available.  His real dream was to run his own Unix-like operating system on his own personal PC.  He had recently purchased an Intel x386 processor based desktop PC.  Linus tried using Minix, but was put off by its minimalist approach and realized it had some good design concepts but was not a complete Unix replacement.  In a fashion not unlike Ken Thompson, Torvalds set out in the early part of 1991 to see if he could build his own kernel for his own operating system for his own use and purpose that was Unix-like but wasn't Minix.

This was very impressive feat for a single person. Torvalds himself acknowledged that if GNU Hurd had been ready for production or if at this time AT&T hadn't been suing BSD, he would have re-used their kernel work and not built his own. By August 25th of 1991 the initial release of the Linux kernel was posted online[^7].  The quote from the beginning of the chapter was the basis of the initial post to the Minix Usenet Newsgroup(A newsgroup was a bulletin board-like precursor to the actual Internet - like Google Groups in a sense--today you would use Twitter). His initial work was not quite a full-fledged system but really just a small kernel, with a port of the GNU Bash shell, and a port of the GNU C Compiler (GCC)Many things were missing, support for other processors, audio, printers, etc etc but it was like a crack in a damn - something was about to burst forth in the operating system world.

By September of 1991 Linux kernel version 0.01 had been posted to the University of Helsinki FTP servers for public download.  The initial kernel included this [release note](https://www.kernel.org/pub/linux/kernel/Historic/old-versions/RELNOTES-0.01 "Linux Initial release notes") by Linus:

> *"Sadly, a kernel by itself gets you nowhere. To get a working system you need a shell, compilers, a library etc. These are separate parts and may be under a stricter (or even looser) copyright. Most of the tools used with Linux are GNU software and are under the GNU copyleft. These tools aren't in the distribution - ask me (or GNU) for more info."*

By February of 1992 Linux 0.12 kernel had been released.  As more users began to download and use Linux, Linus decided to give the project a proper license for its use.  Having seen Richard Stallman speak at the University of Helsinki a few years prior, Linus was inspired and decided to release the Linux Kernel under the GPLv2 license.  This was the smartest thing anyone could have done and no one could have foresaw the great economic value the Linux kernel and GNU tools licensed under the GPL has generated for many companies.  This combination allowed Google to start and grow to its tremendous size.  This combination allowed companies such as Amazon, Yahoo, and Google to get a tremendous start by allowing them to customize the Linux operating system not having to place precious startup capital into Unix licenses.

The reason why Linux is so popular is because of this fledgling kernel that worked enough for people to use, hack on, build upon, and improve now had a governance structure with the GPL that could accept code contributions and be available for commercial work as well.  Being GPL the Linux kernel was instantly compatible with all of the entire GNU project's tools base.  You instantly had the kernel that GNU was missing and the Linux kernel had all the tools and applications it needed to be usable.     

People began downloading and compiling the Linux kernel, adding the GNU tools, and making fully capable Unix-like operating systems for personal use soon after commercial use.  Linus' brilliance comes not from ingenuity but comes from good engineering principals like knowing when not to go down dead-end development trails.  Torvalds' work was not perfect but was good enough that others could take it and start to use it and improve upon it.  From 1992 to 2001 the Linux kernel grew rapidly in size and features and spawned commercial companies to sell and support Linux Distributions. Stallman's dream of a complete free and opensource operating system was being realized.  

This should have been cause for great celebration amongst the Linux and GNU communities.  The FSF saw this as a victory for GNU and began calling the system GNU/Linux, assuming that without the GNU tools, the Linux kernel would be useless.  The FSF assumed credit in this case.  But Linus Torvalds didn't see it that way.  He just referred to the system as Linux.  He just ignored the FSF's requests and people referred to what should have been GNU/Linux as just Linux, leaving the GNU part out even though all of their tooling is what made Linux possible.  In a sense that is Linus' unique personality. On the other hand, Richard Stallman will not conduct any interview unless their is an agreement to only use the term GNU/Linux not Linux. Some would argue that this is Stallman's ego, but he insists he only wants credit where credit is due. This issue is still a matter of contention for the FSF today.

#### Linux Kernel Attributes Compared to Unix OS Attributes

Creation Method

  * Linus Torvalds as a graduate student at a university because of his curiosity
  * Thompson and Ritchie developed as Bell Labs Engineers to solve computer problems

Release Cycle

  * Linux releases a new kernel in short windows and maintains an LTS, Long Term Support Kernel version as well
   + Linux distributions have to plan around this and choose which kernel to use.
  * Unix/BSD maintain a complete operating system and release everything together in a 1 to 2 year cycle

License

 *  The Linux kernel is licensed and protected under the GPLv2 and allows individuals and corporations alike to contribute back to the Linux kernel, but source code must be open and freely available.
 *  Each BSD project is licensed under a permissive license which allows for derivative works to be made without requiring that the source code be given back to the main project.  BSD distros do take outside contributions.
   + Commercial Unix does not take outside contributions

Tooling

  * Any Linux based operating system need to make use of a set of coretools -- usually the GNU coretools to be able to function
  * BSD/Unix may use some GNU coretools but has their own versions internally built in with the distro

#### Linus' Personality

Some people think Linus' personality is a shtick or a comedy act he puts on.  But whatever it is he is very straight forward in dealing with people, and will not spare anyone a harsh public rebuking if he thinks they made a sloppy mistake.  He justifies this as kernel work is hard and you need to be prepared to take difficult criticism if you are going to survive here. Some consider Linus really mean and even aggressively mean spirited to those with whom he has disagreements.  When approached about this, Linus states that he only cares about the kernel and no one else matters to him.  These links below provide some points and counter points about Linus.  

*  [Torvalds' right to offend](http://www.wired.com/2013/07/linus-torvalds-right-to-offend/ "rights")
*  [Torvalds doesn't care](http://arstechnica.com/business/2015/01/linus-torvalds-on-why-he-isnt-nice-i-dont-care-about-you/ "Doesn't care")
*  [Linus' response to previous article](http://arstechnica.com/business/2015/01/linus-torvalds-responds-to-ars-about-diversity-niceness-in-open-source/ "Response")

On September 16, 2018, Linus Torvalds issued a public apology for his past behavior and temporarily stepped down as Linux Kernel maintainer.  You can read the apology letter on the [Kernel mailing list](https://lkml.org/lkml/2018/9/16/167 "Linus Apology").   Some say the apology wasn't needed, some say it is too little too late.  Others wonder if a man of Linus' age (48) can be reformed.  Some see this as a step in the right direction and offer a chance for redemption, some would prefer him never to return.  This opens a bigger question of what happens to the Linux Kernel if Linus never returns, who becomes the maintainer?  Time will tell.

### AT&T and BSD Lawsuit

The nascent Linux project saw a rush of growth and developer contribution from August of 1991 to February of 1992. But where did all these developers come from?  At this time we need to go back to Berkeley University and check in on the BSD project, (Berkeley System Distribution).  In the late 80s and up to the early 1990s BSD Unix development had been flourishing at Berkeley.  Some would attribute this to great minds and an open environment, some would attribute it to lots of government funding.  Either way the product produced began to eclipse the commercial AT&T Unix in features and quality.  BSD began to significantly and irreconcilably differ from AT&T Unix.

AT&T seeing this decided in the early 1992 to take the BSD project to court in order to stop BSD from cutting into their commercial business.  BSD technically came from AT&T Unix back in 1976, when Ken Thompson took his sabbatical at Berkeley and brought the then pet project AT&T Unix with him. AT&T found that some of the BSD code had not been changed as was claimed and was still original AT&T Unix code, which they claimed was a copyright infringement. In early 1992 AT&T was granted a court ordered development injunction against the BSD project, preventing development work from being done on BSD Unix.  This was the perfect time for Linux kernel development to flourish, protected by the GPL, there were no licensing or copyright issues to worry about. BSD developers in droves flocked to the Linux project. By the time the lawsuit was finished in late 1993/1994 it was too late.  All that had happened was that BSD no longer use the term Unix to describe itself an they had to rewrite a handful of programs to remove the AT&T code.  AT&T had succeeded in planting the seed for the growth of the entire Linux industry with this action. The Linux rocket had left the launch pad and was never coming back.

After the BSD and AT&T lawsuit was settled the BSD code base split into three and then four main distribution families--each with their own focus but all common enough to share code between them. Also they are free of any contention with commercially licensed Unix and usable for enterprise work. Unlike Linux, BSD lacks a major corporate sponsored distribution, like Ubuntu or Red hat.  All are maintained by volunteer organizations.

  *  FreeBSD
   + DragonFlyBSD
  *  OpenBSD
  *  NetBSD

## Third Phase of Unix Maturity - Free and Opensource Software Enter the Enterprise

### Free Software vs. Opensource Software

By the end of the 90s a curious thing was happening; Microsoft had a near total domination of the desktop PC operating system market and was being investigated by the US Department of Justice for anti-competitive practices. Apple had just brought Steve Jobs back as CEO and was beginning to take steps towards recovering from a decade of mediocre performance.  The internet as an item we recognize today was just beginning to take root in homes across America through dialup services like [AOL](https://en.wikipedia.org/wiki/AOL "AOL"), [Compuserve](https://en.wikipedia.org/wiki/CompuServe "Compuserve"), and [Prodigy](https://en.wikipedia.org/wiki/Prodigy_\(online_service\) "Prodigy"). At the same time, the quality of free and opensource software was increasing.  The internet was being powered by webservers and databases.  Opensource tools such as Apache Webserver and MySQL database became the *killer apps* to use on Linux or BSD to run these applications.

The term opensource software is pervasive today but in 1998, it didn't exist.  The term *free software* had existed since 1985, but because of the ambiguity of the English word *free* it became associated with zero-cost free and not freedom free.  The term *free* can also give the potential idea of cheap or shoddy work--compared to professional proprietary work and the enterprise would not touch it.  

The term *opensource* was not a movement away from the principles of *free software* but a chance to show the enterprise that the opensource development model was sustainable and could produce superior products.  In order to better understand the difference we need to meet some of the key players. Enter Eric S. Raymond.

#### Eric S. Raymond

![*Eric S. Raymond*](images/Chapter-02/People/Eric-Raymond/256px-Eric_S_Raymond_portrait.jpg "Eric S. Raymond")

Eric S. Raymond[^8] had long been a free software developer and part of the hacker community. Raymond's most famous contribution to opensource is writing a seminal paper that was later reprinted in book form called, [__"The Cathedral and the Bazaar"__](http://www.catb.org/~esr/writings/cathedral-bazaar/introduction/ "The Cathedral and the Bazaar")  

His main point was that by business-as-usual practices Linux should have been a massive failure and a poorly implemented experiment.  But instead it was an unprecedented success because of the opensource development method.  His article examined why this is the case comparing the cathedral like design of Emacs and GCC--open but not publicly available during development versus Linux bazaar style development of everything publicly open and available at all time via the internet.

In conclusion Raymond proposed that opensource code and opensource design methodology of treating your user as a valued resource was vital to an opensource project's success.  Based on this Raymond and [Bruce Perens](https://en.wikipedia.org/wiki/Bruce_Perens "Bruce Perens") founded the [Open Source Initiative (OSI)](http://opensource.org/ "OSI") and were part of the group that in 1998 coined the term "opensource". Their goal was to continue to promote free software but instead of focusing on the moral issue of software freedom, they focused on the design principals of producing superior software.  A quote from Raymond puts his opinion bluntly;

> *As head of the Open Source Initiative, he (Raymond) argued that advocates should focus on the potential for better products. "The "very seductive" moral and ethical rhetoric of Richard Stallman and the Free Software Foundation fails, he said, "not because his principles are wrong, but because that kind of language ... simply does not persuade anybody".* [Eric S. Raymond](https://en.wikipedia.org/wiki/Eric_S._Raymond#Open_source "Quote")

The "Cathedral and the Bazaar" was influential in helping the Netscape Corporation opensource their Netscape Web Browser code before the company was sold to AOL, under the name of the Mozilla project.  This code gave rise to what would eventually become the Firefox web browser in 2002--thanks to Raymond's writings.  

Richard Stallman and thd FSF alleged the OSI was willing to make freedom compromises in order to make larger productivity gains with opensource software and fired back in his article ["Open Source Misses the Point"](http://www.gnu.org/philosophy/open-source-misses-the-point.html "Open Source Misses the Point") The terms do overlap, but Free Software and opensource ultimately have two divergent meanings and *free* software is *not* opensource software.

There has been some compromise between the two camps by using the term __FLOSS__, [Free, Libre, and Open Source Software](https://en.wikipedia.org/wiki/Free_and_open-source_software\#FLOSS "FLOSS"), but the FSF does not recommend any licensing that allows a user's freedom to be restricted.  One way to conceptualize the difference would be to look at the concept of [DRM software](https://en.wikipedia.org/wiki/Digital_rights_management "DRM"), which is basically the copy protection schemes on DVDs and digital music downloads.  The OSI group would not be opposed to build opensource DRM software.  But the FSF would be opposed to the entire concept of DRM--which is a tool they believe restricts a user's freedom to play their DVD anywhere and in any way.

You can read Raymond's two seminal books on Unix and opensource philosophy online as they are free and opensource licensed:

  * [The Art of Unix Usability](http://www.catb.org/~esr/writings/taouu/html/ "Book link")
  * [The Cathedral and the Bazaar](http://www.catb.org/~esr/writings/cathedral-bazaar/ "CatB")

### Opensource Software Definition

Open source doesn't just mean access to the source code. According to the [Opensource Initiative](https://opensource.org/ "Opensource Initiative") written by Bruce Perens, the now 10 rights enshrined in the OSD encompases the 4 software freedoms and extend them with a focus on applications in the business world. The distribution terms of open-source software must comply with the [following criteria:](https://opensource.org/osd-annotated "Annotated definition") 

1. Free Redistribution
    i) The license shall not restrict any party from selling or giving away the software as a component of an aggregate software distribution containing programs from several different sources. The license shall not require a royalty or other fee for such sale.
2. Source Code
    i) The program must include source code, and must allow distribution in source code as well as compiled form. Where some form of a product is not distributed with source code, there must be a well-publicized means of obtaining the source code for no more than a reasonable reproduction cost, preferably downloading via the Internet without charge. The source code must be the preferred form in which a programmer would modify the program. Deliberately obfuscated source code is not allowed. Intermediate forms such as the output of a preprocessor or translator are not allowed.
3. Derived Works
    i) The license must allow modifications and derived works, and must allow them to be distributed under the same terms as the license of the original software.
4. Integrity of The Author's Source Code
    i) The license may restrict source-code from being distributed in modified form only if the license allows the distribution of "patch files" with the source code for the purpose of modifying the program at build time. The license must explicitly permit distribution of software built from modified source code. The license may require derived works to carry a different name or version number from the original software.
5. No Discrimination Against Persons or Groups
    i) The license must not discriminate against any person or group of persons.
6. No Discrimination Against Fields of Endeavor
    i) The license must not restrict anyone from making use of the program in a specific field of endeavor. For example, it may not restrict the program from being used in a business, or from being used for genetic research.
7. Distribution of License
    i) The rights attached to the program must apply to all to whom the program is redistributed without the need for execution of an additional license by those parties.
8. License Must Not Be Specific to a Product
    i) The rights attached to the program must not depend on the program's being part of a particular software distribution. If the program is extracted from that distribution and used or distributed within the terms of the program's license, all parties to whom the program is redistributed should have the same rights as those that are granted in conjunction with the original software distribution.
9. License Must Not Restrict Other Software
    i) The license must not place restrictions on other software that is distributed along with the licensed software. For example, the license must not insist that all other programs distributed on the same medium must be open-source software.
10. License Must Be Technology-Neutral
    i) No provision of the license may be predicated on any individual technology or style of interface.

## Fourth Phase of Unix Maturity - The Rise of Commercial Linux

As the 1990s came to a close we began to see established companies adopting and using opensource projects in enterprise, such as MySQL for database and GCC as a C/C++ compiler.  Especially we begin to see companies trying to make commercial distributions of Linux by adding the GNU coretools and a GUI interface.  Of all the Linux companies that started at that time, Red Hat Linux is one of the few remaining and by far the most successful. How successful?  To illustrate this, as of August 10th 2015, Red Hat Linux has a market cap of [~14 billion dollars.](http://ycharts.com/companies/RHT/market_cap "Red Hat Market Cap") Most of the Linux distributions started pre-2003 no longer exist.

### Modern Linux Distributions

As the new century dawned, the realization of Stallman's dream for the the GNU operating system was now a reality.  Companies began to combine the opensource Linux kernel, free GNU coretools, and by integrating GUIs such as X11, KDE, and the GNU GNOME project, began to create what one would say was a GNU/Linux based operating system. Each company made their own Linux distribution, also known as a *distro*.  As distributions began to proliferate, each distribution began to spawn flavors, derivatives, and different spins as well.

It is curious to see that there were a few small commercial BSD distributions at the same time, but none of them rose to prominence.  One might ask that without the financial backing of a commercial entity could a distro ever rise beyond a niche use?  BSD distros would argue that mass commercialization was never their primary goal.     

As of 2017, we have almost 25 years of Linux Kernel and Linux distribution work. Current Linux distributions hail from two primary and distinct families: __Debian__ and __Red Hat__.   There are many other quality distributions of Linux that I don't want to leave out or paint in a bad light.  For the purposes of this book I will focus on two main distribution families.  You can find almost all known Linux distributions at [http://distrowatch.com](http://distrowatch.com/ "Distro Watch")

#### Additional Popular Linux Distros

   *  [Slackware](http://www.slackware.com/info/ "Slackware")
   *  [Gentoo Linux](https://www.gentoo.org/get-started/about/ "Gentoo Linux")
   *  [SUSE Linux](https://en.wikipedia.org/wiki/SUSE_Linux_distributions "SUSE Linux")
   *  [Kali Linux](https://www.kali.org/ "Kali Linux") - Hacking tool based Debian distro
   *  [antiX Linux](http://antix.mepis.org/index.php?title=Main_Page "antiX") - lightweight Debian derivative focused on old machines.
   *  [Arch Linux](https://www.archlinux.org/ "Arch Linux")
   *  [Tails Linux](https://tails.boum.org/ "Tails Linux") - Online security focused Debian based distro
   *  and many more at [http://www.distrowatch.com](http://www.distrowatch.com "Distro Watch")

### The Debian-based Family

![*Ian Murdock - founder of The Debian Project*](images/Chapter-02/People/Ian-Murdock/256px-IanMurdock.jpg "Ian Murdock")  

> *"I founded Debian in 1993. Debian was one of the first Linux distributions and also one of the most successful and influential open source projects ever launched. Debian pioneered a number of ideas commonplace today, including employing an open community that allowed (and encouraged!) anyone to contribute (much like how Wikipedia would later operate). And, with its integrated software repositories anyone could contribute to, Debian arguably had the industry’s first (albeit primitive) “App Store”. Today, more than 1,000 people are involved in Debian development, and there are millions of Debian users worldwide."* - [http://ianmurdock.com](http://ianmurdock.com)

Unfortunately on December 31st, 2015, Ian Murdock succumbed to mental illness and took his own brilliant life. Bruce Perens eulogized him in this post: [https://perens.com/blog/2015/12/31/ian-murdock-dead/](https://perens.com/blog/2015/12/31/ian-murdock-dead/ "Ian Murdock"). His legacy lives on through the Debian family of distros, which contains 4 major sub-families[^9].

#### Debian

![*Debian*](images/Chapter-02/Linux-logos/Debian/109px-Debian-OpenLogo.svg.png "Debian Logo")

The Debian distribution (pronounced *"dehb-ian"* officially, but sometimes the stress is put on the first syllable and you will hear *"dee-be-an"*) was founded in 1993 By Ian Murdock and is unique for being one of the only non-commercially backed Linux distro still in existence.  The current release is Debian 8.5 codenamed Jessie, as of June 2016. The Debian project has unique characteristics that were designed into the project from the very beginning. Many believe these features are the key to their long term success and usage across the Linux landscape as there are [currently 122 major Debian based distros](http://distrowatch.com/search.php?ostype=All&category=All&origin=All&basedon=Debian&notbasedon=None&desktop=All&architecture=All&status=Active "Debian based distros") in existance according to distrowatch.com.

   * Initial release schedule was yearly but as Debian project has grown now is two year release schedule
   * It is the only major Linux distribution not backed by a corporation.  
   * Debian is an all volunteer project and organization--project leader is elected on a rotating basis
   * Dedicated to protecting software rights and freedoms of users
   * First major distribution to come with a [software contract](https://www.debian.org/social_contract "Contract") - stating what rights the project will guarantee to the user.
   * Debian supports free and opensource software as superior to closed source but will allow for closed source software/drivers to be installed by the user.
   * Supported at various times 11 different processor types giving it a wide install base.
   * The Debian project and its history can be found at:
     + [About the Debian Project](https://www.debian.org/intro/about)
	 + [History of Debian](https://www.debian.org/doc/manuals/project-history)

#### Ubuntu

![*Ubuntu Linux*](images/Chapter-02/Linux-logos/Ubuntu/128px-Ubuntu_logo_copyleft_1.svg.png "Ubuntu Linux")

Ubuntu Linux is a unique distribution [^10].  It is entirely based on Debian.  It is Debian repackaged with a focus on applications that "just work."  Around 2004, [Mark Shuttleworth](https://en.wikipedia.org/wiki/Mark_Shuttleworth), the founder of Ubuntu, was unnerved that Windows had such a dominant position in the PC market.  He had been a Debian developer, but felt that the lack of a corporate sponsor in some ways hindered Debian from catching market share from Windows.  He set out to make a Debian based distro which he called Ubuntu.  Shuttleworth is from South Africa and Ubuntu is a Zulu word meaning *"community"*. Shuttleworth wanted his Linux distro to be people friendly and work really well out of the box--like Windows.  

In 2004 Red Hat, who had owned the desktop Linux market, decided to exit and focus on selling Linux based server operating systems to corporate entities. Red Hat felt there was little money to be made in that market where the code was given away freely. This left a void that Ubuntu rushed to fill and they did it well. By 2006, Mark Shuttleworth who had started the Thawte SSL security company, which was bought out by Verisign, took his money and invested 10 million dollars in the Ubuntu Foundation to subsidize the creation and maintenance of Ubuntu Linux.  

![*Mark Shuttleworth*](images/Chapter-02/People/Mark-Shuttleworth/128px-Mark_Shuttleworth_by_Martin_Schmitt.jpg "Mark Shuttleworth")

What made Ubuntu so successful was that they forked the opensource work of rock-solid Debian and built on top of it by adding closed source code and user centered features that where necessary in order to make the best experience.  They had a business in mind and have indeed captured the desktop Linux market.  But one problem is they haven't found a way to make much money off of their excellent product.  Ubuntu has a 10 million dollar parachute in the form of the Ubuntu Foundation which was seeded by Mark Shuttleworth [^11]. Shuttleworth formed a commercial company called [Canonical](http://www.canonical.com/ "Cannonical") that was formed to handle commercial support and hires the developers who work on Ubuntu.  Ubuntu is commercially backed.  

Ubuntu pioneered the idea of rolling releases - releasing every 6 months compared to Microsoft or Apple on a 3 to 5 year schedule.  Each distribution is released in late April and late October so there are two distributions per year.  Ubuntu also introduced the concept of an *LTS*, Long Term Support - this means that certain releases will have security patches, fixes, and software backported to it for 5 years, allowing you to base an enterprise business off of this product and assured system stability.  The LTS releases happen every even year with the April distribution.  So Ubuntu 10.04, 12.04, 14.04, 16.04, 18.04 and so forth (the first number being the year).

#### Linux Mint

![*Linux Mint*](images/Chapter-02/Linux-logos/LinuxMint/256px-Linux_Mint_logo_and_wordmark.svg.png "Linux Mint")

Linux Mint started also in 2006 as a fork of the Ubuntu project but with a different desktop interface [^12].  Linux Mint focused even more on the user and desktop experience out of the box by adding missing multimedia codecs for playback of audio and video directly to the install (looking at you Flash).  Linux Mint is even more user experience focused than Ubuntu and is one of the most popular Ubuntu based distros.  Linux Mint can be considered a sub-family because although it is Ubuntu based, Mint makes usability choices that are the opposite of what Ubuntu chooses. There by leading to a different operating system.

#### Devuan

![*Devuan Linux*](images/Chapter-02/Linux-logos/Devuan/Devuan-logo.png "Devuan")

[Devuan Linux Project](http://www.devuan.org "Devuan") (Pronounced *Dev-one*) is a fork of the entire Debian project - not just a Debian based distro.  This is a result of the "Debian Civil War" of early 2015 where in half of the Debian Project developers left the project to begin work on this distribution.  It is a direct fork of the Debian 8.0 Jessie Code base with one major incompatible change to the core operating system; that cannot be merged back into Debian.  The disagreement stemmed from Debian's decision to implement Red Hat's systemd init system over the old but reliable sysVInit.  To change the core operating system is a monumental task and these volunteers undertook it and succeeded.  The state of the OS is in late beta as of August 2016 with isos and VM images available for download.  We will talk about this more in detail under the topic "Linux Civil War" later in this chapter.

#### Other Debian Based Distros

Some of the other notable Debian/Ubuntu based distros are as follows:

   *  [Xubuntu](http://xubuntu.org "Xubuntu")
   *  [Lubuntu](http://lubuntu.net "Lubuntu")
   *  [Kubuntu](http://www.kubuntu.org/ "Kubuntu") Ubuntu remixed with the KDE desktop Environment
   *  [SteamOS](http://store.steampowered.com/steamos "SteamOS") Steam online gaming company's official Linux distro
   *  [Kylin Linux](http://distrowatch.com/ubuntukylin "Kylin Linux") Ubuntu Distro designed for Mandarin Chinese as opposed to English.
   *  [Raspian](http://www.raspbian.org/ "Raspian") This is a Debian based distro that is standard recommended for the Raspberry Pi.
   *  [gNewSense](http://gnewsense.org "gNewSense") GNU/Linux FSF distro, entirely GPL compliant software.
   *  [trisquel](https://trisquel.info "Tri-skel") GNU/FSF recommended and Richard Stallman uses this one.
   *  [tails](https://tails.boum.org/ "tails") The Amnesic Incognito Live System (Tails) is a Debian-based live CD/USB with the goal of providing complete Internet anonymity for the user.
   *  [elementaryOS](http://elementary.io/)elementary OS is an Ubuntu-based desktop distribution, designed to look and feel like MacOS.  It also has an interesting pricing model.  
   *  [Kali Linux](https://www.kali.org/ "Kali Linux") - Hacking tool based Debian distro

### Red Hat Family

Red Hat Linux distribution was formed after the Debian project by Marc Ewing and Bob Young.  The company went public August 11th, 1999.  Red Hat source code is currently shared across three main distributions: The Fedora Project, RHEL (Red Hat Enterprise Linux), and CentOS. Currently there are [25 Fedora based distros](http://distrowatch.com/search.php?ostype=All&category=All&origin=All&basedon=Fedora&notbasedon=None&desktop=All&architecture=All&package=All&status=Active) or as Fedora calls them *"spins"* -- this term is unique to Fedora.

  *  [About Red Hat](http://www.redhat.com/en/about/company)
  *  [Red Hat History](http://www.redhat.com/infographics/corporate/data/ "Red Hat History")

#### Fedora Project

![*Fedora Project*](images/Chapter-02/Linux-logos/Fedora/768px-Logo_Fedora_full.svg-96dpi.png "Fedora Project")

The [Fedora Project](https://en.wikipedia.org/wiki/Fedora_Project "Fedora Project") was started in 2003 when the Red Hat Desktop Linux product was merged with the company/community based spin off Fedora Core Linux [^13].  The [Fedora Project's](https://getfedora.org/ "Get Fedora") focus was rapid development and rapid release.  They would release two distributions almost yearly, with package and update support only extending back to the previous version cutting off support to viable, but from Red Hat's point of view, outdated software.  Remember their focus was rapid iteration of the project to quickly test new technologies.  

For example Fedora 24 was released on 06/21/16, Fedora 23 was released on 11/03/15, Fedora 22 was released on 05/26/2015, Fedora 21 was released 12/09/2014, and Fedora 20 was released 12/17/2013.  Fedora 20-23 are no longer supported anymore - even though they were released within the last two years! Why is the Fedora Project so fast and so merciless on not supporting older versions?  This distribution was meant for desktop users and developers who don't mind updating rapidly.  In reality the Fedora Project is really just a testing ground for technology that will eventually go into Red Hat's enterprise project, referred to as RHEL.

#### Red Hat Enterprise Linux--RHEL

![*RHEL*](images/Chapter-02/Linux-logos/RHEL/320px-RedHat.svg.png "RHEL")

Red hat's founder Mark Ewing had been an IBM employee prior to forming Red hat.  He knew something about enterprise software and more importantly enterprise profits.  Red hat began it's life as a desktop Linux company.  They quickly shifted their focus to compete not with Microsoft and Apple, but to take on the Unix enterprise giants of IBM, HP, Sun and AT&T.  These companies had one thing in common: they were all Unix vendors.  Red hat's vector was to dislodge the established Unix vendors with Red Hat Enterprise Linux (RHEL). They would succesfully attack this market with entirely opensource products and runnning on commodity Intel x86 based processors.  With Oracle also sensing a chance to capture market share along with RHEL, it announced it would port its database products to RHEL and this platform became to the go to choice for using Oracle as a database. By Oracle doing this they have all but abandoned Solaris and positioned themselves to take on Windows Server and MsSQL Server. 

The key to RHEL's success in the enterprise is its long term stability.  The RHEL application platform is expected to run for 5+ years.  An enterprise grade server product cannot be changing every six months like the Fedora project.  Red hat instead takes "snapshots" from the Fedora project and freezes them to produce RHEL versions.  For example, as of fall 2015 the released version of RHEL was 7.1 which is a freeze of the technology from Fedora 19, which was released July of 2013.  

How successful is this strategy? By 2012 Red hat became the first Linux based company to make a billion dollars in a physical year.  But this success brought about an additional serious opensource question; RHEL is licensed under the GPLv2 Free Software license, which requires that all source code for your product to be freely and openly available. That means anyone can examine, modify, and redistribute your code for their own product as well. What if someone did that?  Wouldn't they be able to ride the coat tails of Red hat to success?  The CentOS project did just that.

#### CentOS

![*CentOS*](images/Chapter-02/Linux-logos/CentOS/CentOS_Logotype.png "CentOS logo")

By 2010 RHEL was firmly entrenched as a viable enterprise based server platform. Many customers loved the reliability of RHEL, but the two year technology freeze was to long for some people.  They wanted to use RHEL but with the opportunity to update libraries and applications much quicker. The CentOS (*Community ENTerprise Operating System*) emerged[^14].  The goal of this project is to use the freely available GPLv2 code of RHEL and redistribute it with their own custom modifications.  Some would argue that CentOS is succeeding based on RHEL's hard work. Until about 2014, Red hat had a very frosty relationship with the CentOS developers--even taking them to court numerous times over trademarked Red hat logos that had not been properly removed by CentOS developers. Their developers, like Debian, are entirely volunteer based and not backed by a company (technically since they base their work off of RHEL--they are commercially backed via Red hat).

Eventually all of Red Hat's copyrighted material was removed and CentOS then in full compliance with the GPLv2 license.  This made Red Hat angry because they felt that CentOS were pirates stealing their work and causing them to loose sales to enterprises that had been using RHEL but had switched to use CentOS.  By 2014, Red Hat and Centos came to terms to work together--with Red Hat offering to sell support contracts to CentOS users.  Is CentOS doing anything illegal?  Anything immoral?  Not according to the GPLv2 and the spirit of free and opensource software.

#### Oracle Linux

Not to be out done by CentOS, Oracle saw that many of their customers were paying Red hat for operating systems licenses, buying support contracts, and running an Oracle database on top of it.  Oracle wanted a piece of this pie.  Oracle made a fork of RHEL's opensource code as well, adding Oracle product code and services and redistributing it as Oracle Linux.

[Oracle Linux](https://en.wikipedia.org/wiki/Oracle_Linux) was born in 2007 and is a fully GPL compliant OS.  Oracle claims that their *"Unbreakable Enterprise Kernel"* is fully compatible with RHEL, and that Oracle middleware and third-party RHEL-certified applications can be installed and run unchanged. One may ask, isn't this illegal too? Is Oracle breaking the law? Are they stealing RHEL software and reselling it?  Is this piracy? Not according to the GPL - they are fully entitled to do this and thus compete with Red Hat selling support contracts on Red Hat's created software--this is the nature of the GPL license.   

### Unix and the BSD Family Distros

While Linux was exploding in the mid 1990s the AT&T lawsuit against BSD had been settled and work could resume on the BSD forks of Unix.  The BSD code splintered into 3 main families or distros that are all descended from the original BSD Unix project.  This leaves large pieces of BSD code compatible with each other. BSD is not Linux and technically not Unix but functions in a vary similar manner to Unix.  The BSD world is not immune from forks and divisions.

#### FreeBSD

![*FreeBSD*](images/Chapter-02/Linux-logos/FreeBSD/128px-Freebsd_logo.svg.png "FreeBSD")

   * Released in November 1994
   * Essentially the inheritor of the BSD code base
   * Largest BSD implementation used by WhatsApp and Netflix.
   * No direct commercial backing, instead run by a non-profit foundation.
   * Legally prohibited from using the term *"Unix"* as outcome of AT&T lawsuit.
   * Board of directors are elected and drives development decisions and policies

#### TrueOS

   *  FreeBSD based distro with a focus on user interface and experience.
   *  Provides friendly installers and package managers for users on top of existing FreeBSD installation
   *  Created new Lightweight desktop environment called [Lumina](http://lumina-desktop.org/)
   *  Project started by Kris Moore who has been a FreeBSD developer
   *  Project was recently renamed TrueOS

#### DragonFly BSD

![*DragonFly BSD*](images/Chapter-02/Linux-logos/DragonFlyBSD/dragonflybsd_small_logo.png)

   * Fork of FreeBSD in April of 2005 by Matthew Dillon.
   * Has significantly diverged from the original FreeBSD code base.
   * Maintains its own package repositories
   * Focused on unique techniques to handle multiprocessing in the FreeBSD kernel
   * Introduced a new filesystem called [HAMMER and HAMMER2](https://en.wikipedia.org/wiki/HAMMER "HAMMER FS")

#### Other BSD projects

  * Ghost BSD
  * Hardened BSD

#### OpenBSD

![*OpenBSD*](images/Chapter-02/Linux-logos/OpenBSD/128px-OpenBSD_Logo_-_Cartoon_Puffy_with_textual_logo_below.svg.png "OpenBSD")

   * Theo de Raadt was banned/left from the NetBSD project in 1994.
   + He complained that they were developing too slow and not focusing on security.
   * Started a fork of NetBSD at the end of 1995   
   * OpenSSH, OpenNTPD, OpenSMTPD, LibreSSL, OpenBGPD, and [other projects](http://www.openbsd.org/innovations.html "BSD Innovaations") comes out of this project.
   + [Microsoft recently became the first "gold sponsor" of the project](http://undeadly.org/cgi?action=article&sid=20150708134520)
   * Project is focused on radical implementations of security and safe coding practices--leveraging itself as the most secure OS.

#### NetBSD

![*NetBSD*](images/Chapter-02/Linux-logos/NetBSD/128px-NetBSD.svg.png "NetBSD")

   * Released October of 1994 as another version of the BSD code after the lawsuit.
   * Focuses on portability to run this OS on nearly every platform you can think of.

#### Minix 3

   * [Minix 3](https://en.wikipedia.org/wiki/MINIX_3 "Minix 3") released October of 2005.
   * Since then the OS went from a teaching tool to a product being used commercially.
   * Began using NetBSD userland applications for a GUI and package management.

### Solaris Based Unix Distros

#### Solaris

  *  Oracle killed commercial Solaris in the middle of the night [September 3rd, 2017](http://dtrace.org/blogs/bmc/2017/09/04/the-sudden-death-and-eternal-life-of-solaris).
  *  Commercial Unix distribution created by SUN in the 1980s and bought by Oracle in 2010.
  *  Sought to merge the best of Sys V and BSD into one standard Unix.
  *  Ran on propriatery SPARC hardware platform
  *  Leader in operating system feature development.
    + ZFS
    + Dtrace
    + Zones (OS Containers/Jails)
    + Network based installation -- Jumpstart
  * By 2006 began the process of opensourcing their technology and operating system.

#### OpenSolaris

![*OpenSolaris*](images/Chapter-02/Linux-logos/OpenSolaris/128px-OpenSolaris_Logo-2.svg.png "Open Solaris")

   * In 2006 Sun had experimented with creating and opensource user based distro from their Unix based Solaris OS [^16]
   * They hired Ian Murdock (the guy who started Debian) to oversee this project
   * Project was called OpenSolaris but was killed when Oracle purchased Sun in 2010
   * [Explanation of how OpenSolaris was killed and *closed* sourced by Oracle.](http://www.slideshare.net/bcantrill/fork-yeah-the-rise-and-development-of-illumos "Fork")

#### Illunmos

![*Open Indiana*](images/Chapter-02/Linux-logos/OpenSolaris/128px-OpenIndiana_logo_large-2.svg.png "Open Indiana")

   *  After the OpenSolaris project was shut down and Oracle fired most of the Solaris developers.  The last verson of OpenSolaris was forked into a project called Illumos. [^15]
   *  Illumos is not a distro but a reference implementation in which other OSes are based.
    + openindiana
    + Nexanta
    + SmartOS

#### SmartOS   

  *  [SmartOS](https://smartos.org/ "SmartOS") released by Joyent and full of ex-Sun engineers who worked on Solaris. [^17]  
   + Combines the best of the BSD/Solaris products but runs the best of Linux based desktop applications and software--especially the KVM Virtualization Platform
  * Recently purchased by Samsung for their OS container technology stack called Triton and Manta.
  * Innovative company ahead of the technology curve by a few years--watch this space.
  * Releases all software even their production clouds as open source.

## Phase Five of Unix Maturity - Hard Changes to the Nature of Linux

![*Lennart Poettering*](images/Chapter-02/People/Lennart-Poettering/640px-Lennart_poettering-2.jpg "Lennart Poettering")

Not since Linux Torvalds has a single developer been pervasive in the Linux community. Lennart Poettering is currently a developer for Red Hat[^18], and had previously developed [PulseAudio](https://en.wikipedia.org/wiki/PulseAudio "pulse") and [Avahi](https://en.wikipedia.org/wiki/Avahi_(software) "Avahi")--network discovery demon.  Lennart is mostly known for *systemd*.  Systemd was designed as a modern replacement for SysVinit, the intial program responsible for starting all other system processes in Unix/Linux.  

Why would this technology be so devisive?  Well, the init system is at the root of your entire operating system and defines how the OS operates and interacts with processees.  Change is difficult and the init system has been set and well known since 1983, it is even called sysVinit, after the System V AT&T Unix release. Poettering has irked many people by breaking with certain perceived Unix conventions.  For him, the Unix philosophy of having small programs do one thing well is a byproduct of bygone era where computers had small amounts of storage and low processing power.  He has sentimentality for the work of Thompson and Ritchie, but not if something more efficient can be created. Lennart argues, if Linux wants to be taken serious like MacOS and Windows, these changes are not only necessary but actually closer to the core Unix philosophy then what SysVInit provides.  

The other major point of contention is with all the change systemd makes to the init process, many other pieces of software need to change as well.  Linux has always been about the freedom to choose your software, but systemd has made fundamental choices forcing fundamental changes to the structure of how software interacts with the Linux kernel.  For example, the GNOME desktop developers have chosen to integrate their software with systemd directly.  This means that you have no choice but to use systemd instead of SysVInit. if you want to use the GNOME desktop. You are basically locked into using GNOME as a Desktop environment in this case, which some would argue is progress and some would argue as captivity.  Note that BSD still uses SysVInit; systemd is a pure Linux-ism and not compatible with BSD. 

According to BSD developer Benno Rice at the BSDcan 2018 presentaiton on systemd, systemd gives Linux, a systems management layer that had always been missing, not unlike what exists in Windows today.  You need to give Lennart credit as well as by now all major Linux distros have adopted systemd as its init system. Lennart convinced his management at RedHat to take a chance on his technology, and now most of the industry followed suit 6 years after he first released systemd.  That is not an easy accomplishment if you think about it.

This leads to an interesting point.  As of 2016, all major Linux distros adopted systemd--so the argument is over.  The first company to adopt systemd was RedHat, which Lennart had managed to convince his management to adopt hsi system, that is pretty impressive.  Debian was the last hold out and they had a sprited debate, which led to a number of resignations and the community split over this issue.  Debian developers left and went on to form a distro called [Devuan](http://www.devuan.org "devuan")--which is focusing on removing all  systemd and udev dependencies from a Debian based linux distro.  

In it's defense, systemd has many nice and actually new and needed features for Linux.  Lennart is updating pieces of Linux that haven't been touched in decades. He even wrote a [21 part defense](http://0pointer.de/blog/projects/systemd-for-admins-1.html "21") of systemd on his website. We will talk more on the technical aspects of systemd in the chapter 11.  By using systemd, Linux distros make another fundamental choice, to break with Unix based sysetm compatability.  Systemd is entirely linux centric and draws a sharp dividing line between Linux and Unix/BSD based distros.

### Linux Conspiracy Theory?

The fears of the Linux community are that systemd will continue to coerce developers to make dependency choices based on systemd's requirements and eventually force Linux users into supporting systemd as "the standard Linux."  Some of the conspiracy theorists believe that since Red Hat is backing systemd, this is their way to corner the Linux market. Also some believe that Red Hat couldn't coerce Linus Torvalds under their wing and that this is the way to innovate around him.  Could this be an [*"embrace, extend, and extinguish"*](https://en.wikipedia.org/wiki/Embrace,_extend_and_extinguish "Embrace, extend, and extinguish") tactic that Oracle and Microsoft were once so famous for conducting on rival technologies?  

What makes this all the more intriguing is that Lennart works for Red Hat.  Would Red Hat mind if systemd technology improved the Linux experience at the cost of choice of software and freedom available to the user?  That is a good question.  This also begs the question - can Linux survive as an independent and open software project or does it need a commercial company backing it?  Could this be seen as Red Hat's grab for the entire Linux market?  

*  [Redhat updates Fedora 23 and 24](https://blogs.gnome.org/uraeus/2015/10/28/fedora-workstation-23-24-update/ "Fedora update")
*  [Fedora Finished with SysVInit](http://www.phoronix.com/scan.php?page=news_item&px=Fedora-Finish-SysVinit "Fedora and SysVinit")

## Chapter Conclusion and Summary

In this chapter you were introduced to many names in relation to the history of free and opensource software.  We were introduced to the founding of the UNIX operating system and hwo it lead directly to the creation of the GNU project, the FSF, Linux, and Free and Opensource software.  You were introduced to the major Linux distribution families as well as the BSD derivative distros.  Finally you were introduced to the five phases of UNIX maturity and how they relate to business and commercial interests.  [Additional Reading on the history of UNIX and BSD can be found here.](http://www.oreilly.com/openbook/opensources/book/kirkmck.html "History of Unix")

### Review Questions

Either individually, as a class, or get into groups and watch the documentary movie [Revolution OS - https://www.youtube.com/watch?v=jw8K460vx1c](https://www.youtube.com/watch?v=jw8K460vx1c) made in 2001.  The film includes interviews with many of the names that were discussed in this chapter.  Watch this movie and answer the questions below or via the online assignment provided for you by the instructor.

1. Based on the movie's tone and rhetoric - why do you think there was an anti-Microsoft tone at the time of the movies making (~2001)? (You may need to research [Microsoft anti-trust case](https://en.wikipedia.org/wiki/United_States_v._Microsoft_Corp. "Anti-Trust") ).

1. When Bill Gates wrote his 1976 *"Open Letter to Hobbyists"*, was he justified in his complaint?  Why or why not?

1. Would Richard Stallman enter into a discussion on which is a **better** product: Microsoft Word or LibreOffice Writer? Why or why not?  Would Eric S. Raymond enter into a discussion on which is a **better** product: Microsoft Word or LibreOffice Writer? Why or why not?

1. Why did Bruce Perens help write the Open Source Definition / Debian Social Contract Standard?

1. What were the two commercial Linux companies featured in the movie?

1. What is Red Hat Linux's stock price today compared to the the price listed in the movie?  What is VA Linux's stock price today compared to the movie? (Hint VA Linux was sold and now belongs to another company, find that company's stock price.)

1. According to Eric S. Raymond what was the major application that needed to "flip" for opensource to become a viable enterprise solution?

1. What was the first major commercial company to opensource a key product?  What did that product eventually become?

1. How does Richard Stallman react at the end of the movie to the success of the Linux kernel to the exclusion of the GNU toolchain?  

1. What is the main difference between *"Free Software"* and *"Open Source Software"*?

### Podcast Questions

Listen to the FLOSS podcast number 73 with [Tim O'Reilly - http://twit.tv/floss/73](http://twit.tv/floss/73)

 *  Who is Tim Orielly? ~3:00-5:00
 *  What is Oscon? ~6:45
 *  Who coined the term web 2.0? ~13:34
 *  What did we learn from the IBM PC? ~18:30
 *  What is web 2.0? ~19:30
 *  Open Source vs Open Data - what does Tim Orielly think is the ultimate destination for computing? ~23:00
 *  Where is the money made in open source - software or data? ~ 34:00
 *  What prediction did Tim Oreilly make in this podcast (2009) that is now coming true? ~51:32
 *  [radar.oreilly.com](http://radar.oreilly.com) What is the lag time from articles on this site to the main stream media? ~55:00

### Lab

Most of the popular and functional pieces of software you use everyday invovle Free and OpenSource. Choose 2 case studies from [https://highscalability.com](https://highscalability.com "High Scalability") and write a review of the company's architecture based on these issues:  

Post your topics on the Blackboard Class Discussion board under the Chapter-02 Case Studies forum - both of your case study choices have to be unique from everyone else. Those who choose first will get the ones they want. There are over 200+ case studies there will be plenty of options.

You can find them at [https://highscalability.com/blog/category/example](http://highscalability.com/blog/category/example "Case Study Examples")  or look on the High Scalability website on the lower right hand side for the "All Time Favorites" header to find some of the more popular services.   Its best to find a company that you use or support.

Answer these questions (not all of the Answers are in each case study!)

1. What market does that company serve? (What do they do?) And have they always served that market?
1. What Operating System(s) are used?
1. What programming languages/frameworks are used?
1. What storage and what database technologies are used?
1. What is the current stock price and what was the IPO of the company? (if traded publicly.)
1. What major obstacle (cost, system performance, QPS, etc, etc) was the company trying to overcome by implementing this technology stack?
1. What can you learn from this article relating to technology and infrastructure?

Each Student will give a 1-2 minute presentation of one of their papers the following class.

#### Footnotes

[^1]: [By Bobbo (Own work) via Wikimedia Commons](https://commons.wikimedia.org/wiki/File%3AKernel_Layout.svg)

[CC BY-SA 3.0 (http://creativecommons.org/licenses/by-sa/3.0) or GFDL (http://www.gnu.org/copyleft/fdl.html)](https://commons.wikimedia.org/wiki/File%3AKernel_Layout.svg)

[^2]: [See page for author Public domain, via Wikimedia Commons](https://commons.wikimedia.org/wiki/File%3AKen_n_dennis.jpg)

[^3]: [By en:User:Toresbe via Wikimedia Commons](https://commons.wikimedia.org/wiki/File%3APdp7-oslo-2005.jpeg)

[CC SA 1.0 (http://creativecommons.org/licenses/sa/1.0/)](https://upload.wikimedia.org/wikipedia/commons/thumb/5/52/Pdp7-oslo-2005.jpeg/512px-Pdp7-oslo-2005.jpeg)

[^4]: [By Ben Lowe via Wikimedia Commons](https://www.flickr.com/photos/blowe/7984191331/ "Brian Kernighan in 2012 at Bell Labs 1")

[CC BY 2.0 (http://creativecommons.org/licenses/by/2.0)](  https://commons.wikimedia.org/wiki/File%3ABrian_Kernighan_in_2012_at_Bell_Labs_1.jpg)

[^5]: [By Dkoukoul (Own work) , via Wikimedia Commons](https://commons.wikimedia.org/wiki/File%3ARichard_Stallman_at_CommonsFest_Athens_2015_2.JPG "Richard Stallman at CommonsFest Athens 2015 2")
[CC BY-SA 4.0 (http://creativecommons.org/licenses/by-sa/4.0)](https://upload.wikimedia.org/wikipedia/commons/thumb/a/a8/Richard_Stallman_at_CommonsFest_Athens_2015_2.JPG/320px-Richard_Stallman_at_CommonsFest_Athens_2015_2.JPG "Richard Stallman at CommonsFest Athens 2015 2")

[^6]: By derivative work: Okoura (talk)AndrewTanenbaum.JPG: GerardM (AndrewTanenbaum.JPG)
<a href="http://creativecommons.org/licenses/by/2.5">CC BY 2.5</a>,
<a href="http://www.gnu.org/copyleft/fdl.html">GFDL</a> or
<a href="http://creativecommons.org/licenses/by-sa/3.0/">CC-BY-SA-3.0</a>,
<a href="https://commons.wikimedia.org/wiki/File%3AAndrewTanenbaum2.png">via Wikimedia Commons</a>

[^7]:   By Krd (Own work) <a href="http://creativecommons.org/licenses/by-sa/3.0">CC BY-SA 3.0</a>
or <a href="http://creativecommons.org/licenses/by-sa/4.0">CC BY-SA 4.0</a>, <a href="https://commons.wikimedia.org/wiki/File%3ALinuxCon_Europe_Linus_Torvalds_03.jpg">via Wikimedia Commons</a>

[^8]: By Erc_S_Raymond_and_company.jpg: jerone2derivative work: Bilby (Erc_S_Raymond_and_company.jpg)
<a href="http://creativecommons.org/licenses/by-sa/2.0">CC BY-SA 2.0</a>, <a href="https://commons.wikimedia.org/wiki/File%3AEric_S_Raymond_portrait.jpg">via Wikimedia Commons</a>

[^9]: By Ilya Schurov , Computerra Weekly (originally posted to Flickr as 9722_00_23_14)
<a href="http://creativecommons.org/licenses/by-sa/2.0">CC BY-SA 2.0</a>, <a href="https://commons.wikimedia.org/wiki/File%3AIanMurdock.jpg">via Wikimedia Commons</a>  

[^10]: By Macguy314 (Own work)
<a href="http://www.gnu.org/copyleft/fdl.html">GFDL</a> or <a href="http://creativecommons.org/licenses/by-sa/3.0">CC BY-SA 3.0</a>, <a href="https://commons.wikimedia.org/wiki/File%3AUbuntu_logo_copyleft_1.svg">via Wikimedia Commons</a>

[^11]: By Martin Schmitt (cropped by Mary Gardiner) (http://www.flickr.com/photos/foobarbaz/141522112/)
<a href="http://creativecommons.org/licenses/by/2.0">CC BY 2.0</a>, <a href="https://commons.wikimedia.org/wiki/File%3AMark_Shuttleworth_by_Martin_Schmitt.jpg">via Wikimedia Commons</a>   

[^12]: By Clement Lefebvre <a href="http://creativecommons.org/licenses/by/3.0">CC BY 3.0</a>
<a href="https://commons.wikimedia.org/wiki/File%3ALinux_Mint_logo_and_wordmark.svg">via Wikimedia Commons</a>

[^13]: See page for author [Public domain]
<a href="https://commons.wikimedia.org/wiki/File%3AFedora_logo_and_wordmark.svg">via Wikimedia Commons</a>

[^14]: By CentOS Project (http://wiki.centos.org/ArtWork/Logo/Type)
<a href="http://www.gnu.org/licenses/gpl.html">GPL</a> or Public domain, <a href="https://commons.wikimedia.org/wiki/File%3ACentOS_Logotype.png">via Wikimedia Commons</a>    

[^15]: By openindiana.org [Public domain]
<a href="https://commons.wikimedia.org/wiki/File%3AOpenIndiana_logo_large.svg">via Wikimedia Commons</a>

[^16]: By Sun Microsystems (OpenSolaris) <a href="http://www.gnu.org/copyleft/fdl.html">GFDL</a>
or <a href="http://creativecommons.org/licenses/by-sa/3.0/">CC-BY-SA-3.0</a>, <a href="https://commons.wikimedia.org/wiki/File%3AOpenSolaris_Logo.svg">via Wikimedia Commons</a>

[^17]: By Joylent (uploaded by (Lamro@enwiki) [Public domain]
<a href="https://commons.wikimedia.org/wiki/File%3AJoyent-logo.png">via Wikimedia Commons</a>

[^18]: By Kushal Das (Own work) <a href="http://creativecommons.org/licenses/by-sa/3.0">CC BY-SA 3.0</a>
<a href="https://commons.wikimedia.org/wiki/File%3ALennart_poettering.jpg">via Wikimedia Commons</a>   

[^114]: <a href="https://www.gnu.org/philosophy/free-sw.en.html">https://www.gnu.org/philosophy/free-sw.en.html</a>
