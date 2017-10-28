---
layout: post
status: publish
published: true
title: Euca2ools 3.1.x installation and connection testing to Eucalyptus 4.0.2
author:
  display_name: hajek
  login: hajek
  email: hajek@iit.edu
  url: ''
author_login: hajek
author_email: hajek@iit.edu
wordpress_id: 1639
wordpress_url: https://forge.sat.iit.edu/?p=1639
date: '2016-02-23 14:06:10 -0600'
date_gmt: '2016-02-23 20:06:10 -0600'
categories:
- Cloud
- VPN
- Eucalyptus
tags:
- cloud
- IIT
- Eucalyptus
- VPN
- euca2ools
- Illinois Tech
- HP Eucalyptus 4.0.2
comments: []
---
<p>For installing Euca2ools 3.1.x for use on Eucalyptus 4.0.2 (yes we are a couple of versions behind) here is the instructions and tests:</p>
<p>Pre-reqs may be needed: (Ubuntu)<br />
<code><br />
sudo apt-get install git build-essential python-setuptools python-dev libxslt1-dev libxml2 libxml2-dev zlib1g-dev<br />
<&#47;code></p>
<p>On Mac or Linux (<a href="https:&#47;&#47;forge.sat.iit.edu&#47;2015&#47;10&#47;getting-shrewsoft-vpn-2-2-1-to-compile-on-ubuntu-15-04-for-use-at-illinois-tech&#47;">preferably Ubuntu because the school's VPN software doesn't compile on RedHat&#47;Fedora<&#47;a>)</p>
<p><code>git clone <a href="https:&#47;&#47;github.com&#47;jhajek&#47;euca2ools.git">https:&#47;&#47;github.com&#47;jhajek&#47;euca2ools.git<&#47;a><&#47;code></p>
<p><code>git branch -a<&#47;code> </p>
<p>The output of the branch command will look like below: [Yours may very as this list changes over time.  The command itself is just a command that lists previous branches and is a check point to make sure you are in the correct place.]</p>
<blockquote><p>  remotes&#47;origin&#47;3.0-maint<br />
  remotes&#47;origin&#47;3.1-maint<br />
  remotes&#47;origin&#47;HEAD -> origin&#47;mast<br />
  remotes&#47;origin&#47;maint-3.0<br />
  remotes&#47;origin&#47;maint-3.1<br />
  remotes&#47;origin&#47;maint-3.2<br />
  remotes&#47;origin&#47;master<br />
<&#47;blockquote></p>
<p>This command will move the github repo HEAD to point to euca2ools 3.1 which is the<br />
version compatible with eucalyptus 4.0.2<br />
<code>git checkout origin&#47;maint-3.1<&#47;code> </p>
<p>Type this command inside the euca2ools directory to install<br />
<code>python setup.py install (add sudo if you are on Linux - no sudo on Mac)<&#47;code></p>
<p>Note - depending on what version of Ubuntu you are using (I am looking at you Linux Mint 17.x) May have an older version of the package python-requests (which includes python-requestbuilder)  </p>
<p><a href="/assets/2016&#47;02&#47;python-requestbuilder-error.png" rel="attachment wp-att-1683"><img src="/assets/2016&#47;02&#47;python-requestbuilder-error-300x26.png" alt="python-requestbuilder-error" width="300" height="26" class="alignnone size-medium wp-image-1683" &#47;><&#47;a></p>
<p>If you receive the error message above - you need to remove the python-requests default package and allow it to be installed by the python installer:<br />
<code>sudo apt-get remove python-requests<&#47;code></p>
<p>** This may or may not be necessary depending on how credentials were generated for you...<br />
**Finally you need to source the credentials file you were sent (unzip the<br />
file into a secure directory by typing: (your credential file may not be named <em>you-credentials.zip<&#47;em><br />
<code>unzip -d creds your-credentials.zip<br />
source eucarc<&#47;code></p>
<p>You can add this to your ~&#47;.bashrc as well so that when you login these<br />
credentials will be automatically sourced.</p>
<p>Here is how to do that - note that it includes<em> my HOME directory <&#47;em>and change<br />
this to your HOME directory - best to use absolute PATH<br />
<code># User specific aliases and functions<br />
source &#47;home&#47;eucauser&#47;creds&#47;eucarc<&#47;code></p>
<p>Final test - from the command line type:<br />
<code>euca-version<br />
euca-describe-instances<br />
euca-describe-availability-zones verbose<&#47;code></p>
<p>Complete documentation on euca2ools usage is here:<br />
<a href="https:&#47;&#47;region-b.geo-1.objects.hpcloudsvc.com&#47;v1&#47;10625742765718&#47;generated-pdfs&#47;Eucalyptus_4.0&#47;user-guide-4.0.2.pdf">https:&#47;&#47;region-b.geo-1.objects.hpcloudsvc.com&#47;v1&#47;10625742765718&#47;generated-pdfs&#47;Eucalyptus_4.0&#47;user-guide-4.0.2.pdf<&#47;a></p>
<p>You can log directly into the web console via going to<br />
<a href="https:&#47;&#47;lexington.sat.iit.edu">https:&#47;&#47;lexington.sat.iit.edu <&#47;a></p>
<p>take care<br />
Jeremy Hajek</p>
