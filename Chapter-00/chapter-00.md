## Chapter 0 - Introduction
![*I think Linux is a great thing, in the big picture. It's a great hacker's tool, and it has a lot of potential to become something more.* Jamie Zawinski](http://imgs.xkcd.com/comics/cautionary.png "Parents - tell your children... ")

### 0.1 - Objectives of this book

Why undertake another Linux book?  Isn't the world filed with enough documents and books?  On one hand you are correect there are many books in print and available.  Linux/Unix has a unique place in computing.  Entering now it's 4th decade of existance I believe we are facing a new dawn of the use of Linux.  Devices such as Android proliferating [1](http://www.cnet.com/news/android-dominates-81-percent-of-world-smartphone-market/) and companies such as RedHat being a billion dollar company [2](http://arstechnica.com/business/2012/02/how-red-hat-killed-its-core-productand-became-a-billion-dollar-business/).  Linux battles with its heritage of stemming from the Free Software movement of RMS and the OpenSource modern mission os the OSI.  Stallman himself wrote a compelling article entitled ["Why Open Source misses the point of Free Software"](http://www.gnu.org/philosophy/open-source-misses-the-point.html).  

On the other hand you have the Debian [*"Civil War"*](https://devuan.org/) in regards to [systemd](http://www.freedesktop.org/wiki/Software/systemd/) and its integration--some would say take over of Linux.  Are the Devuan developers who split from Debian just nostalgists harkoning for the halcyon days of early 2000's Linux wild west days?  Or do they have legitimte concerns (technical and ethical) about the direction of Linux?   

 It is in this background that this book is being generated.  There have been many fine books I have used over the years and have greatly benefitted from. Most of these books the content 80% is still valid-- vi is still vi right?  Only the desktop and package manangement has changed.  But the nature of development has changed.  Both [https://getfedora.org/](Fedora) and [http://ubuntu.com](Ubuntu) are on a six-month release cycle--making teaching about Linux features more difficult in a traditional book format.  Also there are many quality distributions out there that we cannot cover them all.  A community effort is being constructed here so that anyone who can contribute material can do so freely via pull request or a fork with attribution.  

Seeing as this book focuses more on system administration we will focus mostly on "server" editions of Linux, such as RHEL, CENTOS, UBUNTU SERVER, FEDORA ATOM, and FREEBSD (yes I know it is not Linux...) for comparison.  Since this book is being geared for use as a textbook, I wanted to include more than just exercises but background and context to the technologies being used.  I have included links to podcasts that I believe will be helpful in illuminating the background for the readers. 

The main focus is following the [LPIC-2 exams specifications](https://www.lpi.org/certification/get-certified-lpi/lpic-2-linux-network-professional/) plus additions owing to the nature of how technology is moving.  These chapter lists were compiled based on their exam objectives from 2013 plus updates in the area I personally believe are valuable to studetns based on industry experience I have gathered.

#### 0.1.1 - Objectives

At the end of this book students/readers should be able to:

  * Administer a small to medium-sized site 
  * Plan, implement, maintain, keep consistent, secure, and troubleshoot a small mixed (MS, Linux) network, including a: 
  * LAN server (Samba, NFS, DNS, DHCP, client management)
  * Internet Gateway (firewall, VPN, SSH, web cache/proxy, mail)
  * Internet Server (web server and reverse proxy, FTP server)
  * Supervise assistants
  * Advise management on automation and purchases
  * Guidelines from [LPI II](https://www.lpi.org/certification/get-certified-lpi/lpic-2-linux-network-professional/) 
  * Add more as seen fit....
  
### 0.2 - Who should read it?

You should.  Any student or reader who has basic knowledge of Linux as an Operating System and its tools who is now looking to move into applciation and operation of multiple Linux systems and services. Or update your skills.

### 0.3 - Who are we?

My name is Inigo Montoya...

### 0.4 - How this book/project works 

The book contains Chapters which have overarching goals and objectives, followed by an introduction, followed then by lecture material and references with examples followed by review questions and labs.  The review questions will be provided as Blackboard Quizes for autograding too.  All of this will be avalialbe on Github at the books URL [https://github.com/jhajek/Linux-text-book-part-2](https://github.com/jhajek/Linux-text-book-part-2).

The text is available on line - and can be generated into 5 different formats via [Pandoc](http://pandoc.org/)

* docx
* pdf
* odt
* epub
* html   

Information is in the [README.md](https://github.com/jhajek/Linux-text-book-part-2/blob/master/README.md) https://github.com/jhajek/Linux-text-book-part-2/blob/master/README.md contained in this project

Also plans to have hard boudn editions for sale at Lulu (microprinter)  that is in the works.

### 0.5 - Acknowledgements

Many people have helped me in the journey of learning technology -- more to fill out as I get closer to making this a reality.

I would like to that xkcd for the insightful linux cartoons

Professor Sam Shamsuddin who taught me its not ee-tee-cee ef-es-tab but really ee-tee-cee ef-stab.

### 0.6 - Linux/Unix History and Philosophy (pulled from other book)

[See first book](https://github.com/jhajek/Linux-text-book-part-1)

### 0.7 - Environment setup for this book

This book assumes that you have access to a server edition of Linux.  I will be referencing instances using the VirtualBox Platform, but all of this work can be done on Hyper-V, VmWare, Parallels, or any other vm software you have, as well as AWS, Azure, Digital Ocean, Rackspace, and any other cloud service you can find (charges may apply)  Finally if you have an old PC laying around you can install these operating systems natively and all these exercises will work well.  

### 0.8 - Resources for you beyond this book  

  There are many resources out there on the internet.  You should go beyond what just your teacher tells you or expect that they will be like Master Yoda and just dump all knowledge into you.  Though a professor or a mentor is a great place to start, you need to do some work finding communities and resources on the Internet you can use to put yourself ahead of the competition.  Here is a short list that helped me greatly and are considered industry wide tools and communities you can participate in at any level.
  
  #### [Twit.tv](http://www.twit.tv) 

This is more than one site it's really the evolution of Television if you think about it.  

The site has a television like quality but all the shows are freely avaliable with archives.

+    [http://twit.tv/show/security-now](Security Now!)
+    [http://twit.tv/show/floss-weekly](FLOSS Weekly) 
+    [http://twit.tv/show/tri](Triangulation) 
  
  #### Stackoverlfow / Stackexchange

+    [http://stackoverflow.com](Stackoverflow)
+    [http://serverfault.com](Serverfault)
+    [http://superuser.com](SuperUser)
+    [http://askubuntu.com](Ask Ubuntu)
+    [https://ask.fedoraproject.org/en/questions/](Ask Feodra) -> Not a stackexchange site but a copy serving the same purpose

  #### [meetup.com](http://www.meetup.com) 
   
   Great way to find meetups in your local area. Usually sponsored at a corporate headquarters and a great way to meet people who are in the industry talking about things important to those that are hiring.  Great for students and others looking to learn beyond the class and make connections.

#### Good old mailing lists

  Find your favorite opensource project and join their mailing list.  You can learn alot just by being a reader.
   
  #### More to come

### 0.9 - Conclusion

You are ready to begin.  Hit Enter to Continue...

- - - 