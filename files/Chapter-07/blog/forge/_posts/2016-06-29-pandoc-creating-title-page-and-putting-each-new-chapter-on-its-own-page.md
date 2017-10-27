---
layout: post
status: publish
published: true
title: Pandoc - Argument of \Paragraph has an extra }
author:
  display_name: hajek
  login: hajek
  email: hajek@iit.edu
  url: ''
author_login: hajek
author_email: hajek@iit.edu
wordpress_id: 1812
wordpress_url: https://forge.sat.iit.edu/?p=1812
date: '2016-06-29 10:30:49 -0500'
date_gmt: '2016-06-29 15:30:49 -0500'
categories:
- Pandoc
tags:
- textbook
- pandoc
- pdf
comments: []
---
<p>Writing <a href="https:&#47;&#47;github.com&#47;jhajek&#47;Linux-text-book-part-1">a textbook for a class<&#47;a> -- as I am doing -- is hard enough, I am using <a href="http:&#47;&#47;www.pandoc.org">Pandoc<&#47;a> for my choice of <a href="http:&#47;&#47;daringfireball.net&#47;projects&#47;markdown&#47;">markdown<&#47;a> to produce PDF and ePub. </p>
<p>There are differences and trade offs trying to take a common markdown code base and publish it to different formats.  Currently I don't have a feature parity between both formats they both have extra items the other one doesn't.  </p>
<p>Recently I reinstalled Pandoc with <a href="http:&#47;&#47;miktex.org&#47;">MikTeX<&#47;a> for Windows and <a href="https:&#47;&#47;www.tug.org&#47;mactex&#47;morepackages.html">BasicTeX<&#47;a> for Mac, and deb package <a href="http:&#47;&#47;tex.stackexchange.com&#47;questions&#47;28528&#47;best-way-to-install-packages-for-texlive-in-ubuntu">texlive<&#47;a> for Ubuntu 16.04.  These packages are needed to turn Pandoc markdown into PDFs via a LateX library.</p>
<p>Installing the latest version of Pandoc 1.17.1 and running my build script to produce a PDF all of a sudden generated this error...  </p>
<p><a href="/assets/2016&#47;06&#47;pandoc-error.png"><img src="/assets/2016&#47;06&#47;pandoc-error.png" alt="pandoc-error" width="1348" height="946" class="aligncenter size-full wp-image-1815" &#47;><&#47;a></p>
<p>Oh no... this error is not very helpful as I have 13 chapters worth of material, what could be causing this error?  It could be anywhere!   I did what any good detective did, I removed each chapter 1 by 1 and rebuilt the PDF trying to narrow down where the error is by process of elimination.  </p>
<p>I went all the way down - stripping all the chapters out but one.  That was the title page.  The file titlesec.tex is a LaTeX style formatting command to generate a title page and also make sure that each new chapter starts on its own page.  This worked for the entire last year using this command line option:</p>
<p>Here is the full code that throws the error:</p>
<p><code>pandoc --toc -V geometry:margin=1in --number-sections --include-in-header .&#47;title&#47;titlesec.tex -s -o .&#47;output&#47;pdf&#47;Understanding-the-Technology-and-Philosophy-of-Linux-Part-I-$STAMP.pdf  .&#47;Chapter-01&#47;chapter-01.md .&#47;Chapter-02&#47;chapter-02.md .&#47;Chapter-03&#47;chapter-03.md .&#47;Chapter-04&#47;chapter-04.md .&#47;Chapter-05&#47;chapter-05.md .&#47;Chapter-06&#47;chapter-06.md .&#47;Chapter-07&#47;chapter-07.md .&#47;Chapter-08&#47;chapter-08.md .&#47;Chapter-09&#47;chapter-09.md .&#47;Chapter-10&#47;chapter-10.md .&#47;Chapter-11&#47;chapter-11.md .&#47;Chapter-12&#47;chapter-12.md .&#47;Chapter-13&#47;chapter-13.md .&#47;Chapter-14&#47;chapter-14.md .&#47;Chapter-15&#47;chapter-15.md .&#47;Appendix-A&#47;Appendix-A.md .&#47;Appendix-B&#47;Appendix-B.md .&#47;Appendix-C&#47;Appendix-C.md<&#47;code></p>
<p>Strange.  The quick fix for this error was to remove the offending line of code:</p>
<p><code>--include-in-header .&#47;title&#47;titlesec.tex<&#47;code></p>
<p>Replacing it with this line:<br />
<code>-V documentclass=report<&#47;code></p>
<p>Which then generates the expected PDF -- compare the difference below:</p>
<p><a href="/assets/2016&#47;06&#47;pandoc-broke.png"><img src="/assets/2016&#47;06&#47;pandoc-broke.png" alt="pandoc-broke" width="1143" height="168" class="aligncenter size-full wp-image-1814" &#47;><&#47;a></p>
<p><a href="/assets/2016&#47;06&#47;pandoc-fix.png"><img src="/assets/2016&#47;06&#47;pandoc-fix.png" alt="pandoc-fix" width="1160" height="172" class="aligncenter size-full wp-image-1816" &#47;><&#47;a></p>
<p><a href="/assets/2016&#47;06&#47;pandoc-success.png"><img src="/assets/2016&#47;06&#47;pandoc-success.png" alt="pandoc-success" width="1318" height="326" class="aligncenter size-full wp-image-1813" &#47;><&#47;a></p>
