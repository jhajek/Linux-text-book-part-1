---
layout: post
status: publish
published: true
title: Powershell Script--Compare two directories
author:
  display_name: acabrer3
  login: acabrer3
  email: acabrer3@hawk.iit.edu
  url: ''
author_login: acabrer3
author_email: acabrer3@hawk.iit.edu
wordpress_id: 132
wordpress_url: http://aurora.sat.iit.edu/?p=132
date: '2011-09-15 10:16:49 -0500'
date_gmt: '2011-09-15 16:16:49 -0500'
categories:
- Uncategorized
tags:
- script
- compare directories
comments: []
---
<p><strong>Issue 1: How to compare two directories?<&#47;strong></p>
<p><strong>Resolution<&#47;strong>: Take a snapshot of the original directory, wait a certain amount of time to take a second snapshot, and then compare the two.</p>
<p style="text-align: left"><strong>Reference<&#47;strong>: See the article, &Gamma;&Ccedil;&pound;Finding New Files and Folders.&Gamma;&Ccedil;&yen; <a href="http:&#47;&#47;powershell.com&#47;cs&#47;blogs&#47;tobias&#47;archive&#47;2009&#47;01&#47;09&#47;tipps-amp-tricks-using-compare-object.aspx">http:&#47;&#47;powershell.com&#47;cs&#47;blogs&#47;tobias&#47;archive&#47;2009&#47;01&#47;09&#47;tipps-amp-tricks-using-compare-object.aspx<&#47;a><&#47;p><br />
<strong>Issue 2: How to get the output of Compare-Object so that it can be emailed to the user?<&#47;strong></p>
<p><strong>Resolution<&#47;strong>: Append the output to a text file. I used the &Gamma;&Ccedil;&ocirc;PassThru parameter and >$report.txt to append the output to a text file.</p>
<p><strong>Reference<&#47;strong>: <a href="http:&#47;&#47;technet.microsoft.com&#47;en-us&#47;library&#47;dd347568.aspx">http:&#47;&#47;technet.microsoft.com&#47;en-us&#47;library&#47;dd347568.aspx<&#47;a></p>
<p><strong>Issue 3: How to send an email through powershell?<&#47;strong></p>
<p><strong>Resolution<&#47;strong>: Google search for &Gamma;&Ccedil;&pound;Send smtp email with powershell&Gamma;&Ccedil;&yen; (see script for syntax to send an email)</p>
<p><strong>Notes<&#47;strong>: As long as you are sending within the iit.edu domain, you do not need to worry about credentials. In addition, it does not matter what email address you type into the &Gamma;&Ccedil;&pound;from &Gamma;&Ccedil;&pound; field, as it is not checked to see if it is a valid email address or not.</p>
<p><strong>Issue 4: How to setup the script so that it only emails the user when something has changed in the directory?<&#47;strong></p>
<p><strong>Resolution<&#47;strong>: Setup an IF statement. The IF statement in the script says that if the report.txt file is greater than 0kb, call the function &Gamma;&Ccedil;&pound;sendEmail&Gamma;&Ccedil;&yen;</p>
<p><strong>Reference<&#47;strong>: <a href="http:&#47;&#47;www.powershellpro.com&#47;powershell-email-alerts&#47;210&#47;">http:&#47;&#47;www.powershellpro.com&#47;powershell-email-alerts&#47;210&#47;<&#47;a></p>
<p><strong>Issue 5: ┬&aacute;How to put the script in a loop and have it wait a certain amount of time before taking the snapshot again?<&#47;strong></p>
<p><strong>Resolution<&#47;strong>: use the start-sleep Cmdlet</p>
<p><strong>Reference<&#47;strong>: <a href="http:&#47;&#47;technet.microsoft.com&#47;en-us&#47;library&#47;ee177002.aspx">http:&#47;&#47;technet.microsoft.com&#47;en-us&#47;library&#47;ee177002.aspx<&#47;a></p>
<p>The script is provided below:</p>
<pre lang="PowerShell" line="1">
## This script can monitor multiple directories<br />
## Change the information below as needed</p>
<p>## directory to monitor<br />
## change as necessary<br />
$dir="x:\folder1","x:\folder2","x:\folder3"</p>
<p>## Generated report of new files<br />
## make sure the location of the report file is not in the same location as the directory you a monitoring<br />
$report="X:\report.txt"</p>
<p>## Email portion, change as necessary<br />
$EmailTo="Firstname Lastname <username@domain.com>"<br />
$EmailSubject="Subject Goes Here"<br />
$EmailBody="Body Goes Here"<br />
$EmailFrom="Firstname Lastname <username@domain.com>"<br />
$EmailSMTPServer="mail.domain.com"</p>
<p>## =========================================================<br />
## ======== PLEASE DO NOT EDIT SCRIPT BELOW ================<br />
## =========================================================</p>
<p>$val=1</p>
<p>while($val -eq 1){</p>
<p>$shot2 = Dir $dir</p>
<p>Compare-Object $shot1 $shot2 -PassThru >$report</p>
<p>function sendEmail{<br />
send-mailmessage -from $EmailFrom -to $EmailTo -subject $EmailSubject -body $EmailBody -Attachments "$report" -priority High -dno onSuccess, onFailure -smtpServer $EmailSMTPServer<br />
}</p>
<p>$File = Get-ChildItem $report<br />
if ($File.Length -gt 0) {sendEmail}</p>
<p>$shot1 = Dir $dir</p>
<p># this will pause the script for 60 seconds, change as necessary<br />
Start-Sleep -s 60</p>
<p>}</p>
<p><&#47;pre></p>
