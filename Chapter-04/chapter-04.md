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
      
### - Project Wayland
  
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
  
  Not to be outdone Ubuntu saw an opportunity to come up with an X repalcement.  They created their own compositor called Mir.  Unfortuantely this has met with serious opposition, even to the point in 2013 of Intel, who supports Wayland, [rejecting XMir support](http://arstechnica.com/information-technology/2013/09/intel-rejection-of-ubuntus-mir-patch-forces-canonical-to-go-own-way/ "Intel Rejects XMir") in Intel's opensource graphic drivers. Unfortuantely Ubuntu is the only Linux operating system to support Mir and development has been delayed as the project has taken on the monumental task of replacing X.  Ubuntu was critcized for not joining the Wayland group's work but I think that may have been a bit without warrent.  Ubuntu has a business use case--they are looking to make a compositor that could adapt based on form factor, something not unlike how Android works.  This would enable them to make Ubuntu for tablets, phones, TVs, even smaller devices electronic devices.  Mir would be custimoizable to Ubuntu's hardware dreams and they could sell hardware and perhaps make some money.  This precluded them to work on their own compositor.  
  
 > *"In March 2014, Mark Shuttleworth confirmed that Mir development had been delayed and that it was now forecast to be default for desktop use in Ubuntu 16.04 LTS, expected to be released in April 2016."* [^27]
  
## Window Managers

 X will let you display a window and let you capture mouse and keyboard commands.  But what if you want to render multiple windows one one machine and manage their state as well?  Then you need a window manger to sit on top of X and handle that rendering.  Window managers are almost inseperable from X in this case. Window Managers are not full GUIs you might be used to. They are one step below but window managers are very fast because they render simple windows and simple sets of icons.  Their only job is to render content inside of particiular windows and manage that window's state. 
 
You can break window managers into 5 ctegories based on their window behavior.

### Compositing 

* Compiz - Fusion Adds more functionality to Compiz with more plugins, tools and libraries 
* Compiz - OpenGL window and compositing 
* Metacity - Small window manager, using GTK+2 to do everything 

### Stacking 

*  Blackbox - Similar to the NeXT interface and Window Maker 
*  Fluxbox - Highly configurable and low resource 
*  FVWM - Minimize memory consumption, provide a 3D look to windows, and a virtual desktop 
*  Enlightenment - Focuses on pushing the limits of existing technologies 
*  Openbox - Standards compliant, fast, light-weight, extensible window manager 
*  Sawfish - Extensible window manager using an Emacs Lisp-like scripting language 

### Minimalistic 

*  IceWM - Win95-OS/2-Motif-like window manager 
*  Afterstep - NEXTSTEP look and feel 
*  Window Maker - NeXTSTEP-like window manager  
*  Pekwm - Originally based on the aewm++ window manager 

### Tiling 

*  Xmonad - Minimalist, tiling window manager written in Haskell 
*  Ratpoison - Keyboard-only window manager 
*  StumpWM - Common Lisp window manager 
*  wmii - Lightweight tabbed and tiled 
*  Ion - Tiling tabbed window manager designed for keyboard users 
*  Awesome - Dynamic and tiling 
*  dwm - Dynamic window manager 

### Other 

*  evilwm - Maximises screen real estate and provides good keyboard control 

## Desktop Environments
  
  Comparison of desktops for X - https://en.wikipedia.org/wiki/Comparison_of_X_Window_System_desktop_environments

  By the time of the Linux kernel release and it becoming a stable development platform.  What enabled Linux to move from hobby OS to real commcerial option was the creation of the first desktop environments.  The KDE (K Desktop Environment) was the first toolkit released In 1994/5.  It was opensources and adopted quickly but parts of it used the propriatery QT (pronounced cuteie) Windowing tool kit - which was not opensource. It was opensourced by KDE 2.0.  This moved Miguel De Icazza to create a truly opensoruced alternative to KDE called GNOME.  This was a GNU project and also included the development of the *GTK*, commonly mistaken as the *Gnome Took Kit*, actually stands for the GIMP Tool Kit.  [GIMP](https://en.wikipedia.org/wiki/GIMP "GIMP") is the GNU Image Manipulation Program, for creating windowing objects.  

  Miguel ended up forming the company that became Xamarin, a cross development movile platform using c# to develop for Android and iOS.
  (Get picture of Miguel)
   
  Which is better?  Hard to say.  Both have had set backs and advancements over the years.  The look and feel of KDE resembles traditional Windows as it was designed to help ease of Windows users into Linux transition.  GNOME itstead went for the Mac route of floating windows.  Not to be outdone.  Ubuntu introduced their own Desktop Environment called Unity (date and time and link to Ubuntu)  This decision lead to a many Ubuntu based distros being formed just to replace the Desktop Environment.  The majority of Linux distros use GNOME as their standard desktop0 environment.  But as in Linux, you can customize or even replace or install side by side the Desktop evnrionemnt.  A desktop environment needed to embody more than just window openings and closings, but began to provide tools you and I take for granted.  Things such as a clock, or a text editor, office sutie or email client, even initially a web broweser and all these things having a consitent usage pattern and feel.
  
  Seeing as KDE and GNOME focused on features and usability, many people who were using older hardware felt left out or unable to run these Environemnts as the resources required were growing.  So a movement to create light desktop environements sprung up.  The first was XFCE and then LXDE (How is it related to LXQT)  There were also design revolts.  When GNOME moved from version 2 to version 3 the amount change was seen by some GNOME users as treason.  They foked the GNOME2 desktop code and it became known as something called MATE - which was integrated into a Desktop environment called Cinnamon.  All of these desktop environments are available for install.  Some are specifically packaged by Red Hat and Ubuntu to match a theme and style and some are avaialble to install but might not be in the most usable state.
  
  Get logos for these
  
   * Desktop Environments
     + KDE 5 - https://www.kde.org/  Qt framework
     + GNOME 3 - GNome.org/ developed on GTK+ 3
     + Unity - https://unity.ubuntu.com/ 
     + Xfwm developed by Xfce  
     + LXDE http://lxde.org/ Developed on GTK+ 2
       - LXQT - a port of LXDE from GTK+ 3 to Qt http://lxqt.org/about/
     + MATE   http://mate-desktop.org/ continuation of (GNOME 2)
     + Cinnamon - http://cinnamon.linuxmint.com/ fork of GTK+ 3  developed for LInux Mint in response to Ubuntu Unity

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
  
  