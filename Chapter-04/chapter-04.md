# Desktop Linux and GUIs
![*It used to be like this...*](http://imgs.xkcd.com/comics/cautionary.png "A Cautionary Tail...")

__Chapter 4 Objectives__

  In this chapter you will:
  
  *  Learn about the different types of desktop Linux
  *  Understand the nature and use of X Windows, Mir, Wayland, and other GUI compositors
  *  Understand the purpose of window mangers and the nature of desktop environments
  *  Know the major features of GNOME 3 and Unity desktop environments
  *  Understate the nature of Symlinks and file types <-- __probably need to move this somewhere__

__Outcomes__

  At the conclusion of this chapter you will have a strong knowledge of the X Windows system and why it is the foundation of Desktop Linux.  You will be able to implement various window managers and desktop envrionemnts, selecting the proper environement to utilize and suit your hardware needs.  You will be comfortable using and recoginizing the features of GNOME 3 and Unity desktop environments.  

## From Paper Tape to CLI to GUIs to 4K

  When you think about how we use computers today the one thing we take for granted is a *GUI*, __Graphical User Interface__.  The GUI is intracatly tied to the way computers are used, why do think Microsfot calls its operating system Windows? Unix however, had its start in the late 1960s and 1970s--there was vastly different technology available at that time.  The PDP7s that Thompson and Ritchie used were called [*Teletypes*](https://en.wikipedia.org/wiki/Teleprinter "TTYs") or *TTYs* that had punch card readers for data entry and paper tape for output all conencted to the PDP7 via a modem. You will notice that even today in Unix screen outputs are still refered to as TTYs. By the mid 1970s we begin to see what are called *dumb terminals* appear which could be considered primitave monitors. 
  
  The [Datapoint 3300](https://en.wikipedia.org/wiki/Datapoint_3300 "Datapoint 3300") was one of the more common models reprsenting the era.  It supported control codes to move the cursor up, down, left and right, to the top left of the screen, or to the start of the bottom line and dispalyed a whopping 72 by 25 rows of charaters in the days before microprocessors and ram were part of terminals. By 1978 Digital Equipment Corporation (DEC) had released something akin to an upgrade for the dumb terminal called a *smart terminal*.  
  
  The [DEC VT-100](https://en.wikipedia.org/wiki/VT100 "VT-100") was the most popular model: it had character and cursor positioning and was connected to the Unix system via serial ports and a modem.  The VT-100 set the standard for 80 by 24 rows and columns still in use today.  These terminals had the backing of DRAM and an Intel 8080 processor.  Open up any terminal emulator in linux and see its default size.  Open up Command line in Windows and you will notice the same default dimensions.  Why?  The environemnt you grow up in has a lasting influence on you.  All the developers who built Terminal emulators and Command Line for Windows "grew up" using Unix systems on a DEC VT-100 screen.  It was a natural fit.  The VT-100 and VT-220 continued with wide deployment and sucess but the concept of color or being able to draw any shapes to the screen was in the hands of a few expensive and propriatary companies; everything was still [ASCII](https://en.wikipedia.org/wiki/ASCII "ASCII") or character based.  
 
 __VT-100__ [^25]
 
 ![*VT-100*](https://upload.wikimedia.org/wikipedia/commons/thumb/9/99/DEC_VT100_terminal.jpg/270px-DEC_VT100_terminal.jpg "VT-100") 
  
 ![*Windows cmd.exe earily similar to the VT-100*](images/Chapter-04/cmd-399-by-200.png "cmd.exe")
 
 ![*Ubuntu's GNOME Terminal emulates the VT-100 directly*](images/Chapter-04/linux-terminal-299-by-200.png "Linux Terminal")
 
### X Windows
 
   Beyond the simple green screen terminals we begin to see actual UNIX based GUIs by the mid 1980s. Also during the early 1980s you begin to see propriatery primative UNIX GUIs especially from Sun. These GUI interfaces were placed onto highend workstations sold at premium prices for the day. The early 80s were a transitionary period.  Computing at that time took on a less iterative/batch processing style and a more interactive style.   Initially Unix had to develop support for GUIs.  This was done through the X11 protocol or what ended up being called X Windows.  The X was originally a place holder in the hopeps that an actual name could be created, but they say what is temprorary is permanent, and X Windows was here to stay.  X Windows is actually a client server protocol.  It was designed with the idea in mind of transporting display windows over TCP/IP.  Seeing as it was designed in the University and corporate setting - the idea of security was non-existant.  Any Computer that could connect to another computer could start an X Windows session.  The utility of this was that you could use lesser hardware and simply via the X Windows protocol remotely run your application window.  An office or university would have 1 large server and each desktop would connect and tunnel X Windows over TCP/IP.  
  
  Initially this was designed witha single purpose, single window in mind.  But X Window use grew the utility of X Windows to be a *"compositor"* for drawing a GUI (Graphical User Interface) on your local desktop became a standard feature.  X gave you a frame work each program wrote their own interfaces.   This was opensourced by 1986. Prior to that there had been many attempts at propraitery GUIs on Unix.  Most notably from Sun.  On a side note, the first GUI that became a commercial success was not on a Unix system but on the Apple Macintosh in 1984. 
  
  __Apple MacIntosh__ [^23]
  
![*Apple Macintosh 1984*](https://upload.wikimedia.org/wikipedia/commons/thumb/e/e3/Macintosh_128k_transparency.png/205px-Macintosh_128k_transparency.png "Apple Macintosh")

#### X is a Server and a Client
  
   *"...in 1987-1988 X established itself as the standard graphics engine for Unix machines, a hardware-independent neutral platform on top of which to build GUIs"* [Eric S. Raymond writings](http://www.catb.org/~esr/writings/taouu/html/ch02s06.html "Early history of Unix"). MIT started the X project in 1984 to being to make the ability to draw shape primitives on a screen.   *"X provides the basic framework for a GUI environment: drawing and moving windows on the display device and interacting with a mouse and keyboard. X does not mandate the user interface — this is handled by individual programs."*  [https://en.wikipedia.org/wiki/X_Window_System](https://en.wikipedia.org/wiki/X_Window_System "X Windows")

  *  X Windows was developed by MIT and someone else.  The actual protocol that data transfers over is called X11.  
  *  X has a long history and that history was forked and rejoined over time.  

   X has a definate advantage in that it is very mature and very well known for all its good and bad parts.  In the diagram below you can see one of X major faults.  Seeing as it was designed not with a desktop GUI in mind, every desktop element is a client that has to make calls to the X server in order to render any changes to the screen.  This adds extra layers of overhead also becomes a security nightmare. 
  
![*X Windows Diagram*](https://upload.wikimedia.org/wikipedia/commons/thumb/0/03/X_client_server_example.svg/250px-X_client_server_example.svg.png) [^2524]
 
  Windows in X communicate via the X11 protocol. X Windows protocol was forked in Xfree86.org and X.org  and for many years were seperate - but they have recently joined back together and the current and standad Linux desktop compositor is now referred to as *"X"*. 
   
#### - Project Wayland

  A project was started to reimainge the nature of the Linux compsitor.  This project is called Wayland.  But the Wayland authors knew they couldn't just throw X out as everysingle Linux desktop today uses it--that would break all of Linux.  Instead they reimplemented X into something called X wayland (see image from Wayland.org)   Slowly many Linux distributions are looking at the improvememnts of Wayland and moving to gradually implement it.  Will we ever see the end of X?  Probably not as it is too deep into the "bones" of Linux.  But Fedora 22 has a beta version of X-wayland running Fedora 22 - which will render Walyand and X at the same time. 
  
  Not to be outdone Ubuntu decided not to work with the Wayland project and decided to create their own compositor called Mir.  THis idea was highly ciriticzed (find link).  But I think it was without warrent.  Ubuntu has a business case--they were looking to make a compositor that could adapt based on form factor.  Instead of having a phone, tablet, tv, desktop rendered, Mir would be custimoizable to Ubuntu's hardware dreams.  This precluded them to work on their own compositor.  But they have leanred that it is not so easy and it has been constantly delayed from public release.  (Link to Mir current status)    

### Virtual Consoles?
  
  With the X Window system the idea of having discrete terminals went away.  Now you could have multiple *virtual terminals* on one system that emulated the features of a DEC VT-100 or VT-220 terminal.  IF you hit the  ```ctrl + alt + F1-F7``` you will jump to 1 of 7 different virtual terminals enabled by default.  Usually F7 is the default one but it can vary from operating system to operating system.
  
### Window Managers

 list of managers - https://en.wikipedia.org/wiki/Comparison_of_X_window_managers

 With the advent of X and windowing capabilities, a need to manage multiple local windows arrose and gave rise to early windowing managers.  For those of us old enough to remember, this would be similar to early Mac and pre Windows-95 operating systems.
 (Show image of windowing tool kit)
 
 Window Managers are very fast because they have almost no chrome or what we would think of as standard polish.  There only concept is render contents inside of particiular windows.  Things we come to expect such as sliders, close boxes, touch simply don't exist in Window Managers
 
 A Window Manager is one step above a single X WIndow extension, but it is not a desktop environemnt. 
 Here is a list of some Window Managers  

#### Compositing 

* Compiz - Fusion Adds more functionality to Compiz with more plugins, tools and libraries 
* Compiz - OpenGL window and compositing 
* Metacity - Small window manager, using GTK+2 to do everything 

#### Stacking 

*  Blackbox - Similar to the NeXT interface and Window Maker 
*  Fluxbox - Highly configurable and low resource 
*  FVWM - Minimize memory consumption, provide a 3D look to windows, and a virtual desktop 
*  Enlightenment - Focuses on pushing the limits of existing technologies 
*  Openbox - Standards compliant, fast, light-weight, extensible window manager 
*  Sawfish - Extensible window manager using an Emacs Lisp-like scripting language 

#### Minimalistic 

*  IceWM - Win95-OS/2-Motif-like window manager 
*  Afterstep - NEXTSTEP look and feel 
*  Window Maker - NeXTSTEP-like window manager  
*  Pekwm - Originally based on the aewm++ window manager 

#### Tiling 

*  Xmonad - Minimalist, tiling window manager written in Haskell 
*  Ratpoison - Keyboard-only window manager 
*  StumpWM - Common Lisp window manager 
*  wmii - Lightweight tabbed and tiled 
*  Ion - Tiling tabbed window manager designed for keyboard users 
*  Awesome - Dynamic and tiling 
*  dwm - Dynamic window manager 

#### Other 

*  evilwm - Maximises screen real estate and provides good keyboard control 

## Desktop Environments
  
  Comparison of desktops for X - https://en.wikipedia.org/wiki/Comparison_of_X_Window_System_desktop_environments

  By the time of the Linux kernel release and it becoming a stable development platform.  What enabled Linux to move from hobby OS to real commcerial option was the creation of the first desktop environments.  The KDE (K Desktop Environment) was the first toolkit released In 1994/5.  It was opensources and adopted quickly but parts of it used the propriatery QT (pronounced cuteie) Windowing tool kit - which was not opensource. It was opensourced by KDE 2.0.  This moved Miguel De Icazza to create a truly opensoruced alternative to KDE called GNOME.  This was a GNU project and also included the development of the GTK Gnome Took Kit for creating windowing objects.  

  Miguel ended forming the company that became Xamarin, a cross development movile platform using c# to develop for Android and iOS.
  (Get picture of Miguel)
   
  Which is better?  Hard to say.  Both have had set backs and advancements over the years.  The look and feel of KDE resembles traditional Windows as it was designed to help ease of Windows users into Linux transition.  GNOME itstead went for the Mac route of floating windows.  Not to be outdone.  Ubuntu introduced their own Desktop Environment called Unity (date and time and link to Ubuntu)  This decision lead to a many Ubuntu based distros being formed just to replace the Desktop Environment.  The majority of Linux distros use GNOME as their standard desktop0 environment.  But as in Linux, you can customize or even replace or install side by side the Desktop evnrionemnt.  A desktop environment needed to embody more than just window openings and closings, but began to provide tools you and I take for granted.  Things such as a clock, or a text editor, office sutie or email client, even initially a web broweser and all these things having a consitent usage pattern and feel.
  
  Seeing as KDE and GNOME focused on features and usability, many people who were using older hardware felt left out or unable to run these Environemnts as the resources required were growing.  So a movement to create light desktop environements sprung up.  The first was XFCE and then LXDE (How is it related to LXQT)  There were also design revolts.  When GNOME moved from version 2 to version 3 the amount change was seen by some GNOME users as treason.  They foked the GNOME2 desktop code and it became known as something called MATE - which was integrated into a Desktop environment called Cinnamon.  All of these desktop environments are available for install.  Some are specifically packaged by Red Hat and Ubuntu to match a theme and style and some are avaialble to install but might not be in the most usable state.
  
  Get logos for these
  
   * Desktop Environments
     + KDE
     + GNOME
     + Unity
     + Xfce
     + LXDE & LXQT
     + MATE (GNOME 2) Cinnamon
     + [http://smashingweb.info/mac-os-x-theme-for-ubuntu-14-04-macbuntu-transformation-pack/](http://smashingweb.info/mac-os-x-theme-for-ubuntu-14-04-macbuntu-transformation-pack/ "Ubuntu to Mac desktop conversion")

## - Gnome 3 features  
  
  
## - Unity Features

Mac theme transformation for Ubuntu http://www.noobslab.com/2015/05/mbuntu-y-macbuntu-transformation-pack.html
Window theme transformation for Ubuntu  http://www.noobslab.com/2015/06/do-you-like-windows-look-and-feel-but.html and here http://www.noobslab.com/2014/04/make-your-ubuntulinux-mint-look-like.html
  
## - Chapter Conclusions and Review

  Conclusion goes here

### - Review Questions

  * Questions go here

### - Podcast Questions

Fedora Project

Please answer these questions from the [podcast http://twit.tv/floss/71](http://twit.tv/floss/71 "Fedora Project")

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
    
