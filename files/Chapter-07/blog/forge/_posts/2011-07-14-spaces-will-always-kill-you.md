---
layout: post
status: publish
published: true
title: Spaces Will Always Kill You...
author:
  display_name: hajek
  login: hajek
  email: hajek@iit.edu
  url: ''
author_login: hajek
author_email: hajek@iit.edu
excerpt: "Spaces will always kill you...\r\nPerhpas you have heard the advice<strong>
  never never never<&#47;strong> put spaces in a file name?┬&aacute; Perhaps you ignored
  that advice and did it anyway? And then what happened?┬&aacute; Exactly.\r\n\r\nThis
  point is no more vitally important than in dealing with vmware esx and esxi servers.
  ┬&aacute;Especially when dealing with datastores. See this link for the gory details
  <a href=\"http:&#47;&#47;kb.vmware.com&#47;kb&#47;1010832\" target=\"_blank\">http:&#47;&#47;kb.vmware.com&#47;kb&#47;<wbr>1010832<&#47;wbr><&#47;a>.\r\n\r\nI
  have my vcenter instance and I am managing 3 esxi-servers.\r\n\r\nIf I want to download
  the entire .vmdk (virtual machine) for backup I would simply change my options in
  vCenter and goto DATASTORES.\r\n\r\n"
wordpress_id: 18
wordpress_url: http://aurora.rice.iit.edu/?p=18
date: '2011-07-14 21:01:59 -0500'
date_gmt: '2011-07-15 03:01:59 -0500'
categories:
- Uncategorized
tags: []
comments: []
---
<p>Spaces will always kill you...<br />
Perhpas you have heard the advice<strong> never never never<&#47;strong> put spaces in a file name?┬&aacute; Perhaps you ignored that advice and did it anyway? And then what happened?┬&aacute; Exactly.</p>
<p>This point is no more vitally important than in dealing with vmware esx and esxi servers. ┬&aacute;Especially when dealing with datastores. See this link for the gory details <a href="http:&#47;&#47;kb.vmware.com&#47;kb&#47;1010832" target="_blank">http:&#47;&#47;kb.vmware.com&#47;kb&#47;<wbr>1010832<&#47;wbr><&#47;a>.</p>
<p>I have my vcenter instance and I am managing 3 esxi-servers.</p>
<p>If I want to download the entire .vmdk (virtual machine) for backup I would simply change my options in vCenter and goto DATASTORES.</p>
<p><a id="more"></a><a id="more-18"></a></p>
<p><a href="http:&#47;&#47;aurora.rice.iit.edu&#47;wp-content&#47;uploads&#47;2011&#47;07&#47;pic4.png"><img class="alignnone size-thumbnail wp-image-22" title="pic4" src="http:&#47;&#47;aurora.rice.iit.edu&#47;wp-content&#47;uploads&#47;2011&#47;07&#47;pic4-150x150.png" alt="" width="150" height="150" &#47;><&#47;a></p>
<p>When I browse a datastore &Gamma;&Ccedil;&ocirc; looking for a virtual machine here is what I see:<br />
<a href="http:&#47;&#47;aurora.rice.iit.edu&#47;wp-content&#47;uploads&#47;2011&#47;07&#47;pic21.png"><img class="alignnone size-thumbnail wp-image-20" title="pic2" src="http:&#47;&#47;aurora.rice.iit.edu&#47;wp-content&#47;uploads&#47;2011&#47;07&#47;pic21-150x150.png" alt="" width="150" height="150" &#47;><&#47;a></p>
<p>I select datastore one and I see two virtual machines. ┬&aacute;Cicero and<br />
Danada. ┬&aacute;Let me click on Cicero and I can browse the datastore.</p>
<p><a href="http:&#47;&#47;aurora.rice.iit.edu&#47;wp-content&#47;uploads&#47;2011&#47;07&#47;pic5.png"><img class="alignnone size-thumbnail wp-image-23" title="pic5" src="http:&#47;&#47;aurora.rice.iit.edu&#47;wp-content&#47;uploads&#47;2011&#47;07&#47;pic5-150x150.png" alt="" width="150" height="150" &#47;><&#47;a></p>
<p>Ok now I want to click on Danada and browse its Datastore&Gamma;&Ccedil;&ordf;</p>
<p><a href="http:&#47;&#47;aurora.rice.iit.edu&#47;wp-content&#47;uploads&#47;2011&#47;07&#47;picture3.png"><img class="alignnone size-thumbnail wp-image-21" title="picture3" src="http:&#47;&#47;aurora.rice.iit.edu&#47;wp-content&#47;uploads&#47;2011&#47;07&#47;picture3-150x150.png" alt="" width="150" height="150" &#47;><&#47;a></p>
<p>Notice all the content is missing! ┬&aacute;Trust me it is still there as this<br />
is an important server and if it went missing, I just might go missing<br />
as well. ┬&aacute;So what is going on? ┬&aacute;Remember the link I posted at the top?<br />
Count the number of characters in the virtual machine name of danada&Gamma;&Ccedil;&ordf;<br />
Notice how in the datastore window it seems to cut off. ┬&aacute;(Compare<br />
that with the pic 1 and you will see a longer name.) ┬&aacute;(Hint Also I<br />
fixed the problem as well replacing &Gamma;&Ccedil;&yen; &Gamma;&Ccedil;&yen; with &Gamma;&Ccedil;&pound;_&Gamma;&Ccedil;&yen;.)</p>
<p>It turns out if you have a space in the 32nd place of the name of your<br />
vm, the datastore cannot see it! ┬&aacute; So lets do some quick counting&Gamma;&Ccedil;&ordf;</p>
<p><a href="http:&#47;&#47;aurora.sat.iit.edu&#47;wp-content&#47;uploads&#47;2011&#47;07&#47;32space1.png"><img class="alignnone size-full wp-image-36" title="32space" src="http:&#47;&#47;aurora.sat.iit.edu&#47;wp-content&#47;uploads&#47;2011&#47;07&#47;32space1.png" alt="" width="327" height="70" &#47;><&#47;a></p>
<p>Sure enough 32nd char is a space. ┬&aacute;Now what to do? ┬&aacute;Simple Vmware<br />
recommends to rename the vm and eliminate the space in that spot (I<br />
now go further and forbid all spaces ever) ┬&aacute;and then you need to<br />
migrate the vm to another system and the content will appear again. ┬&aacute;I<br />
tried this and it works&Gamma;&Ccedil;&ordf; the problem of the missing data solved.</p>
<p>System Manager</p>
