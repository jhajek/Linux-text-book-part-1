# History of Unix and Linux

![*At the end of class you will find this cartoon funny*](http://imgs.xkcd.com/comics/open_source.png "Understanding the Technology and Philosophy of Linux Part I")

[*If you still don't like it, that's OK: that's why I'm boss. I simply know better than you do. Torvalds, Linus(1996-07-22)*](http://groups.google.com/groups?selm=4sv02t%24j8g%40linux.cs.Helsinki.FI)
## - The Foundation of Unix and Linux

Why are you learning about Linux?  It is a term that seems to be on everyone's lips.  There is a good chance that you even have Linux running in your pocket and don't even know it! Raise your hand if you have an Android based phone or tablet? Here is a hint, Android Operating System is based off of Linux.  So this chapter begins the start of your mastery of Linux.  In addtition to teaching you technology, this book aims to teach you about the history and philosophy of Linux so you can understand where it came from and where it is going and why you are using it.  Some pieces of this book will seem frustrating, after all the roots of the design decisions of what we are using today are 30-40 years old in some cases.  Helping to understand what kind of technology was available and what these creators were thinking will help you master the concepts of Linux.

__Chapter 2 Objectives__

  * Understand how the Unix Operating System was created 
  * Understand the contributions of Ken Thompson and Dennis Ritchie to Unix
  * Understand the contributions of Richard Stallman to Unix, Linux, GNU, and FOSS
  * Understand the contributions of Linus Torvalds to the creation of Linux
  * Understand the nature of modern commercial implementations of Linux
  * Understand the principles of the Linux Community and what the *"free"* in *"Software Freemom"* means

__Outcomes__
 
 At the completion of this chapter a student will understand and be able to discuss the environment in which Unix and Linux were created. They will be able to relate key names; *Thompson, Ritchie, Stallman, and Torvalds* to their technilogical contributions.  They will be able to understand what Linux and Unix are and how they relate to FOSS and commercial softare.

*Convention Note*

  You will notice that I have been using the terms Unix and Linux interchangably so far.  For a large part of this book the conventions are the same - their history is intertwined. Though this book focuses on Linux we would be depriving you of the full truth if we left Unix out.  For this first chapter then we need to understand their related history.  There are differences and there are similarities.  

## Where it Began and Why it Matters Now 
 
  When we say *"Unix"* we are referring to an entire operating system.  An Operating System can be boiled down into three main parts.   

  1.  __Kernel__
 
  <a title="By Bobbo (Own work) [CC BY-SA 3.0 (http://creativecommons.org/licenses/by-sa/3.0) or GFDL (http://www.gnu.org/copyleft/fdl.html)], via Wikimedia Commons" href="https://commons.wikimedia.org/wiki/File%3AKernel_Layout.svg"><img width="256" alt="Kernel Layout" src="https://upload.wikimedia.org/wikipedia/commons/thumb/8/8f/Kernel_Layout.svg/256px-Kernel_Layout.svg.png"/></a>
    
  Unix includes a kernel - a hardware abstraction layer that handles all the interfaces from the operating system to the hardware.  The kernel is the portion of the Operating system that allows you to write once and interface with hardware through drivers.  Otherwise you would have to compile the operating system everytime and include the hardware drivers for your hardware.  Take Windows for instance - you have just one version for all of the hardware out there.  Intel Chips, AMD processors, Marvell, Broadcom, and many others.  But there is no need to buy a version of Windows, Mac, or Linux specific to that hardware - software drivers are inserted into the kernel and allow Windows, Mac, or Linux to simply communicate with the hardware.  Think of the Kernel liek the engine of a car.  
  
  2. __User Interface and Operating System Tools__
 
  All operating systems need a way for a user to interface with the kernel.  This is where the Shell and User Applications come into play.  The Shell is a way for you as the user to send commands to the operating system--which executes these commands through the kernel.  Unix originally didn't have a graphical user interface, its time of being developed in the 70's precluded this. Once CRT monitors became prevelant the commandline shell became the standard interface.  This allowed you to type commands direclty on a screen and see the results back--no paper involved.  Eventually the [X Windows System](https://en.wikipedia.org/wiki/X_Window_System) came along giving you the familiar desktop windows you are most likely used to, allowing for mouse and keyboard input.  X Windows is the standard windowing toolkit that prety much all versions of Linux GUI build upon today.   

  Operating System tools include simple tools you take for granted like copy, delete, move, make directory, kill a process, open a text editor to modify a file, issue a compile command to the C compiler, or redirect output from the screen to a file.  All these tools and more are included in Unix as an operating system.
  
  User applications like a web browsers and email clients are seen as tools that are created by the user that just repurpose the existing Operating System tools and are built/installed by the user.

  3.  __Coding and Compiler Tools__

  Perhaps we are used to just clicking on .exe or .dmg files and off our installation of Chrome or Firefox goes.  In the Unix world all software is built using the C language.  You needed a compiler to build the kernel, operating system, system applications, user tools, and any additional tools you create. Without a C compiler you cannot build or make anything.  Today most code is pre-compiled for you and you can use other languages, but in the early days of Unix and Linux a C Compiler was neccesary as you were building the kernel and operating system from scratch.  
 
__Linux is the same as Unix but...__
 
  Linux on the otherhand is technically not a full operating system like Unix.  It is actually just a kernel, and is missing all the other tools listed above, though you will hear people refer to it as an operating sysetm.  Depending on your audience you need to know both facets.  The Linux kernel plus someone elses User Interface and Operating System Tools and Coding and Compiler Tools and premade user applications makes up a Linux distribution or simply Linux distro. Every company and person can equally contribute to the Linux kernel and add whatever they like on top of it.  Linux was built out of the Unix world, keeping all the same conventions and ideas from Unix but starting in a different place.  I think a good analogy would be the American Colonies in 1776 - they thought of themselves as Europeans, they came out of Europe but yet were starting new in America.   

__Take away point__
  
  Who uses Linux today?  
  
  * Facebook
  * Google
  * Amazon
  * RedHat
  * NYSE
  * CME
  * Android
  * [Microsoft](http://www.informationweek.com/enterprise/microsoft-contributes-to-linux-kernel----and-its-not-april-1/d/d-id/1081481) 
  
  The question is not who uses Linux but the question should be when did you last use it?  How did it get this way?  Where did it come from?  Ignore this part at your own peril, you will never understand Linux unless you understand UNIX at its core philosophies.  Here we go.

### - Thompson, Ritchie, and Bell Labs

  Many people supported and worked on what would become known as Unix but two names have received most of the credit for the creation, promotion, and use of Unix.  *__Know these names.__*
  
__Ken Thompson and Dennis Ritchie__

<a title="See page for author [Public domain], via Wikimedia Commons" href="https://commons.wikimedia.org/wiki/File%3AKen_n_dennis.jpg"><img width="256" alt="Ken n dennis" src="https://upload.wikimedia.org/wikipedia/commons/3/36/Ken_n_dennis.jpg"/></a>
    
  Without Thompson and Ritchie, there would be no Unix and most likely no Linux today.  Until recently both were hired as Distinguished Engineers at Google.  Dennis Ritchie passed away in 2011. Ken Thompson is still working and recently help produce the [Go programming language](https://en.wikipedia.org/wiki/Go_(programming_language) from Google. 

  To begin We need to go back to 1968.  The Unix project got it start in something called MULTICS, which was an attempt to build a multi-user operating system.  At the time, this combined all the brightest minds of General Electric, MIT, ARPA, and Bell Labs.  Now today those aren't names you think of when you think of computers.  Yet in 1968/1969 General Electric and the government (ARPA) were the large funders and suppliers of computing (The PC market we know of today doesn't come until 1984!).

  Bell Labs was basically the *"idea shop"* of the entire country - where the best and brightest went to invent everything we take for granted today. Bell Labs was spun off by AT&T and became Lucent Technologies, which became Alcatel-Lucent and now is soon to be part of Nokia. One could argue that Google and Facebook have taken its place  where the brightest minds go to invent new things in America.  No wonder that Dennis Ritchie, Ken Thompson, Brian Kernighan and even James Gosling (creator of the Java programming language) are and were employees at Google.

  Like all projects that try to do to much, MULTICS stalled in gridlock between the different companies and the demands of the government.  This left one crafty engineers with much free time and (for those days) a true rarity - unused copmuters; PDP-7s to be exact.  Ken Thompson had an insiders view of the innovative things MULTICS was trying to accomplish and why the inner workings of the MULTICS project went wrong. Thompson also had a job to do as a Bell Labs researcher.  On his own time and down time, he began to use these PDP7's and program his own multi-user operating sysetm, but with a different twist.  It was designed by him, and solved daily work and coding problems he had.  This operating system and its tools was then a project to help him get his own work done more efficiently.   

__PDP7__

<a title="By en:User:Toresbe [CC SA 1.0 (http://creativecommons.org/licenses/sa/1.0/)], via Wikimedia Commons" href="https://commons.wikimedia.org/wiki/File%3APdp7-oslo-2005.jpeg"><img width="512" alt="Pdp7-oslo-2005" src="https://upload.wikimedia.org/wikipedia/commons/thumb/5/52/Pdp7-oslo-2005.jpeg/512px-Pdp7-oslo-2005.jpeg"/></a>

For this time, 1969-70, this is something radically new. Thompson had no idea that his pet work project was going to become part of a computing revolution.  Where as MULTICS and other computer systems were designed by committees and based on marketable features--due to the nature of the up front financial investment, Unix was simple and easy to build because it solved only a small set of problems--which turned out to be the same problems every engineer had.  The overall reason that Unix took hold was that it was designed by engineers to solve other problems that engineers were having--enabling them to get work done.  This was pure genius and this is how Ken Thompson's mind worked.  

Unix differences from existing commercial Operating Systems

  * Written by Ken Thompson on his spare time
  * No company owned it or committee designed it for commercial purposes
  * Solved problems that engineers had
  * Built by engineers
  * Had a consistent design philosophy
  * Designed to be portable and work on many hardware vendor platforms
 
 Between 1970 and 1974 Unix grew in its maturity.  And one of its crowning achienvements--its portability came to life.  Unix was originally written in assembly lanugage for the PDP-7. It needed to be as low level code as possible because disk storage space was a HUGE premium in those days.  This was good, but the problem with writting in low level assembly means that the code is optimized to only run on a PDP-7 system.  Not on a PDP-11 or a DEC Vac, or an IBM 360, etc, etc.  So what you gain in efficiency you lose in portablitiy.  What good is Unix if it could only be used on a PDP 7? It would have stayed a Bell Labs pet project.
 
 While Thompson was builing Unix his fellow engineers at Bell Labs got wind of what he was doing and asked to have access to his system, and then to be able to contribute additonal functionality.  Enter Dennis Ritchie, who championed Ken Thompson's Unix in Bell Labs.  Ritchie was a computer language creator and saw the utility of Thompson's Unix, but realized it was trapped in PDP7 assembler language.  Today we take for granted high level lanugages like C, C++, Python, and Java.  In the early 1970's these did not exist.  Ritchie's initial work was on a high level language that could be built in order to compile and run the same code on two different operating systems. His initial work was on a [language called "B"](https://en.wikipedia.org/wiki/B_(programming_language "B Lanugage") which was derived from a language called BCPL.  B was designed to execute applications and operating system specific tasks but didn't handle numeric data (a feature actually to save precious harddrive space). B was also missing many other features you would expect in modern programming languages.  
 
 What happened was that Thompson and Ritchie went to work extending "B" with all the features they would need to make an operating system fully function and portable.  They called this language surprsingly, "C" -- the same "C" lanugage you know today.  C was different from assembler in that is resembled assembler code syntx had a high enough level of abstraction that the "C" code was an independant language.  With the advent of C - Unix was rewritten in this language.  With the creation of C compilers for different hardware, Unix could now be built and be recomplied on different architectures, PDP-7, PDP-11, DEC VAX, DEC Alpha, IBM 360, SUN SPARC etc, etc.  
 
![C Programming language "Hello World!"](images/hello-c.png "C language") ![Intel x86 Assembly code of "Hello World!"](images/hello-asm.png "Assembly Language")   
 
Since Ritchie created "C" to solve all the problems Unix had -- it became the defacto lanuage of Unix and from that point on pretty much all operating systems are designed in "C" after Thompson and Rithie showed that you could use a high level lanuage to make Unix portable accross many platforms.  

__Brian Kernighan__

<a title="By Ben Lowe (https://www.flickr.com/photos/blowe/7984191331/) [CC BY 2.0 (http://creativecommons.org/licenses/by/2.0)], via Wikimedia Commons" href="https://commons.wikimedia.org/wiki/File%3ABrian_Kernighan_in_2012_at_Bell_Labs_1.jpg"><img width="256" alt="Brian Kernighan in 2012 at Bell Labs 1" src="https://upload.wikimedia.org/wikipedia/commons/thumb/a/ae/Brian_Kernighan_in_2012_at_Bell_Labs_1.jpg/256px-Brian_Kernighan_in_2012_at_Bell_Labs_1.jpg"/></a>
  
  Thompson didn't have a name for his project initally, another realted figure, Brian Kernighan, can be credited with giving it the name UNIX.  This was a play on words-- MULTI vs UNI in the name. Kernighan also helped write the original C language text book along with Dennis Ritche (called K&R C -- some of you might have used when in school).
  
__Unix Maturity__

By 1974/75 Unix is growing in its maturity.  Other Bell Labs divisions get wind of this and begin to request "tapes" for their own use.  Tapes meant giant mounted magnetic tape reels that contained all the operating system installation code.  By law AT&T was prohibited from getting into the computer business so they could not turn this into a business.  AT&T left it curriously as Thompson and Ritchie's pet project.  Many Universities at this time--wanting to teach computing and operating systems began to request copies of Unix to teach in their Operating Systems classes.  This was attractive to universities because Unix was a fully operational and working system but the main draw was that the source code was freely given away by Ken Thompson.  You sent him a letter, paid for shipping, and you got a reel within a week or so.  Thompson had no concept of "ownership" and freely shared his project with anyone who was interested.    

In 1975 Ken Thompson took a sabbatical from Bell Labs and went back to his Alma Mater, Berkly, in California.  Installing the Version 6 Unix Release.  The students at Berkley loved Unix and started adding their own features to improve it to solve their own problems.  One student in 1978, Bill Joy, added vi and the C Shell (two things still in use today in modern Linux) and started redistributing his "re-mix" of Unix called BSD (Berkely System Distrubition.)  

By 1980, with many copies of Thompson's Unix now in circulation and nearly a decade of work you start to see fragmentation of the original Unix and many universities adding on their own customizations.  Since the code was technically propriaary under AT&T's ownership - there was no way to contribute code back to the source.  Unix starts to splinter.  Another problem AT&T had was that by the end of the 70's all those students who had learned Unix in college went to work in corporations and began to request Unix be used on their hardware platforms at work. Unix was the only operating system of its type kind that could do this.  Now AT&T had a financial motive to commercialize Unix.  By 1982 AT&T released Unix System III, followed by System V in 1983, as a commerical product outside of Bell Labs for sale to commerical companies, while adding a multi-hundred dollar academic fee too.  At this time the Berkley System Distribution of Unix was beginning to vary widly in functionality from commcerial AT&T UNIX. You see derivates of Unix like SunOS and SCO Unix being released as commerical companies based of BSD Unix.  With HP/UX and IBM AIX being based on AT&T System V.  The focus of Unix takes a dramatic shift now as the implementation portion is finished.  Now the spoltlight moves to users and application creation. Enter Richard Mathhew Stallman, known also as RMS a researcher at the AI Labs at MIT who moves the discussion of software and *"software freedom"* into the spotlight.  

### Ricahrd Stallman and GNU

<a title="By Dkoukoul (Own work) [CC BY-SA 4.0 (http://creativecommons.org/licenses/by-sa/4.0)], via Wikimedia Commons" href="https://commons.wikimedia.org/wiki/File%3ARichard_Stallman_at_CommonsFest_Athens_2015_2.JPG"><img width="256" alt="Richard Stallman at CommonsFest Athens 2015 2" src="https://upload.wikimedia.org/wikipedia/commons/thumb/a/a8/Richard_Stallman_at_CommonsFest_Athens_2015_2.JPG/256px-Richard_Stallman_at_CommonsFest_Athens_2015_2.JPG"/></a>

Best short interview I ever heard with Richard Stallmand from Will Backmand of [BSDTalk](http://bsdtalk.blogspot.com/ "BSD Talk")

[Link to .ogg audio interview file](https://archive.org/download/bsdtalk132/bsdtalk132.ogg "RMS Interview")

Before beginning the history, political, and technical acheivements there is one concept you need to understand: "freedom."  Often times you hear as a selling point that Linux is a good operating system to use because it is free -- as in there is no cost.  That is not what Richard Stallman is advocating.  He doesn't believe that software makers shouldn't charge money for software -- but that the software itself is free and that the user has the freedom to modify and or inspect its content.  Ricahrd Stallman belives this is not a question of legality but of moral consequence and thereby will not use any non-free software.  When dealing with Stallman this is the fundamental fact you need to know.

Ricahrd Stallman was a student and a researcher at MIT in the early 1980's.  He was part of what you would call today a hacker culture that was constantly researching and developling new tools and applications.  As Richard Stallman progressed in his time at MIT he began to encounter things that he saw as hindering his freedom.  Small things such as the addition of usernames and passwords on the school computer networks. He saw the removal of the capability to modify a network printer's firmware to send an email feature in case of a paper jam.  By 1984 AT&T began to withhold the source code of Unix and restric those in the academic world's ability to redistribute the AT&T source code. Stallman argued that the users of the software were not free and that they were now beholden to the closed nature of the prodcuts they were using--even if they had paid for the software.  He realized that users of computers were not "free" and set about to rectifiy this issue.

__GNU Manifesto__

  A plan began to hatch in his mind.  Since Unix was the popular operating system at the time Stallman would make a call, a manifesto, for his GNU project to basically reverse engineer all the funcitonality, capability, and tooling of Unix--__BUT__ without the propriatary and restricitve licenses and share this source code freely.  

  He felt strongly enough to announce the GNU project publicly in th fall of 1983, and to quit his job working in the MIT lab in 1984 to avoid conflict of interests and persue this work.  Richard wrote his GNU manifesto stating his plans in Oct 3rd, 1985 and issuing a general call to arms in the [GNU Manifesto.](http://www.gnu.org/gnu/manifesto.html "GNU Manifesto") GNU is a recursive acronym meaning *"GNU's not Unix."*  Stallman wanted to let people know his project was Unix like in fucntionality but not goverened by Unix's restricitve licensing.  His passion was to develop a fully free operating system so that everyone who could use a computer could have access to a *"free"* operating system.  Stallman is a brilliant man who had the capability to build an OS from scratch, but the project became more than a one man job.

__Free Software Foundation and GPL__

 In late 1985 the [FSF](http://www.fsf.org/ "FSF") -- Free Software Foundation was formed to be the holder of all the intellectual property of the GNU project. By 1989 a new role for the FSF arose. Commercial entities were starting to take notice and corrupt the idea of free software and the FSF needed a way to protect their software freedoms.  But how?  Copyright was restrictive and would make the FSF no different from the commercial entities that restrict freedom.  Public Domain offered no legally enforceable protections.   So enter Copyleft--which is a hack on the term copyright in the form of the [GPL - GNU Public License.](https://en.wikipedia.org/wiki/GNU_General_Public_License "GPL")  It flips copyright over by basically saying, you need to frrely distribute the source code of any project lisenced under GPL, you need to attribute where your source came from, and that you cannot restrict any of these rights to any future derivative work.  Meaning that you cannot close source some open source code that is GPL'd.  This is different from the *"permissive open source licenses"* BSD, MIT, and Apache licenses which can have derivative works closed source.

__GNU HURD__

  All seemed to be going well. RMS started this work of creating a free Unix-like operating system.  The first tool build was a C complier that was needed so that the code could be recomplied to different hardware.  The Unix C complier, a commandline tool called  "cc" was reverse engineered first.  GNU's version adds a "g" to all the reverse engineered applications so you know it is the "free" version. The tool "cc" became "gcc."  Various [other GNU tools](http://www.gnu.org/manual/blurbs.html) were added by contributers and volunteers.  They did remarkably well and had reverse engineered all the components of Unix by 1991 (8 years of work). They built everything except 1 critial piece...  they didn't have a kernel for their operating system.  Turns out that writing a kernel is much harder than it looks.  
 
  A project was started called [GNU Hurd](http://www.gnu.org/software/hurd/ "GNU Hurd") to be the kernel for the GNU operating system in 1985.  Hurd made some false starts in its initial development phase causing multiple versions to be scrapped.  In retrospect HURD was never finished.  GNU HURD is currently in a usable alpha stage [and downloadable today.](http://www.gnu.org/software/hurd/ "GNU HURD Download") The GNU project has all but stopped active development and promotion of GNU HURD as the kernel for its free operating system.  Instead it uses and recommends the Linux kernel instead.  The FSF uses the term GNU/Linux to show the combination of GNU tools with Linux kernel is the realization of the free operating system that Stallman had in the GNU manifesto back in 1985.  Where did the Linux kernel come from?
  
### - Linus Torvalds and Linux

<a title="By Krd (Own work) [CC BY-SA 3.0 (http://creativecommons.org/licenses/by-sa/3.0) or CC BY-SA 4.0 (http://creativecommons.org/licenses/by-sa/4.0)], via Wikimedia Commons" href="https://commons.wikimedia.org/wiki/File%3ALinuxCon_Europe_Linus_Torvalds_03.jpg"><img width="256" alt="LinuxCon Europe Linus Torvalds 03" src="https://upload.wikimedia.org/wikipedia/commons/thumb/5/52/LinuxCon_Europe_Linus_Torvalds_03.jpg/256px-LinuxCon_Europe_Linus_Torvalds_03.jpg"/></a>

__Minix__

  With the closing off of the AT&T Unix source code by 1984 to academics and researchers in the university - they were left without source to show as examples.  One professor Andrew S. Tanenbaum teaching at  Vrije Universiteit in Amsterdam - began to write and implement his own Unix just for education purposes.  It was 12,000 linees of code and system call compatible with commerical Unix.  Minix name was a combination of miniature and Unix.  Minix 1.0-1.5 were released from 1987-1991 originally as a teaching tool.  Minix 1.0-1.5 was freely avaialable to anyone as the source code came as the appendix to a text book about operating systems written by Tanenbaum written in 1987.  Minix was designed to run on x86 Intel processors and Sun Sparc processors which most students had access to PCs and Sun SparcStations at University and even home.   

__Linux__

  Linux itself gets its start at the University of Helsinki with a graduate student named Linus Torvalds in 1991.  Linus was using Unix at the university running SunOS on Sun Sparc Stations.  Linus wanted to have access to Unix on his own PC - at that time in 1991 he owned an Intel 386 PC.  He was displeased with Minix and its shortcomings as a useful production UNix-like system.  In a fashion not unlike Ken Thompson, Linus set about to create his own Kernel that ran on his own computer, that was Unix like but wasn't Minix.  From scratch over mutliple months he worked until he had built his own kernel from scratch.     

  This was very impressive for a single person.  Linus's brilliance comes not from ingenuety but comes from good engineering pricipals of knowing when not to go down dead-end developenent trails.
  
  But Linus had a problem. He had a kernel, but he had no User Interface tools and no operating system applications tools or compilers.  But Richard Stallman and the GNU project had all of that.  And now you can see the connection.  After publically announcing his Linux code and project on Usenet (Bulletin board like precursor to the actual Internet - like Google Groups -- today you would use twitter) people began downloading and compiling his kernel, adding GNU tools, and making fully capable UNix-like operating systems jsut as RMS had dreamed.
  
  To make matters even easier Linus Torvalds has ssen Richard Stallman speak 1 few years prior and decided to open source his Linux Kernel by licensing it under the GPLv2 license.
  
  Linux Kernel unique attributes
  
  * Developed to solve one person's problem of wanting his own Unix liek OS 
  * Released freely
  * Accpeted contributions back
  * Protected by GPL license
  * Used existing GNU tools - no need to reinvent the wheel
  
  __Personality__
  
  http://www.wired.com/2013/07/linus-torvalds-right-to-offend/
  http://arstechnica.com/business/2015/01/linus-torvalds-on-why-he-isnt-nice-i-dont-care-about-you/
  Linus response to previous article http://arstechnica.com/business/2015/01/linus-torvalds-responds-to-ars-about-diversity-niceness-in-open-source/
  
  

__AT&T and BSD Lawsuit__

  1991 BSD Unix distribution going well - adding many addiitonal features that standard Unix did not have - but they were not paying any licensing to AT&T.  BUt AT&T has teh UNix copyright and some AT&T original course code was still contained in BSD.
  
  Court issued an injucntion in 1992 - seeing as Linux 0.01 was released in August of 1991 - this was the perfect time - now all the development focus left BSD and went to the unencumbered GPL's Linux.  By the time the lawsuit was finished in late 1993/1994 it was too late.  The Linux rocket had left the launch pad and was never coming back.

### - Rise of OpenSource

__Free Software vs. Open Source Software__

This kind of licensing gave the free software movement the legal ability to hold people accountable and made free software viable for commercial use.  But the term *"free"* has an overriding misunderstanding of being about cost.  Many commercial entities were simply not interested because they were concerned about loosing the chance to make money.  

__Eric S. Raymond__

<a title="By Erc_S_Raymond_and_company.jpg: jerone2 derivative work: Bilby (Erc_S_Raymond_and_company.jpg) [CC BY-SA 2.0 (http://creativecommons.org/licenses/by-sa/2.0)], via Wikimedia Commons" href="https://commons.wikimedia.org/wiki/File%3AEric_S_Raymond_portrait.jpg"><img width="256" alt="Eric S Raymond portrait" src="https://upload.wikimedia.org/wikipedia/commons/thumb/e/e2/Eric_S_Raymond_portrait.jpg/256px-Eric_S_Raymond_portrait.jpg"/></a>

Eric S. Raymond is another developer considered a peer along with Ricahrd Stallman.  Eric was one of the first to embrace the Free Software idea and promote using free software.  His book, "The Cathedral and the Bazaar"   This book was influential in helping the Netscape Corporation opensource their Netscape Web Browser code as the company went bankrupt under the name of the Mozilla project.  Raymond helped to found the Open Source Initiative in 1998 for the promotion of free software.  Where Raymond and Stallman differ is that the OSI sees closed source software as deficient and open development as a superior model.  Stallman and the FSF sees closed source and restrictive licesnses as a moral deficiency.  The OSI was willingto make compromises in order to make larger productivity gains.  The FSF will not compromise.  The terms do overlap Free Software and Open Source but ultiamtely have two divergent meanings.   There has been some compromise in the naming [FLOSS] (https://en.wikipedia.org/wiki/Free_software_movement "FLOSS"), Free and Libre Open Source Software -- but the FSF rejects any licensing that allows a user to restrict the use of "Free" Code.  For example, the OSI would have no problem using Microsoft Powerpoint to make an advertisement slide deck for the benefits of adopting Open Source.  At the fundamental level, the FSF could never use Microsoft Powerpoint in the first place because it is not free software--there by forefitting the advertising chance in order to maintain principal.

Eric Raymond has written many influential books and also contributed to libgif and libpng libraries for rendering images on computers and web browsers.

  * [The Art of Unix Usability](http://www.catb.org/~esr/writings/taouu/html/ "Book link")
  * [The Cathedral and the Bazaar](http://www.catb.org/~esr/writings/cathedral-bazaar/ "CatB")

His most famous quote is this one and can you tell that he doesn't get along with Stallman?

*As head of the Open Source Initiative, he argued that advocates should focus on the potential for better products. The "very seductive" moral and ethical rhetoric of Richard Stallman and the Free Software Foundation fails, he said, "not because his principles are wrong, but because that kind of language ... simply does not persuade anybody".* 
[Eric S. Raymond](https://en.wikipedia.org/wiki/Eric_S._Raymond#Open_source "Quote")

### - The rise of commercial Linux

  * Red Hat


### - Impending Linux Civil War

* cover breifly here and then again later in the end of the book
* SysVInit vs systemd 
* Lennart Poetering
* Red Hat's grab for Linux?
* Can Linux survive as an opensource project?


### - Licensing

  * Not patents but Licensing
  

## - Chapter Conclusion and Summary

### - Review Questions



### - Podcast Review Questions

### - Review Lab

Watch Revolution OS - https://www.youtube.com/watch?v=jw8K460vx1c

Get into groups and answer/discuss these questions

