# Labs - Chapter 04

Using the virtual machines you installed in the previous chapter, Fedora 34 and Ubuntu Desktop 20.04, you will now install additional software, themes, desktop environments, and window managers. You will combine screenshots of this newly installed software into a single document for submission.  We will be focusing on package based installs in the first part of the lab.

## GNOME Extensions

You will need to install the listed GNOME 3 extensions from [https://extensions.gnome.org](https://extensions.gnome.org "Gnome extensions").  The first one is the example in the book called *Caffeine*. Make sure you have the Gnome Shell integration installed to configure and install plugins directly from the browser.

1) Caffeine (screenshot of coffee cup icon in upper right corner)
1) Dash to Dock (move dock to the bottom of the screen)
1) Screenshot Tool (screenshot of camera icon in upper right corner)

## Snaps Install

To install and configure snaps, reference chapter 3.  To show these packages are installed take a screenshot of the output of the command: `sudo snap list`. Install these packages via Snap on any **Ubuntu or Debian** based desktop:

1) Android Studio
1) Blender
1) Slack
1) Discord
1) Visual Studio Code

## Flatpak Install

To install and configure flatpak and flathub, reference chapter 3.  To show these packages are installed take a screenshot of the output of the command: `sudo flatpak list`. Install these packages via flatpak on the **Fedora** virtual machine:

1) Kdenlive
1) Visual Studio Code
1) Discord
1) Remmina
1) GtkStressTesting

## Ubuntu 20.04 Flatpak Install

To install and configure flatpak and flathub, reference chapter 3.  To show these packages are installed take a screenshot of the output of the command: `sudo flatpak list`. Install these packages via flatpak:

1) Microsoft Teams
1) Shotcut
1) LibrePCB
1) OpenBoard

## AppImage Install

Find 3 [AppImage install packages](https://appimage.org/ "AppImages install"), follow the instructions to install and run these AppImages on both Ubuntu 20.04 and Fedora 34.  Take a screenshot of the command needed to run the AppImage and the corresponding first screen of that application from the [AppImage GitHub repo](https://appimage.github.io/apps "AppImage GitHub Repo").

1) Poddr
1) Archipelago
1) LibrePCB

## Installing Window Managers

You will chose 1 of the window managers from the categories listed earlier in the chapter and install them.  Once installed you need to log out and restart your session.  In order to change the default window manager on GNOME3 desktop environment you need to click on the user name and select the little gear below the password field.  In your screenshot open a terminal window, you might need to do some research to understand how to operate in a window manager.

![*Change Window Managers*](images/Chapter-04/GNOME3/window-manager.png "Change")

* Stacking window manager - [Openbox](http://openbox.org/wiki/Main_Page "Openbox")
  * Show 3 Windows stacked (FireFox, Terminal, and the File Manager)
* Tiling window manager - i3
  * [i3 keyboard command reference](https://i3wm.org/docs/refcard.html "i3 keyboard command reference")
  * Show 3 Windows tiled, 2 Terminal Windows and 1 FireFox.
  * Use the link above to learn the key commands to launch windows, remember there is no mouse!

**Note:** the names of packages are not always obvious so you can use search features of package managers.  For example, here would be how to search for the i3 package.

* ```sudo apt-cache search i3```
* ```sudo dnf search i3```

## Desktop Environment Installs

Install these desktops, restart your system and as you login switch your desktop environment and take a screenshot of the new environment.

1) Install the Xfce Desktop on Fedora 34
1) Install the Ubuntu Mate Desktop on Ubuntu 20.04
1) Install the Xfce4 Desktop on Ubuntu 20.04 (the xubuntu-desktop package)

**Deliverable:** Take screenshots of all successful installs of software.  See Blackboard for submission details.
