---
layout: post
status: publish
published: true
title: Eucalyptus 4.0.2 How to solve EUCA-7376 error -- High Concurrent Locks on DB
  Causing Cloud Performance Issues
author:
  display_name: hajek
  login: hajek
  email: hajek@iit.edu
  url: ''
author_login: hajek
author_email: hajek@iit.edu
wordpress_id: 1410
wordpress_url: https://forge.sat.iit.edu/?p=1410
date: '2015-06-11 15:23:27 -0500'
date_gmt: '2015-06-11 20:23:27 -0500'
categories:
- Cloud
tags:
- Eucalyptus
comments: []
---
<p><a href="https:&#47;&#47;forge.sat.iit.edu&#47;wp-content&#47;uploads&#47;2015&#47;06&#47;eucalyptus-logo.jpg"><img src="https:&#47;&#47;forge.sat.iit.edu&#47;wp-content&#47;uploads&#47;2015&#47;06&#47;eucalyptus-logo-150x150.jpg" alt="eucalyptus-logo" width="150" height="150" class="alignnone size-thumbnail wp-image-1413" &#47;><&#47;a></p>
<p>Every six months our Eucalyptus Cloud has this problem: <a href="https:&#47;&#47;eucalyptus.atlassian.net&#47;browse&#47;EUCA-7376">https:&#47;&#47;eucalyptus.atlassian.net&#47;browse&#47;EUCA-7376<&#47;a>   We were on 4.0.1 and now 4.0.2.  I had posted this issue to the Eucalyptus Users Google Groups Back in October of 2014 <a href="https:&#47;&#47;groups.google.com&#47;a&#47;eucalyptus.com&#47;forum&#47;#!searchin&#47;euca-users&#47;EUCA-7376&#47;euca-users&#47;nHM6BXPRoOo&#47;yXnlwDEh1SwJ">https:&#47;&#47;groups.google.com&#47;a&#47;eucalyptus.com&#47;forum&#47;#!searchin&#47;euca-users&#47;EUCA-7376&#47;euca-users&#47;nHM6BXPRoOo&#47;yXnlwDEh1SwJ<&#47;a></p>
<p>The first time we solved the issue by just reformatting everything and reinstall.  (That worked but we didn't know why...)</p>
<p>The first symptom of this is that the Eucaconsole (installed locally on the CLC) would not receive login requests -- nothing would happen upon login.  This was our first hint that it was a service problem.</p>
<p>Then we started seeing these errors in the Postgress logs:</p>
<p><code><br />
ERROR:  update or delete on table "metadata_extant_network" violates foreign key constraint "fkbdc151865dab4005" on table "metadata_network_indices"<br />
DETAIL:  Key (id)=(8a1f98a840b2dcf20140be92918a0f8e) is still referenced from table "metadata_network_indices".<br />
STATEMENT:  delete from metadata_extant_network where id=$1 and version=$2<br />
ERROR:  update or delete on table "metadata_extant_network" violates foreign key constraint "fkbdc151865dab4005" on table "metadata_network_indices"<br />
DETAIL:  Key (id)=(8a1f98a840b2dcf20140be5722140f59) is still referenced from table "metadata_network_indices".<br />
STATEMENT:  delete from metadata_extant_network where id=$1 and version=$2<br />
ERROR:  update or delete on table "metadata_extant_network" violates foreign key constraint "fkbdc151865dab4005" on table "metadata_network_indices"<br />
DETAIL:  Key (id)=(8a1f98a840b2dcf20140bde9407c0ed6) is still referenced from table "metadata_network_indices".<br />
STATEMENT:  delete from metadata_extant_network where id=$1 and version=$2<br />
ERROR:  update or delete on table "metadata_extant_network" violates foreign key constraint "fkbdc151865dab4005" on table "metadata_network_indices"<br />
DETAIL:  Key (id)=(8a1f98a840b2dcf20140bd7b64b60e5d) is still referenced from table "metadata_network_indices".<br />
STATEMENT:  delete from metadata_extant_network where id=$1 and version=$2<br />
ERROR:  update or delete on table "metadata_extant_network" violates foreign key constraint "fkbdc151865dab4005" on table "metadata_network_indices"<br />
DETAIL:  Key (id)=(8a1f98a840b2dcf20140bf6e4c1a107c) is still referenced from table "metadata_network_indices".<br />
STATEMENT:  delete from metadata_extant_network where id=$1 and version=$2<br />
<&#47;code></p>
<p>So we made like <a href="https:&#47;&#47;en.wikipedia.org&#47;wiki&#47;Dig_Dug">DigDug<&#47;a> found out what may have been causing this.</p>
<p><strong>Solution:<&#47;strong><br />
We noticed that the dhcp service failed to start on the CC.  Not dhpcd but dnsmasq and these 3 steps fixed our problem.<br />
1. The postgres is caused by DHCP. That needs to be fixed. We need to restart dhcp and then the restart the CC to fix the dhcp.<br />
2. Restart the CLC to get rid of the metadata.<br />
3. nginx service on CLC service needs to be manually started after the dhcp is fixed and the CLC is rebooted</p>
<p>* In addition the SC went to state broken during this time - I believe because of the postgress errors and process breaking communication</p>
<p>Logs available upon request.</p>
