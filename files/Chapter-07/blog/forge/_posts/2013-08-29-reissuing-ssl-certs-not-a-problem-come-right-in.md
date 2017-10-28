---
layout: post
status: publish
published: true
title: Reissuing SSL Certs?  Not a problem - come right in.
author:
  display_name: hajek
  login: hajek
  email: hajek@iit.edu
  url: ''
author_login: hajek
author_email: hajek@iit.edu
wordpress_id: 928
wordpress_url: https://blog.sat.iit.edu/?p=928
date: '2013-08-29 12:55:35 -0500'
date_gmt: '2013-08-29 17:55:35 -0500'
categories:
- Uncategorized
tags: []
comments: []
---
<p><strong>Background <&#47;strong>- the department has a 15 license wildcard cert - *.sat.iit.edu issued by my good friends at Trustwave (which is in Chicago and had really killer customer support btw)  </p>
<p>All 15 licenses were issued - some of the servers had been rebuilt since their cert was issues - meaning that the public&#47;private key from those servers was now invalid and would throw the browser warning screen below...</p>
<p><a href="https:&#47;&#47;blog.sat.iit.edu&#47;wp-content&#47;uploads&#47;2013&#47;08&#47;danger_will_robinson.jpg"><img src="https:&#47;&#47;blog.sat.iit.edu&#47;wp-content&#47;uploads&#47;2013&#47;08&#47;danger_will_robinson-150x150.jpg" alt="danger_will_robinson" width="150" height="150" class="alignnone size-thumbnail wp-image-929" &#47;><&#47;a></p>
<p>So what do to?   After talking with tech support I understood this:  the initial certificate was signed with Trustwave's root certificate.  But since this was an re=issued certificate their is now an additional chain.cer (chain certificate)?</p>
<p>Why?  Because the new certificate is signed by the intermediate level certificate that then chains to the root cert - follow?</p>
<p><strong>TL:DR;<&#47;strong></p>
<blockquote><p>The Intermediate comes as either a ".cer" or ".crt" extension. Technically speaking; the ".cer" and ".crt" extensions are one in the same. If your instance of Apache requires that you use ".crt" files, then you can simply rename a ".cer" file to ".crt" Note: At this point, you should have a file named "chain.cer", "ovca.crt", or "dvca.crt". Moving forward, this FAQ will refer to this file as the intermediate file.<&#47;blockquote></p>
<blockquote><p>
Editing the httpd.conf or ssl.conf file  (Ubuntu it is &#47;etc&#47;apache2&#47;sites-enabled&#47;default-ssl)<br />
Your host section will need to contain the following directives:</p>
<p>"SSLCACertificateFile" - Set this attribute to point to the appropriate Trustwave root CA certificate. The Trustwave root CA certificate can downloaded from the following URL:  <-- Optional</p>
<p>"SSLCertificateChainFile" - Set this attribute to point to the intermediate file.  <-- where you need to put your chain.cer file</p>
<p>"SSLCertificateFile" - Set this attribute to point to the end entity certificate (the "[yourdomain].cer" file you received from Trustwave)  <-- You need the reissued STAR.youdomain.here.cer </p>
<p>"SSLCertificateKeyFile" - Set this attribute to point to the private key that was generated with your CSR.  -- the same key file from you CSR request<&#47;blockquote></p>
<p>Remember restart Apache! <code>(sudo service apache2 restart)<&#47;code>   If there is an error <code>tail &#47;var&#47;log&#47;apache2&#47;error.log<&#47;code></p>
<p>If everything works you will see this screen...<br />
<a href="https:&#47;&#47;blog.sat.iit.edu&#47;wp-content&#47;uploads&#47;2013&#47;08&#47;SesameStreet-Group_preview.jpg"><img src="https:&#47;&#47;blog.sat.iit.edu&#47;wp-content&#47;uploads&#47;2013&#47;08&#47;SesameStreet-Group_preview-255x300.jpg" alt="SesameStreet-Group_preview" width="255" height="300" class="alignnone size-medium wp-image-933" &#47;><&#47;a></p>
<p>take care</p>
