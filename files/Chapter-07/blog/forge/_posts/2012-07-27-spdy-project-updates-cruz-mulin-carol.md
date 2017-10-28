---
layout: post
status: publish
published: true
title: SPDY Project Updates (Cruz, Mulin, Carol)
author:
  display_name: ctovar
  login: ctovar
  email: ctovar@hawk.iit.edu
  url: ''
author_login: ctovar
author_email: ctovar@hawk.iit.edu
wordpress_id: 391
wordpress_url: http://blog.sat.iit.edu/?p=391
date: '2012-07-27 10:37:30 -0500'
date_gmt: '2012-07-27 16:37:30 -0500'
categories:
- Uncategorized
tags: []
comments: []
---
<p>We have installed the mod_spdy on Ubuntu Server 12.04 and set configured an Apache server.</p>
<p>We did some testing and found some surprising results as to what Google says the speeds should be. We initially wanted to test the flags test at <a href="https:&#47;&#47;www.modspdy.com&#47;world-flags&#47;">https:&#47;&#47;www.modspdy.com&#47;world-flags&#47;<&#47;a>, but unfortunately it seems like this website is no longer functioning.┬&aacute; We browsed around the web looking for SPDY enabled websites, but could not find any other than Google and Twitter.┬&aacute; With limited SPDY sights we were limited on how to test actual SPDY results versus non SPDY pages.</p>
<p>I would say SPDY does not allow all users of the internet viable usage of this updated technology. In order for sites to run SPDY, an SSL certificate is needed, therefore an average webmaster, may not be able to acquire or pay for an SSL certificate, limiting the usage of SPDY to maybe corporate websites and businesses.</p>
<p>Overall our results were somewhat disappointing, as we did not find much difference in loading times when SPDY was enabled and when it was not.┬&aacute; A SPDY enabled browsers loaded pages at an average of .259 seconds versus non-SPDY enabled browser at .282 seconds.┬&aacute; Google states that "we&Gamma;&Ccedil;&Ouml;ve seen mod_spdy reduce load times by more than 50%."┬&aacute; Clearly by our findings this was not the case.</p>
