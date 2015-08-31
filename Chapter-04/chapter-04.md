# Desktop Linux - GUI
![*Who needs Flash?*](http://imgs.xkcd.com/comics/supported_features.png "Linux Supported Features")

__Chapter 4 Objectives__

  In this chapter you will:
  
  *  Learn about how desktop Linux works
  *  Understand the nature and use of X Windows, Mir, Wayland, and GUI compositors
  *  Understand the purpose of window mangers and desktop environments
  *  Know the major features of GNOME 3 and Unity desktop environments
  *  Symlinks and file types 

__Outcomes__

  At the conclusion of this chapter you will have a strong knowledge of the X Windows system and how it is the foundation of Desktop Linux.  You will be able to implement various Window Managers and Desktop Envrionemnts, selecting the proper environement to utilize and suit your hardware needs.  You will be comfortable using and recoginizing the features of GNOME 3 and Unity desktop environments.  

## From Paper Tape to CLI to GUIs to 4K

  Unix had its starts in the late 1960's and 1970's.  Computing at that time took on a less interactive and more iterative/batch processing style.  Not until the late 70's and early 1980's do we begin to see the green colorede terminals we are familiar with.  Initially Unix had to develop support for GUIs.  This was done through the X11 protocol or what ended up being called X Windows.  The X was originally a place holder in the hopeps that an actual name could be created, but they say what is temprorary is permanent, and X Windows was here to stay.  X Windows is actually a client server protocol.  It was designed with the idea in mind of transporting display windows over TCP/IP.  Seeing as it was designed in the University and corporate setting - the idea of security was non-existant.  Any Computer that could connect to another computer could start an X Windows session.  The utility of this was that you could use lesser hardware and simply via the X Windows protocol remotely run you application window.  An office or university would have 1 large server and each desktop would connect and tunnel X Windows over TCP/IP.  
  
  Initially this was designed witha single purpose, single window in mind.  But X Window use grew the utility of X Windows to be a *"compositor"* for drawing a GUI (Graphical User Interface) on your local desktop became a standard feature.
  
  X Windows was developed by MIT and someone else.  The actual protocol that data transfers over is called X11.  
  
  X has a long history and that history was forked and rejoined over time.  
  
  
  
  X Windows protocol was forked in X86free.org and X.org  and for many years were seperate - but they have recently joined back together and the current and standad Linux desktop compositor is now referred to as *"X"*.  X has a definate advantage in that it is very mature and very well known for all its good and bad parts.  In the diagram below you can see one of X major faults.  (Get picture from Wayland website)  Seeing as it was designed not with a desktop GUI in mind, every desktop element is a client that has to make calls to the X server in order to render any changes to the screen.  This adds extra layers of overhead.

  A project was started to reimainge the nature of the Linux compsitor.  This project is called Wayland.  But the Wayland authors knew they couldn't just throw X out as everysingle Linux desktop today uses it--that would break all of Linux.  Instead they reimplemented X into something called X wayland (see image from Wayland.org)   Slowly many Linux distributions are looking at the improvememnts of Wayland and moving to gradually implement it.  Will we ever see the end of X?  Probably not as it is too deep into the "bones" of Linux.  But Fedora 22 has a beta version of X-wayland running Fedora 22 - which will render Walyand and X at the same time. 
  
  Not ot be outdone Ubuntu decided not to work with the Wayland project and decided to create their own compositor called Mir.  THis idea was highly ciriticzed (find link).  But I think it was without warrent.  Ubuntu has a business case--they were looking to make a compositor that could adapt based on form factor.  Instead of having a phone, tablet, tv, desktop rendered, Mir would be custimoizable to Ubuntu's hardware dreams.  This precluded them to work on their own compositor.  But they have leanred that it is not so easy and it has been constantly delayed from public release.  (Link to Mir current status)    
  
## Window Managers

 With the advent of X and windowing capabilities, a need to manage multiple local windows arrose and gave rise to early windowing managers.  For those of us old enough to remember, this would be similar to early Mac and pre Windows-95 operating systems.
 (Show image of windowing tool kit)
 
 Window Managers are very fast because they have almost no chrome or what we would think of as standard polish.  There only concept is render contents inside of particiular windows.  Things we come to expect such as sliders, close boxes, touch simply don't exist in Window Managers
 
 A Window Manager is one step above a single X WIndow extension, but it is not a desktop environemnt. 
 Here is a list of some Window Managers  
   
  * Enlightenment
  * I3
  * Xmonad
  * OpenBox

## Desktop Environments
  
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
     + XFCE
     + LXDE & LXQT
     + MATE (GNOME 2) Cinnamon
     + [http://smashingweb.info/mac-os-x-theme-for-ubuntu-14-04-macbuntu-transformation-pack/](http://smashingweb.info/mac-os-x-theme-for-ubuntu-14-04-macbuntu-transformation-pack/ "Ubuntu to Mac desktop conversion")

## - Gnome 3 features  
  
  
## - Unity Features


  
## - Chapter Conclusions and Review

  Conclusion goes here

### - Review Questions

  * Questions go here

### - Podcast Questions

Perhaps Miguel De Icazza podcast?  Or Ubuntu Edge?  Mir?  

 * Best short interview I ever heard with Richard Stallmand from Will Backmand of [BSDTalk](http://bsdtalk.blogspot.com/ "BSD Talk")
 * [Link to .ogg audio interview file](https://archive.org/download/bsdtalk132/bsdtalk132.ogg "RMS Interview")

### - Lab

 * Using the virtual machines you installed in the previous chapter, you will now install the list below of Window Managers and Desktop environments.  You will take a screenshot from within VirtualBox.
 
 