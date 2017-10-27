---
layout: post
status: publish
published: true
title: Eucalyptus Euca-console leap-year bug and fix
author:
  display_name: hajek
  login: hajek
  email: hajek@iit.edu
  url: ''
author_login: hajek
author_email: hajek@iit.edu
wordpress_id: 1648
wordpress_url: https://forge.sat.iit.edu/?p=1648
date: '2016-02-29 11:45:36 -0600'
date_gmt: '2016-02-29 17:45:36 -0600'
categories:
- Uncategorized
- tools
- Eucalyptus
tags:
- Eucalyptus
- euca-console
- HP Eucalyptus
- HP Eucalyptus 4.0.2
comments: []
---
<p>Woke up this morning to an <strong>Internal Server Error<&#47;strong> after logging into the Euca-Console.  </p>
<p>Looking at the error logs this came up:</p>
<p><a href="/assets/2016&#47;02&#47;desktop-1_002.png" rel="attachment wp-att-1649"><img src="/assets/2016&#47;02&#47;desktop-1_002-300x169.png" alt="desktop 1_002" width="300" height="169" class="alignnone size-medium wp-image-1649" &#47;><&#47;a></p>
<p>Leap year bug...  luckily everyone else's software caught fire so there was a quick solution here:</p>
<p><a href="https:&#47;&#47;groups.google.com&#47;a&#47;eucalyptus.com&#47;forum&#47;#!topic&#47;euca-users&#47;mqhYXCzAfaE">https:&#47;&#47;groups.google.com&#47;a&#47;eucalyptus.com&#47;forum&#47;#!topic&#47;euca-users&#47;mqhYXCzAfaE<&#47;a></p>
<p>Fix is here:<br />
<code>by changing the line "expires = datetime.today().replace(year=2003)" to expires = datetime.today().replace(year=2016) in &#47;usr&#47;lib&#47;python2.6&#47;site-packages&#47;Beaker-1.5.4-py2.6.egg&#47;beaker&#47;session.py and restarted the console service and it works fine.<&#47;code></p>
