---
layout: post
status: publish
published: true
title: Perl CPAN Reconfigure - I can never remember this
author:
  display_name: hajek
  login: hajek
  email: hajek@iit.edu
  url: ''
author_login: hajek
author_email: hajek@iit.edu
wordpress_id: 65
wordpress_url: http://aurora.sat.iit.edu/?p=65
date: '2011-09-19 14:30:33 -0500'
date_gmt: '2011-09-19 20:30:33 -0500'
categories:
- tools
tags:
- Perl
- CPAN
comments: []
---
<p>The first time you use the Perl module CPAN, a script is executed in order to properly configure several options (like the location of tar, gzip and unzip files, the cache size for the build directory, etc).</p>
<p>If you want to modify these configuration options at a later time, you can do it in 2 ways:</p>
<p>- Manually, modifying the configuration files</p>
<p>You can either modify the user-specific file (usually ~&#47;.cpan&#47;CPAN&#47;MyConfig.pm) or the system-wide configuration file (stored somewhere in the perl module directory tree, look for a directory named CPAN that holds a file named Config.pm)</p>
<p>- Automatically, using the CPAN module</p>
<p>To do this, execute the following:</p>
<p><strong>perl -MCPAN -e shell<&#47;strong></p>
<p>When you're in the cpan shell, execute:</p>
<p><strong>cpan> o conf init<&#47;strong> &Gamma;&ccedil;&Eacute; For the life of me I can never remember this!!</p>
<p>Thanks to Original Post at <a title="http:&#47;&#47;www.perlhowto.com&#47;reconfigure_cpan_module_preferences" href="http:&#47;&#47;www.perlhowto.com&#47;reconfigure_cpan_module_preferences" target="_blank">http:&#47;&#47;www.perlhowto.com&#47;reconfigure_cpan_module_preferences<&#47;a></p>
