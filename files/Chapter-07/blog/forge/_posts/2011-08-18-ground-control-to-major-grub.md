---
layout: post
status: publish
published: true
title: Ground control to major GRUB
author:
  display_name: bkhodja
  login: bkhodja
  email: bkhodja@iit.edu
  url: ''
author_login: bkhodja
author_email: bkhodja@iit.edu
wordpress_id: 84
wordpress_url: http://aurora.sat.iit.edu/?p=84
date: '2011-08-18 11:27:09 -0500'
date_gmt: '2011-08-18 16:27:09 -0500'
categories:
- tools
- Projects
- fun
tags:
- HP
comments: []
---
<p>Sometimes GRUB and&#47;or the Ubuntu command line may suddenly change to a resolution which is not compatible with your monitor in which case your monitor displays a message such as "Signal out of range" or "No signal." An easy way to solve this problem is to do the following:</p>
<p>1. Connect a monitor which can support high resolutions and refresh rates to the problematic machine (a CRT monitor should work). If you do not have an extra monitor available, you could also SSH into the problematic machine using an SSH client on another machine.</p>
<p>2. Edit the file <strong>&#47;etc&#47;default&#47;grub<&#47;strong></p>
<p>3. Uncomment the line which reads <strong>#GRUB_GFXMODE=1024x768<&#47;strong> and then change the '1024x768' to whichever resolution you would like to use. To be safe, I suggest using 800x600 or 1024x768 at the most.</p>
<p>4. Save the file.</p>
<p>5. Execute the command <strong>sudo update-grub<&#47;strong> and then reboot the machine.</p>
<p>Now, reconnect the monitor which previously was not working. Both GRUB and the Ubuntu command line will now, by default, run using the resolution specified in the GRUB_GFXMODE= line of the &#47;etc&#47;default&#47;grub file!</p>
<p>The information used to create this post was obtained from - <a title="https:&#47;&#47;help.ubuntu.com&#47;community&#47;Grub2" href="https:&#47;&#47;help.ubuntu.com&#47;community&#47;Grub2" target="_blank">https:&#47;&#47;help.ubuntu.com&#47;community&#47;Grub2<&#47;a></p>
