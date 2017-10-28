---
layout: post
status: publish
published: true
title: Backup Script Using Robocopy and Powershell
author:
  display_name: acabrer3
  login: acabrer3
  email: acabrer3@hawk.iit.edu
  url: ''
author_login: acabrer3
author_email: acabrer3@hawk.iit.edu
wordpress_id: 198
wordpress_url: http://blog.sat.iit.edu/?p=198
date: '2011-11-08 12:39:51 -0600'
date_gmt: '2011-11-08 18:39:51 -0600'
categories:
- Uncategorized
tags: []
comments: []
---
<p>We needed a way to automate backups on a machine. We knew that robocopy could accomplish the backup task, but we needed to find a way to automate it. In order to do this, we created a powershell script. In the code below, the top portion can be edited, however the bottom portion must stay the same.<br />
Backup Script Below:</p>
<pre lang="PowerShell">## What do you wish to copy?<br />
$source=@("X:\folder1","X:\folder2")</p>
<p>## Where do you want to place the backup?<br />
$destination=@("\\serveraddress\folder1","\\serveraddress\folder2")</p>
<p>## Where do you want to save the log file?<br />
$logDestination="X:\logReport.txt"</p>
<p>## This file is used for the process of checking<br />
## whether or not the backup was successful<br />
$backupReport="X:\report.txt"</p>
<p>## Change as necessary<br />
$successEmailTo="Firstname Lastname "<br />
$successEmailSubject="Subject Goes Here"<br />
$successEmailBody="Body Goes Here"<br />
$successEmailFrom="Firstname Lastname "<br />
$successEmailSMTPServer="mail.domain.com"</p>
<p>$failEmailTo="Firstname Lastname "<br />
$failEmailSubject="Subject Goes Here"<br />
$failEmailBody="Body Goes Here"<br />
$failEmailFrom="Firstname Lastname "<br />
$failEmailSMTPServer="mail.domain.com"</p>
<p>## Depending on how many directories you are checking, you will need to change how many times this for loop will go<br />
for ($i=0; $i -lt 1; $i++) {</p>
<p>## =========================================================<br />
## ======== PLEASE DO NOT EDIT SCRIPT BELOW ================<br />
## =========================================================</p>
<p>Write-Host $i</p>
<p>## robocopy will mirror a directory and log the file, note the log will append<br />
robocopy $source[$i] $destination[$i] &#47;mir &#47;log+:$logDestination</p>
<p>## this will take a snapshot of the source and destination directory<br />
$shot1 = Dir $source[$i]<br />
$shot2 = Dir $destination[$i]</p>
<p>## This will compare the two snapshots and append it to a backup report<br />
Compare-Object $shot1 $shot2 -PassThru > $backupReport</p>
<p>## send a success email<br />
function sendSuccessEmail{<br />
send-mailmessage -from $successEmailFrom -to $successEmailTo -subject $successEmailSubject -body $successEmailBody -Attachments "$logDestination" -priority High -dno onSuccess, onFailure -smtpServer $successEmailSMTPServer<br />
}</p>
<p>## send a failure email<br />
function sendFailEmail{<br />
send-mailmessage -from $failEmailFrom -to $failEmailTo -subject $failEmailSubject -body $failEmailBody -Attachments "$logDestination" -priority High -dno onSuccess, onFailure -smtpServer $failEmailSMTPServer<br />
}</p>
<p>## if the backup report has no feedback (all files were copied successfully) it will send a success email<br />
$File = Get-ChildItem $backupReport<br />
if ($File.Length -eq 0) {sendSuccessEmail}</p>
<p>## if the backup report has feedback (all files were NOT copied successfully) it will send a failure email<br />
$File = Get-ChildItem $backupReport<br />
if ($File.Length -gt 0) {sendFailEmail}</p>
<p>}<&#47;pre><br />
Finally, to make this script run every night at the same time. We used Windows' Task Scheduler. However task scheduler will not take .ps1 files (powershell files). So we needed to make a batch file that pointed to the powershell script.</p>
<pre><&#47;pre></p>
<pre>Batch File Below:<&#47;pre></p>
<pre lang="PowerShell">powershell -command "& 'X:\RobocopyBackup.ps1' "<&#47;pre></p>
<p>&nbsp;<br />
The above batch file was put into task scheduler and scheduled to run at a certain time everyday.</p>
