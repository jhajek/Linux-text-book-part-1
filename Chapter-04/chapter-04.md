# Desktop Linux and GUIs
![*GUIs??? NIH*](http://imgs.xkcd.com/comics/supported_features.png "GUIs NIH")

__Chapter 4 Objectives__

  In this chapter you will:
  
  *  Learn about the different types of desktop Linux
  *  Understand the nature and use of X, Mir, Wayland, and other GUI compositors
  *  Understand the purpose of window mangers and the nature of desktop environments
  *  Know the major features of GNOME 3 and Unity desktop environments
  *  Understand GUI package managers
  *  Understate the nature of Symlinks and file types <-- __probably need to move this somewhere__

__Outcomes__

  At the conclusion of this chapter you will have a strong knowledge of the X Windows system and why it is the foundation of Desktop Linux.  You will be able to implement various window managers and desktop envrionemnts, selecting the proper environement to utilize and suit your hardware needs.  You will be comfortable using and recoginizing the features of GNOME 3 and Unity desktop environments.  

## From Paper Tape to CLI to GUIs to 4K

  When you think about how we use computers today the one thing we take for granted is a *GUI*, __Graphical User Interface__.  The GUI is intracatly tied to the way computers are used, why do think Microsfot calls its operating system Windows? Unix however, had its start in the late 1960s and 1970s--there was vastly different technology available at that time.  The PDP7s that Thompson and Ritchie used were called [*Teletypes*](https://en.wikipedia.org/wiki/Teleprinter "TTYs") or *TTYs* that had punch card readers for data entry and paper tape for output all conencted to the PDP7 via a modem. You will notice that even today in Unix screen outputs are still refered to as TTYs. By the mid 1970s we begin to see what are called *dumb terminals* appear which could be considered primitave monitors. 
  
  The [Datapoint 3300](https://en.wikipedia.org/wiki/Datapoint_3300 "Datapoint 3300") was one of the more common models reprsenting the era.  It supported control codes to move the cursor up, down, left and right, to the top left of the screen, or to the start of the bottom line and dispalyed a whopping 72 by 25 rows of charaters in the days before microprocessors and ram were part of terminals. By 1978 Digital Equipment Corporation (DEC) had released something akin to an upgrade for the dumb terminal called a *smart terminal*.  
  
  The [DEC VT-100](https://en.wikipedia.org/wiki/VT100 "VT-100") was the most popular model: it had character and cursor positioning and was connected to the Unix system via serial ports and a modem.  The VT-100 set the standard for 80 by 24 rows and columns still in use today.  These terminals had the backing of DRAM and an Intel 8080 processor.  Open up any terminal emulator in linux and see its default size.  Open up Command line in Windows and you will notice the same default dimensions.  Why?  The environemnt you grow up in has a lasting influence on you.  All the developers who built Terminal emulators and Command Line for Windows "grew up" using Unix systems on a DEC VT-100 screen.  It was a natural fit.  The VT-100 and VT-220 continued with wide deployment and sucess but the concept of color or being able to draw any shapes to the screen was in the hands of a few expensive and propriatary companies; everything was still [ASCII](https://en.wikipedia.org/wiki/ASCII "ASCII") or character based.  
 
 __VT-100__ [^25]
 
 ![*VT-100*](https://upload.wikimedia.org/wikipedia/commons/thumb/9/99/DEC_VT100_terminal.jpg/270px-DEC_VT100_terminal.jpg "VT-100") 
  
  This screenshot is a file listing from the ```/dev``` (devices) folder on a Fedora 22 system
  
![*TTY Alive Today*](images/Chapter-04/tty.png "TTYs")
  
![*Windows cmd.exe earily similar to the VT-100*](images/Chapter-04/cmd-399-by-200.png "cmd.exe")
 
![*Ubuntu's GNOME Terminal emulates the VT-100 directly*](images/Chapter-04/linux-terminal-299-by-200.png "Linux Terminal")

### Virtual Consoles?
  
  With the X system the idea of having discrete terminals went away.  Now you could have multiple *virtual terminals* on one system that emulated the features of a DEC VT-100 or VT-220 terminal.  IF you hit the  ```ctrl + alt + F1-F7``` within your Linux distro you will jump to 1 of 7 different virtual terminals enabled by default.  Usually F7 is the default GUI but it can vary from operating system to operating system.
   
## Along Comes an X
 
   Beyond the simple green screen terminals by the mid 1980s we began to see propriatery primative UNIX GUIs from commercial vendors, especially from Sun. These GUI interfaces were placed on highend workstations sold at premium prices for the day. One may wonder why you would even bother to great a GUI in the first place. Computing at that time was begining to take less of an iterative/batch processing approach to computing and a more of an interactive approach. GUIs were in the hand of the privilelged few vendors but not of anyone else.  By 1985 MIT opensourced a project called X.  This project was after Richard Stallman had left the school but continued in his spirit.  X was a continuation of a primiative GUI called "*W*". As Unix originally had no concept of a GUI one had to be bolted on.  But the spirit of X was not to enforce any standards on the user.  
      
   X uses a client–server model: an X server communicates with various client programs. The server accepts requests for graphical output (windows) and sends back user input (from keyboard, mouse, or touchscreen). The server may function as:
  
  * an application displaying to a window of another display system
  * a system program controlling the video output of a PC
  * a dedicated piece of hardware.

__X__ [^25]
   
![*X Diagram*](https://upload.wikimedia.org/wikipedia/commons/thumb/0/03/X_client_server_example.svg/200px-X_client_server_example.svg.png) 

   Even in the mid 1980s the dream of having your own desktop PC was a bit of a ways off.  Large single Unix systems were still the nature of computing so the X system fit in, especially in the idea of remote terminals or underpowered system connecting remotely to a central server and running their own *X Window* remotely. X is often misnamed as X Windows, but the name for the project is *"X"*. 

 > *"...in 1987-1988 X established itself as the standard graphics engine for Unix machines, a hardware-independent neutral platform on top of which to build GUIs"* [Eric S. Raymond writings](http://www.catb.org/~esr/writings/taouu/html/ch02s06.html "Early history of Unix"). 
   
 > "X provides the basic framework for a GUI environment: drawing and moving windows on the display device and interacting with a mouse and keyboard. X does not mandate the user interface — this is handled by individual programs."*  [https://en.wikipedia.org/wiki/X_Window_System](https://en.wikipedia.org/wiki/X_Window_System "X Windows")
   
   By 1987 version 11 had been released of the protocol, being commonly referred to as X11.  The industry wanted ot prevent fragmentation and they asked MIT to form a steering consortium for the project.  MIT X Consortium became the X Consortium Inc in 1993.  By 1996 the X Consortium, with vendor input, released one of the first standard Unix GUIs called the __CDE__ *Common Desktop Environment*. By 1997 the X Consortium trasnformed into the Open Group.  The Open Group angered many people by relicensing the project under stricter commercial terms in an effort to make some money to support the project--but this action backfired amongst the community.  By 1999 the Open Group has ceased functioning and ceased really developing X. The Open Group created *X.Org* to maintain the X11 standard.   
   
   At the same time a parallel implementation base on X11R5 was being developed by IBM for their PCs.  The project was started created in 1992 as XFree86.  This code was donated to the X Consortium and the code had been part of the larger code base that the X Consortium managed.  So While the X Consortium, Open Group, X.Org was in charge of X development, they actually weren't innovating or developing anything.  It was the group at XFree86 that was doing all the innovation.
   
   THe story gets more complicated.  As the userbase of Linux surges in the early 2000s as desktop Linux and GUIs grow, X use would naturally follow that growth curve as well.  You have two problems: X.Org, a vendor controlled stewardship organization, was not doing any development on X, and XFree86 was starting to narrow its *openness* just like the OpenGroup did in 1997, expelling some of the original X creators who had joined the XFree86 project and changing open licesnses to not be GPL compliant. 
   
   This lead to the founding of the X.Org Foundation.  This was a break though event.  It bsasically reconciled the two groups under one new foundation, [X.Org Foundation](http://x.org "X.Org Foundation"), it also ensured the the creators of the X project were once again the stewards, and finally it insured that there was a GPL based and protected X project that developers and companies could contribute to as well.  X.Org Foundation continues to innovate and foster the project to this day.  
    
   A final GUI note that in parallel the most break through commercial GUI availalbe in the early 80s was released by Apple in 1984. 
   
__Apple MacIntosh__ [^23]
  
![*Apple Macintosh 1984*](https://upload.wikimedia.org/wikipedia/commons/thumb/e/e3/Macintosh_128k_transparency.png/205px-Macintosh_128k_transparency.png "Apple Macintosh") 
  
   X has a definate advantage in that it is very mature and very stable for better or worse.  In the diagram earlier in the chapter you can see one of X's major faults.  It was designed not with a desktop GUI in mind, those didn't exist at the time. Every desktop element is a client that has to make calls to the X server in order to render any changes to the screen.  This adds extra layers of overhead and also becomes a [security issue](http://www.windowsecurity.com/whitepapers/unix_security/Securing_X_Windows.html#3.0 "Security Issues") with an X client being able to connect unauthenticated in somecases to other X servers.
      
### Project Wayland
  
  In the late part of the 2000s, then Red Hat engineer Kristian Høgsberg, began to reimagine the nature of the Linux GUI compositor with a simpler desktop driven protocol.  With the help of other senior X.Org developers they began to create a succsor proejct to the X project.  By 2012 they had their first code release usable for beta testing. This project was called [Wayland](http://wayland.freedesktop.org "Wayland").  The famous architect of the City of Chicago Daniel Burnham once said, *"Make no little plans. They have no magic to stir men's blood and probably will not themselves be realized."*  Every single desktop environment and window manager runs on X--this means rewritting or extending every single graphical toolkit and graphical developemnt environemnt out there. The Wayland project had that just in mind. What is Wayland then?  
 
   > *"Wayland is a protocol for a compositor to talk to its clients as well as a C library implementation of that protocol. The compositor can be a standalone display server running on Linux kernel modesetting and evdev input devices, an X application, or a wayland client itself. The clients can be traditional applications, X servers (rootless or fullscreen) or other display servers."* [Wayland Project](http://wayland.freedesktop.org/ "Wayland Project")
  
  ![*Wayland Rendering Model*](images/Chapter-04/wayland-architecture.png "Wayland Architecture")
  
  * The kernel gets an event and sends it to the compositor. This is similar to the X case, which is great, since we get to reuse all the input drivers in the kernel. 
  * The compositor looks through its scenegraph to determine which window should receive the event. The scenegraph corresponds to what's on screen and the compositor understands the transformations that it may have applied to the elements in the scenegraph. Thus, the compositor can pick the right window and transform the screen coordinates to window local coordinates, by applying the inverse transformations. The types of transformation that can be applied to a window is only restricted to what the compositor can do, as long as it can compute the inverse transformation for the input events. 
  * As in the X case, when the client receives the event, it updates the UI in response. But in the wayland case, the rendering happens in the client, and the client just sends a request to the compositor to indicate the region that was updated. 
  * The compositor collects damage requests from its clients and then recomposites the screen. The compositor can then directly issue an ioctl to schedule a pageflip with KMS. 
  
  X is too deep into the bones of Linux and may never be ever fully replaced. The short term is to implement something called XWayland. Instead the Wayland project implemented X into Wayland.  Fedora 22 has a beta version of X-wayland running Fedora 22 - which will render Walyand and X at the same time.  
  
![*X on Wayland*](images/Chapter-04/x-on-wayland.png "X on Wayland")
  
### Ubuntu Mir     
  
  Not to be outdone Ubuntu saw an opportunity to come up with an X repalcement and announced the Mir project in early 2013.  Unfortuantely this has met with serious opposition from the X and Wayland communities seeing this as an outside effort to *"corner the market"*, even to the point in 2013 of Intel, who supports Wayland, [rejecting XMir support](http://arstechnica.com/information-technology/2013/09/intel-rejection-of-ubuntus-mir-patch-forces-canonical-to-go-own-way/ "Intel Rejects XMir") in it's Linux opensource graphic driver package. Unfortuantely Ubuntu is the only Linux operating system to support Mir and development has been delayed as the project has taken on the monumental task of replacing X.  Ubuntu was critcized for not joining the Wayland group's work but I think that may have been somewhat without warrent.  Ubuntu has a business use case--they are looking to make a compositor that could adapt based on form factor, something not unlike how Android works.  This would enable them to make Ubuntu for tablets, phones, TVs, even smaller devices electronic devices.  Mir would be custimoizable to Ubuntu's hardware dreams and they could sell hardware and perhaps make some money.  Will this strategy work? We will have to wait and see.
  
 > *"In March 2014, Mark Shuttleworth confirmed that Mir development had been delayed and that it was now forecast to be default for desktop use in Ubuntu 16.04 LTS, expected to be released in April 2016."* [^27]
  
## Window Managers

 X will let you display a window and let you capture mouse and keyboard commands.  But what if you want to render multiple windows on one machine and manage their state as well (open and close them?) How about arranging them?  Do you need them tiled or overlapping? Then you need a window manger to sit on top of X and handle that rendering.  Thankfully window managers are essentially common in Desktop Linux and almost inseperable from X in this case. Window Managers are not the full GUIs you might be used to. They are one step below a full blown desktop environemnt but window managers are very fast because they render simple windows and simple sets of icons.  Their job is to render content inside of particiular windows and manage that window's state. Since Linux and X were developed independant of a central product, you will see a depth and breadth of different window managers serving different functions and features.  Some are very simple, some serve direct purposes, some are tied to full blown desktop environments.  Window Managers can be changed and swapped as needed because they are not a central part of the operating system.  As opposed to Windows and Mac where all you can do is change themes, you can't change window managers.  Some of the minimalistic window managers can be used to help older laptops and PCs remain useful and very usable with modern Linux, where modern commercial operating systems like the Mac for instance intentionally depricate older hardware. You can break window managers into 5 ctegories based on their window behavior.

### Compositing 

* [Compiz](http://www.compiz.org/ "Compiz") - Fusion Adds more functionality to Compiz with more plugins, tools and libraries 
* Compiz - Allows for OpenGL use in windows and compositing 
* [Metacity](https://blogs.gnome.org/metacity/ "metacity") - Small window manager, using GTK+ 2 to do everything 

### Stacking 

*  [Blackbox](http://blackboxwm.sourceforge.net/ "Blackbox Wiki") - Similar to the NeXT interface and Window Maker 
*  [Fluxbox](http://fluxbox.org/ "Fluxbox") - Highly configurable and low resource 
*  [FVWM](http://www.fvwm.org/ "FVWM") - Minimize memory consumption, provide a 3D look to windows, and a virtual desktop 
*  [Enlightenment](https://www.enlightenment.org/ "Enlightenment") - Focuses on pushing the limits of existing technologies 
*  [Openbox](http://openbox.org/wiki/Main_Page "Openbox") - Standards compliant, fast, light-weight, extensible window manager 
*  [Sawfish](http://sawfish.tuxfamily.org/ "Sawfish") - Extensible window manager using an Emacs Lisp-like scripting language 

### Minimalistic 

*  [IceWM](http://www.icewm.org/ "ICEWM") - Win95-OS/2-Motif-like window manager 
*  [Afterstep](http://afterstep.org/ "Afterstep") - NEXTSTEP look and feel 
*  [Window Maker](http://windowmaker.org/ "wmaker") - NeXTSTEP-like window manager  
*  [Pekwm](https://www.pekwm.org/projects/pekwm/ "Pekwm") - Originally based on the aewm++ window manager 

### Tiling 

*  [Xmonad](http://xmonad.org/ "Xmonad") - Minimalist, tiling window manager written in Haskell 
*  [Ratpoison](http://www.nongnu.org/ratpoison/shot2.png "Ratpoison") - Keyboard-only window manager 
*  [StumpWM](https://stumpwm.github.io/ "Stumpwm") - Common Lisp window manager and Keyboard-only
*  [dwm](http://dwm.suckless.org/ "dwm") - Dynamic window manager 
*  [i3](http://i3wm.org/ "i3") - Good documentation, reasonable defaults, and good multi-monitor support.

### Other 

*  [evilwm](http://www.6809.org.uk/evilwm/ "evilwm") - Maximises screen real estate and provides good keyboard control 
*  [KWin](https://en.wikipedia.org/wiki/KWin "KWin") - Window Manager for the KDE Desktop Environment
*  [Mutter](https://en.wikipedia.org/wiki/Mutter_%28software%29 "Mutter") - Window Manager for the GNOME Desktop Environment

## Desktop Environments
  
   About the time that the OSI movement was launching in late 1990s a growing need for more than just window managers was growing too.  Modern processors at that time were gaining in processing power and multimedia extensions began to appear by [1997, called collectively MMX](https://en.wikipedia.org/wiki/MMX_(instruction_set) "MMX"). What is the difference between a desktop environment and window managers? Simple things that you may take for granted such as as a clock, or a text editor, office suite or an email client, even a web browser.  Also a desktop environment provides an IPC method for inter-window communication.  Most important, a desktop enviroment includes a file manager application, a start or action menu feature and a login manager (display manager) such as GDM, KDM, or SDDM [^32].  On top of that all the elements of the desktop have a changable but consistent usage pattern and look-and-feel.  Let us look at the history of the two main desktop environments.
  
### KDE [^33]
 
The KDE project (originally the K Desktop Environment) was the first open Linux desktop environment.  Started by Matthias Ettrich at the university of Tübingen in Germany in 1996. The first release of the __K Desktop Environment__ was in 1998 and the name was a *"clever hack"* of the CDE--Common Desktop Environment--developed for Unix by Sun, HP, and IBM. KDE focused on the lack of perceived usablity in Linux window managers.  You and I may take desktop environments for granted based on our experience with Mac and Windows respectively. Unix and Linux in 1998, did not have these capabilities--just a mix of window mangers and independant applictions.  At the time of development there were only a few toolkits available that could be used for created desktop environments.  One of them was [Qt](https://www.qt.io/ "Qt"), pronounced *cute-ee*, developed initially by a company called Trolltech. In 1998 Qt was not available under a complete opensource license but had modified license stating that non-commercial software projects for Unix were allowable. Qt was a good choice for developers because it had C++ language bindings as opposed to C only. Matthias Ettrich chose the best technology at the time for developing GUIs. By 2000 Trolltech relicensed Qt to be GPL compliant.  But this still upset Richard Stallman [^33] who never forgave KDE for initially using a non-GPL compatible license. As an aside Nokia bought Trolltech in 2008 but Qt remained under GPL license.[^34]

KDE is unique because allthough it is vendor backed, it is a GPL project so it is not tied directly to the vendor.  It is also not tied to a single Linux distro, with distros such as openSUSE, Mageia, Kubuntu and even PC-BSD using KDE by default. Qt recently split itself during the 5.0 release from one entire library into three seperate sub-components.  The 3 library parts are called colectively [Plasma](https://www.kde.org/workspaces/plasmadesktop/ "Plasma").  

### GNOME [^33]

  Shortly after the initial release of KDE and its licensing confusion, an enterprising opensource advocate saw the need for a truly open and free desktop environment.  His name was [Miguel De Icaza](https://en.wikipedia.org/wiki/Miguel_de_Icaza "Miguel") 

__Miguel de Icaza__ [^28]

![*Miguel de Icaza*](https://upload.wikimedia.org/wikipedia/commons/thumb/1/1a/Miguel_de_Icaza.jpg/351px-Miguel_de_Icaza.jpg "Miguel de Icaza")
  
GNOME initially stood for GNU Network Object Model Environment but the accronym is no longer used.  GNOME was a GNU project directly created under the GPL.  The first major GNOME release was done by Miguel in March of 1999. This project used the [*GTK+*](http://www.gtk.org/ "GTK+"), commonly mistaken as the *Gnome Took Kit*, actually stands for the GIMP Tool Kit as opposed to Qt.  [GIMP](https://en.wikipedia.org/wiki/GIMP "GIMP") is the GNU Image Manipulation Program similar to Photoshop or Paint.Net in feature set.  GTK or now known as GTK+ are useful for creating standalone applications with multiple development language bindings as well.  

In an intersting development Miguel ended up forming the company that became Xamarin, a cross development mobile platform company using c# to develop for Android and iOS--shortly after Microsoft began opensourcing the C# language.  Miguel has always been a software pragmatist - always chasing the best technology and open sourcing it.  He took much criticsm because he started the Mono project in bringing Microsoft's C# and .NET platform to Linux, because he saw C# as the best language to develop in cross platform.   This brought about the comdenation of Richard Stallman, calling Miguel, "*A traitor to free software.*" [^30]  Miguel's response to Stallman was a beautiful example of how to diffuse an inflamatory situation:

> "I want to say that God loves all creatures. From the formidable elephant to the tiniest ant. And that includes Richard Stallman. 
>
> As for me, I think that there is a world of possibility, and if Richard wants to discuss how we can improve the pool of open source/free software in the world he has my email address. 
> 
> Love, Miguel." [^35]

In the early 2000s Sun and HP adopted the GNOME desktop as the replaceemtn for CDE for their Unix distros.  Red Hat Linux adopted GNOME as well.  The GNOME has recently come into some controversy.  

GNOME 2 was released in early 2002 and the last GNOME 2 release was in 2010.  Over this 8 years GNOME developed itself as a mature desktop by using the traditional desktop metaphore: start menu, task managers, and toolbars.  But like all things that change, in early 2011 GNOME 3 was released, and there was a mighty backlash.  Even Linus Torvalds who is a Red Hat user came out against GNOME 3 hard.  GNOME 3 took on a different metaphor, that of the GNOME shell.  Think of the shell as a way to manage or view multiple tasks and applications happening.  Instead of a desktop, think of new metaphore as a table top using By 2012 GNOME community development had waned.  Coincidentially by that time their was 1 community developer working on GNOME full time and 10 Red Hat Employees.  In 2012 the GNOME project voted to include Lennart Poeterring's sysetmd as a hard dependency.  This had a two fold effect.  This made GNOME 3 the default desktop of any system using systemd for process initialization on boot.  We see that Debian, who adopted systemd, also was forced to swithc from GNOME 2 and Xfce back to GNOME 3 because of the hard dependency.  Perhaps more of Red Hat's plot to take over the Linux standard by copting the Linux desktop?  Who can say? [^29] 



   
 Which is better?  Hard to say.  Both have had set backs and advancements over the years.  The look and feel of KDE resembles traditional Windows as it was designed to help ease of Windows users into Linux transition.  GNOME itstead went for the Mac route of floating windows.  
 
### Development Forks: Unity, Mate, and Cinnamon
 
 Not to be outdone.  Ubuntu introduced their own Desktop Environment called Unity (date and time and link to Ubuntu)  This decision lead to a many Ubuntu based distros being formed just to replace the Desktop Environment.  The majority of Linux distros use GNOME as their standard desktop0 environment.  But as in Linux, you can customize or even replace or install side by side the Desktop evnrionemnt. 
  
  Seeing as KDE and GNOME focused on features and usability, many people who were using older hardware felt left out or unable to run these Environemnts as the resources required were growing.  So a movement to create light desktop environements sprung up.  The first was XFCE and then LXDE (How is it related to LXQT)  There were also design revolts.  When GNOME moved from version 2 to version 3 the amount change was seen by some GNOME users as treason.  They foked the GNOME2 desktop code and it became known as something called MATE - which was integrated into a Desktop environment called Cinnamon.  All of these desktop environments are available for install.  Some are specifically packaged by Red Hat and Ubuntu to match a theme and style and some are avaialble to install but might not be in the most usable state.
  
  [Qt](https://www.qt.io/ "Qt)(pronounced *cute-ee*) is developed in C++ and KWin the window manager can be extended in [QtScript](https://en.wikipedia.org/wiki/QtScript "QtScript") which is Javascript based.  
     
[Who uses what?](https://en.wikipedia.org/wiki/Category:Desktop_environments_based_on_GTK%2B "Development Environments")     
     
----------------------------------------------------- --------------- ---------------------    
[KDE 5](https://www.kde.org/ "KDE") [^31]             Qt 5            https://www.kde.org/ 
[GNOME 3](https://www.GNome.org/ "GNOME")             GTK+ 3          https://GNome.org/
[Xfce](http://www.xfce.org/ "Xfce")                   GTK+ 3          http://www.xfce.org/
[LXDE](http://lxde.org/ "LXDE")                       GTK+ 2 -> 3     http://lxde.org/
[LXQT](http://lxqt.org/about/ "LXQT")                 Qt 5            http://lxqt.org/about/
[MATE](http://mate-desktop.org/ "Ma-tay")             GTK+ 2 -> 3     http://mate-desktop.org/
[Cinnamon](http://cinnamon.linuxmint.com/ "Cinnamon") GTK+ 3          http://cinnamon.linuxmint.com/
[Unity](https://unity.ubuntu.com/ "unity")            UnityNext       https://unity.ubuntu.com/  
----------------------------------------------------- --------------- ---------------------
 

There are more Desktop environemnts but these are the major ones you will enconter.   You can install all of these themes of both Ubuntu and Fedora.  There are usally packages that come pre-themed based on each desktop as well as you can install the generic desktops without direct distro themeing - though in that way they often look visually jaringly.

### Theming

Fun Ubuntu to Mac and Windows themes
http://www.noobslab.com/p/themes-icons.html  

and unique Ubuntu theming

Windows Icons here
http://www.noobslab.com/2014/04/make-your-ubuntulinux-mint-look-like.html

Have them install Ubuntu touch theme?

Fedora moves to fast to really have a themeing community behind it but you can tweak the GNOME 3 settings.

### - Gnome 3 Features  

#### Fedora 22 package manager

  The package manager is called Software - you can search for it, but many of the items you will search for don't appear in the store.  That is because Fedora 22 is cutting edge and requries packages to have an AppData meta data file for it to appear in the Software store.  In the mean time you can use the Software store to install the GNOME Packages package manager which will default to the old style and let you install everything.  
  
### - Unity Features
  
Mac theme transformation for Ubuntu http://www.noobslab.com/2015/05/mbuntu-y-macbuntu-transformation-pack.html
Window theme transformation for Ubuntu  http://www.noobslab.com/2015/06/do-you-like-windows-look-and-feel-but.html and here http://www.noobslab.com/2014/04/make-your-ubuntulinux-mint-look-like.html

  
## - Chapter Conclusions and Review

  Conclusion goes here

### - Review Questions

  * Questions go here

### - Podcast Questions

Please answer these questions from the Fedora Project podcast on [FLOSS - http://twit.tv/floss/71](http://twit.tv/floss/71 "Fedora Project")

  * ~9:11 What is the Fedora Project?
  * ~11:35 How does Redhat make money on Fedora if it is free?
  * ~12:30 What is the Fedora release cycle and can businesses use this release cycle?
  * ~13:30 What is the relationship between Fedora and Redhat Enterprise Linux (RHEL)?
  * ~25:00 What precentage of the Fedora Project is open source?
  * ~35:00 On further inspection is Fedora Project really opened source according to the Free Software Foundation?
  * ~36:20 Does Fedora include proprietary NVidea drivers? Why or why not?
  * ~44:30 Who is the most famous Fedora user?
  * ~1:01:00. What is the difference between Centos and RHEL?

### - Lab

 * Using the virtual machines you installed in the previous chapter, you will now install the list below of Window Managers and Desktop environments.  You will take a screenshot from within VirtualBox.

### - Footnotes
 
 [^23]: <a href="http://www.allaboutapple.com/" rel="nofollow">http://www.allaboutapple.com/</a>    
     <a  href="http://creativecommons.org/licenses/by-sa/2.5/it/deed.en">CC BY-SA 2.5 it</a>, 
     <a href="http://creativecommons.org/licenses/by-sa/2.5/it/deed.en">CC BY-SA 2.5 it</a>, 
     <a href="www.gnu.org/copyleft/fdl.html">GFDL</a> or 
     <a href="http://creativecommons.org/licenses/by-sa/3.0/">CC-BY-SA-3.0</a>, 
     <a href="https://commons.wikimedia.org/wiki/File%3AMacintosh_128k_transparency.png">via Wikimedia Commons</a>
 
 [^24]: By Original by David Gerard, recreated by Efitu (Wikimedia Commons) 
     <a href="http://www.gnu.org/copyleft/fdl.html">GFDL</a> or 
     <a href="http://creativecommons.org/licenses/by-sa/3.0/">CC-BY-SA-3.0</a>, 
     <a href="https://commons.wikimedia.org/wiki/File%3AX_client_server_example.svg">via Wikimedia Commons</a>
     
  [^25]: By Jason Scott (Flickr: IMG_9976) <a href="http://creativecommons.org/licenses/by/2.0">CC BY 2.0</a>, 
    <a href="https://commons.wikimedia.org/wiki/File%3ADEC_VT100_terminal.jpg">via Wikimedia Commons</a>   
    
  [^26]: Diagram provdied by: http://wayland.freedesktop.org/architecture.html
  
  [^27]: [http://www.omgubuntu.co.uk/2014/03/mir-default-display-server-ubuntu-2016](http://www.omgubuntu.co.uk/2014/03/mir-default-display-server-ubuntu-2016)
  
  [^28]: <a href="https://commons.wikimedia.org/wiki/File:Miguel_de_Icaza.jpg#/media/File:Miguel_de_Icaza.jpg">Miguel de Icaza</a> 
     Licensed under <a title="Creative Commons Attribution 2.0" href="http://creativecommons.org/licenses/by/2.0">CC BY 2.0</a> 
     via <a href="https://commons.wikimedia.org/wiki/">Commons</a>.
  
  [^29]: <a href="https://blogs.gnome.org/otte/2012/07/27/staring-into-the-abyss/">https://blogs.gnome.org/otte/2012/07/27/staring-into-the-abyss/</a>
  
  [^30]: <a href="http://www.osnews.com/story/22225/RMS_De_Icaza_Traitor_to_Free_Software_Community/">http://www.osnews.com/story/22225/RMS_De_Icaza_Traitor_to_Free_Software_Community/</a>
  
  [^31]: Qt 5 / KDE 5 split into three seperate components <a href="https://en.wikipedia.org/wiki/Qt_%28software%29#Qt_5">https://en.wikipedia.org/wiki/Qt_%28software%29#Qt_5<a/>
  
  [^32]: KDE Plasma 5 retired KDM as the default display manager in favor of SDDM.  
    <a href="http://www.phoronix.com/scan.php?page=news_item&px=MTgyOTU">http://www.phoronix.com/scan.php?page=news_item&px=MTgyOTU</a>
  
  [^33]: Comparison of X Windows Desktop Environments 
      <a href="https://en.wikipedia.org/wiki/Comparison_of_X_Window_System_desktop_environments">https://en.wikipedia.org/wiki/Comparison_of_X_Window_System_desktop_environments</a>
  
  [^34] <a href="http://arstechnica.com/information-technology/2008/01/nokia-buys-trolltech-will-become-a-patron-of-kde/">http://arstechnica.com/information-technology/2008/01/nokia-buys-trolltech-will-become-a-patron-of-kde/</a>
  
  [^35] Miguel's responce to Stallman's accusation
      <a href="http://tirania.org/blog/archive/2009/Sep-23.html">http://tirania.org/blog/archive/2009/Sep-23.html</a>
  
  