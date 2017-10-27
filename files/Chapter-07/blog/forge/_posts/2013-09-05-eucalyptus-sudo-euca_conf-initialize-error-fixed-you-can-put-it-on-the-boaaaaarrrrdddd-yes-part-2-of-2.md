---
layout: post
status: publish
published: true
title: Eucalyptus sudo euca_conf --initialize error?   Fixed! You can put it on the
  boaaaaarrrrdddd! Yes!  Part 2 of 2
author:
  display_name: hajek
  login: hajek
  email: hajek@iit.edu
  url: ''
author_login: hajek
author_email: hajek@iit.edu
wordpress_id: 969
wordpress_url: https://blog.sat.iit.edu/?p=969
date: '2013-09-05 20:46:22 -0500'
date_gmt: '2013-09-06 01:46:22 -0500'
categories:
- Projects
- Cloud
tags:
- Eucalyptus
comments: []
---
<p><a href="https:&#47;&#47;blog.sat.iit.edu&#47;2013&#47;09&#47;eucalyptus-sudo-euca_conf-initialize-error-fixed-you-can-put-it-on-the-boaaaaarrrrdddd-yes-part-1-of-2&#47;" title="Eucalyptus sudo euca_conf &Gamma;&Ccedil;&ocirc;initialize error?   Fixed! You can put it on the boaaaaarrrrdddd! Yes!  Part 1 of 2">Part 1<&#47;a></p>
<p>Continuing from the previous article - once the 'bc' error is fixed - when you run <code>sudo &#47;usr&#47;sbin&#47;euca_conf --initialize --debug<&#47;code>  now here is your error:</p>
<p><a href="https:&#47;&#47;blog.sat.iit.edu&#47;wp-content&#47;uploads&#47;2013&#47;09&#47;afterBC.png"><img src="https:&#47;&#47;blog.sat.iit.edu&#47;wp-content&#47;uploads&#47;2013&#47;09&#47;afterBC-300x212.png" alt="afterBC" width="300" height="212" class="alignnone size-medium wp-image-970" &#47;><&#47;a></p>
<p>Notice it says: </p>
<blockquote><p>Status=1<br />
Output:<br />
[error:0631] Cannot find Eucalyptus bootstrapper: com&#47;eucalyptus&#47;bootstrap&#47;SystemBootstrapper.<br />
....<br />
[error:0557] Service exit with a return of 1.<br />
initialize command failed<&#47;blockquote></p>
<p>So what can this be?  First thing would be to check the <code>&#47;var&#47;log&#47;eucalyptus&#47;cloud-output.log<&#47;code>, but since initializing failed that file doesn't even get created...  hmmm....</p>
<p>Ok, how about a <code>sudo find &#47; -name SystemBootstrapper.java<&#47;code>?  Ok great we get a result: <code>&#47;home&#47;ubuntu&#47;eucalyptus&#47;clc&#47;modules&#47;msgs&#47;src&#47;main&#47;java&#47;com&#47;eucalyptus&#47;bootstrap&#47;SystemBootstrapper.java<&#47;code> So it is on the system as a java class (Note it is not this - <a href="https:&#47;&#47;pypi.python.org&#47;pypi&#47;bootstrapper&#47;0.1" title="https:&#47;&#47;pypi.python.org&#47;pypi&#47;bootstrapper&#47;0.1">https:&#47;&#47;pypi.python.org&#47;pypi&#47;bootstrapper&#47;0.1<&#47;a> )  Why can't the initialize script find it?  </p>
<p>Well after a bit of bravery on my part and the gracious help of the Eucalyptus <a href="http:&#47;&#47;en.wikipedia.org&#47;wiki&#47;IRC">IRC<&#47;a> channel the answer was figured out.  See transcript below -- <a href="https:&#47;&#47;blog.sat.iit.edu&#47;wp-content&#47;uploads&#47;2013&#47;09&#47;eucalyptus.2013-09-05.txt">eucalyptus.2013-09-05.log<&#47;a>  Here are the highlights:</p>
<blockquote><p>2013-09-05T03:20:44  <jeevan_ullas> you might want to set the jdk in CLOUD_OPTS in eucalyptus.conf in &#47;etc&#47;eucalyptus&#47;<br />
2013-09-05T03:20:50  <jeevan_ullas> to point to jdk 1.7<&#47;blockquote></p>
<p>The issue is this:   since eucalyptus requires ANT 1.8.3 (on Ubuntu 12.04.3) ANT has a Java 6 dependency.  BUT Eucalyptus requires Java 7 for compilation.  What happened is that the Java 6 became the default java.  <code>java --version<&#47;code> rendered this:<br />
<code>java version "1.6.0_27"<br />
OpenJDK Runtime Environment (IcedTea6 1.12.6) (6b27-1.12.6-1ubuntu0.12.04.2)<br />
OpenJDK 64-Bit Server VM (build 20.0-b12, mixed mode)<&#47;code></p>
<p>And there in lies the problem - when you edit the <code>&#47;etc&#47;eucalyptus&#47;eucalyptus.conf<&#47;code> file you find an option at the top that says:<code> #CLOUD_OPTS="--java-home=&#47;usr&#47;lib&#47;jvm&#47;default-java --db-home=&#47;usr&#47;lib&#47;postgresql&#47;9.1"<&#47;code>  And there is the problem.  The system thinks that Java 6 is the default-java so the initialize script is trying to run the <code>com&#47;eucalyptus&#47;bootstrap&#47;SystemBootstrapper<&#47;code> class but it needs Java 7 to compile properly.  </p>
<p>The answer Mr. Peabody? <a href="https:&#47;&#47;blog.sat.iit.edu&#47;wp-content&#47;uploads&#47;2013&#47;09&#47;mrpeabody.jpg"><img src="https:&#47;&#47;blog.sat.iit.edu&#47;wp-content&#47;uploads&#47;2013&#47;09&#47;mrpeabody-150x150.jpg" alt="mrpeabody" width="150" height="150" class="alignnone size-thumbnail wp-image-975" &#47;><&#47;a></p>
<p>Change the value of the <code>CLOUD_OPTS<&#47;code> to be the default value of where Java 7 is installed.  That would be <code>&#47;usr&#47;lib&#47;jvm&#47;java-7-openjdk-amd64<&#47;code> if you are following <a href="https:&#47;&#47;alinush.org&#47;2013&#47;07&#47;21&#47;how-to-compile-and-install-eucalyptus-3-3-0-on-ubuntu-13-04-from-github-sources-cloud-in-a-box&#47;" title="https:&#47;&#47;alinush.org&#47;2013&#47;07&#47;21&#47;how-to-compile-and-install-eucalyptus-3-3-0-on-ubuntu-13-04-from-github-sources-cloud-in-a-box&#47;">Alin Tomescu's blog<&#47;a>.</p>
<p>And there you go.  And now you are ready...  Thanks goes to jeevan_ullas at <a href="http:&#47;&#47;webchat.freenode.net&#47;?channels=eucalyptus" title="http:&#47;&#47;webchat.freenode.net&#47;?channels=eucalyptus">http:&#47;&#47;webchat.freenode.net&#47;?channels=eucalyptus<&#47;a> and of course <a href="https:&#47;&#47;alinush.org&#47;" title="https:&#47;&#47;alinush.org&#47;">Alin Tomescu's blog<&#47;a><br />
<a href="https:&#47;&#47;blog.sat.iit.edu&#47;wp-content&#47;uploads&#47;2013&#47;09&#47;20585-kamehameha.jpg"><img src="https:&#47;&#47;blog.sat.iit.edu&#47;wp-content&#47;uploads&#47;2013&#47;09&#47;20585-kamehameha-300x238.jpg" alt="20585-kamehameha" class="alignnone size-medium wp-image-976" &#47;><&#47;a></p>
