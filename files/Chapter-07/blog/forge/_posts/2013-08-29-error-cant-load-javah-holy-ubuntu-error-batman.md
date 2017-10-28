---
layout: post
status: publish
published: true
title: 'Error: can''t load javah? Holy Ubuntu error Batman!'
author:
  display_name: hajek
  login: hajek
  email: hajek@iit.edu
  url: ''
author_login: hajek
author_email: hajek@iit.edu
wordpress_id: 941
wordpress_url: https://blog.sat.iit.edu/?p=941
date: '2013-08-29 23:51:37 -0500'
date_gmt: '2013-08-30 04:51:37 -0500'
categories:
- tools
- Projects
- Cloud
tags:
- Eucalyptus
- HP
- Ubuntu
comments: []
---
<p>Hello intrepid compilers.   For those compiling Eucalyptus 3.3.0 from scratch following these wonderful directions: <a href="https:&#47;&#47;alinush.org&#47;2013&#47;07&#47;21&#47;how-to-compile-and-install-eucalyptus-3-3-0-on-ubuntu-13-04-from-github-sources-cloud-in-a-box&#47;" title="how-to-compile-and-install-eucalyptus-3-3-0-on-ubuntu-13-04-from-github-sources-cloud-in-a-box&#47;">https:&#47;&#47;alinush.org&#47;2013&#47;07&#47;21&#47;how-to-compile-and-install-eucalyptus-3-3-0-on-ubuntu-13-04-from-github-sources-cloud-in-a-box<&#47;a> </p>
<p>These links mention the fact that there are two patches needed to fix axis library errors that are not in the git hub install docs <a href="https:&#47;&#47;github.com&#47;eucalyptus&#47;eucalyptus&#47;blob&#47;master&#47;INSTALL" title="INSTALL.md">https:&#47;&#47;github.com&#47;eucalyptus&#47;eucalyptus&#47;blob&#47;master&#47;INSTALL<&#47;a> </p>
<p>Any way the document runs into a problem - configure works just fine - but when you go to run<br />
<code>sudo make install<&#47;code> </p>
<p>it errors out with:</p>
<p><code>&#47;home&#47;ubuntu&#47;eucalyptus&#47;clc&#47;modules&#47;storage-controller&#47;build.xml:77: Can't load javah<&#47;code>  </p>
<p><strong>What might be the cause?<&#47;strong>  Scroll up and find the hint in the output <code>Unable to locate tools.jar. Expected to find it in &#47;usr&#47;lib&#47;jvm&#47;java-6-openjdk-amd64&#47;lib&#47;tools.jar<&#47;code>  </p>
<p><strong>What does this mean?<&#47;strong>   A little bit of <em>"stackoverflowing"<&#47;em> (Perhaps I can coin a new internet meme to replace <em>"googling"<&#47;em>) gives this hint <a href="http:&#47;&#47;stackoverflow.com&#47;questions&#47;15032230&#47;cant-load-javah-error-in-eclipse" title="http:&#47;&#47;stackoverflow.com&#47;questions&#47;15032230&#47;cant-load-javah-error-in-eclipse">http:&#47;&#47;stackoverflow.com&#47;questions&#47;15032230&#47;cant-load-javah-error-in-eclipse<&#47;a></p>
<p>Turns out I needed to add openjdk-6-jdk to the install dependencies to satisfy this ANT (1.8.3) dependency on Ubuntu 12.04.3.   I hope that helps...  Once the extra dependency is added then you will see the screen below. (Sorry Louis - the Lions just happened to be in the background...)</p>
<p><a href="https:&#47;&#47;blog.sat.iit.edu&#47;wp-content&#47;uploads&#47;2013&#47;08&#47;chi_lions_bears_02.jpg"><img src="https:&#47;&#47;blog.sat.iit.edu&#47;wp-content&#47;uploads&#47;2013&#47;08&#47;chi_lions_bears_02-300x187.jpg" alt="chi_lions_bears_02" width="300" height="187" class="alignnone size-medium wp-image-942" &#47;><&#47;a></p>
