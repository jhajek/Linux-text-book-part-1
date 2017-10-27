---
layout: post
status: publish
published: true
title: Euca2ools 3.1.x works on Bash for Windows 10 14323
author:
  display_name: hajek
  login: hajek
  email: hajek@iit.edu
  url: ''
author_login: hajek
author_email: hajek@iit.edu
wordpress_id: 1714
wordpress_url: https://forge.sat.iit.edu/?p=1714
date: '2016-05-18 23:39:45 -0500'
date_gmt: '2016-05-19 04:39:45 -0500'
categories:
- tools
- Cloud
- Eucalyptus
tags:
- euca2ools
- bash on windows
comments: []
---
<p>Bash for Windows or the <a href="http:&#47;&#47;blog.dustinkirkland.com&#47;2016&#47;04&#47;howto-ubuntu-on-windows.html">Linux Subsystem for Windows<&#47;a> </p>
<p>Since it is basically Ubuntu 14.04 - euca2ools should install properly.  I set out to see what would happen as it would be comforting to be able to use the Linux subsystem for euca2ools work. </p>
<p><a href="/assets/2016&#47;05&#47;bash-git-clone.png"><img src="/assets/2016&#47;05&#47;bash-git-clone.png" alt="bash-git-clone" width="846" height="82" class="aligncenter size-full wp-image-1718" &#47;><&#47;a></p>
<p>Following the normal process -- everything worked!  But one thing...<br />
<a href="/assets/2016&#47;05&#47;bash-euca-version.png"><img src="/assets/2016&#47;05&#47;bash-euca-version.png" alt="bash-euca-version" width="888" height="73" class="aligncenter size-full wp-image-1717" &#47;><&#47;a></p>
<p><a href="/assets/2016&#47;05&#47;bash-on-win-install.png"><img src="/assets/2016&#47;05&#47;bash-on-win-install-1024x608.png" alt="bash-on-win-install" width="845" height="502" class="aligncenter size-large wp-image-1719" &#47;><&#47;a></p>
<p>The thing to keep in mind is that Ubuntu 14.04 has its own version of the python-requests library.  You need to remove this version:</p>
<p><code>sudo apt-get remove python-requests<&#47;code></p>
<p><a href="/assets/2016&#47;05&#47;bash-on-win-install.png"><img src="/assets/2016&#47;05&#47;bash-on-win-install-1024x608.png" alt="bash-on-win-install" width="845" height="502" class="aligncenter size-large wp-image-1719" &#47;><&#47;a></p>
<p><a href="/assets/2016&#47;05&#47;bash-euca2ools-building.png"><img src="/assets/2016&#47;05&#47;bash-euca2ools-building.png" alt="bash-euca2ools-building" width="859" height="603" class="aligncenter size-full wp-image-1715" &#47;><&#47;a></p>
<p><a href="/assets/2016&#47;05&#47;bash-euca-describe-instances.png"><img src="/assets/2016&#47;05&#47;bash-euca-describe-instances.png" alt="bash-euca-describe-instances" width="908" height="584" class="aligncenter size-full wp-image-1716" &#47;><&#47;a></p>
