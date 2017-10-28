---
layout: post
status: publish
published: true
title: Fixing the rewrite rule for Wordpress on IIS
author:
  display_name: hajek
  login: hajek
  email: hajek@iit.edu
  url: ''
author_login: hajek
author_email: hajek@iit.edu
wordpress_id: 161
wordpress_url: http://blog.sat.iit.edu/?p=161
date: '2011-11-02 10:02:41 -0500'
date_gmt: '2011-11-02 16:02:41 -0500'
categories:
- Uncategorized
tags: []
comments: []
---
<p>When using Wordpress on IIS - changing the Settings > Permalinks > Month and Name failed.  It was not obvious at first since all the articles were rendered successfully.  If you look at the bottom of the Permalinks screen it gives you instructions on how to modify your <a href="http:&#47;&#47;en.wikipedia.org&#47;wiki&#47;Web.config">web.config<&#47;a> to make sure it can render Month and Name URLs.  </p>
<p>For example by default Wordpress will render all articles with a simple id:  <code>http:&#47;&#47;blog.sat.iit.edu&#47;?p=123<&#47;code></p>
<p>But you want the setting to be Month and Name: <code>http:&#47;&#47;blog.sat.iit.edu&#47;2011&#47;11&#47;sample-post&#47;<&#47;code></p>
<p>The instructions are not clear where to add the entry to your <a href="http:&#47;&#47;en.wikipedia.org&#47;wiki&#47;Web.config">web.config<&#47;a>.  It has been provided for you, an entire <a href="http:&#47;&#47;en.wikipedia.org&#47;wiki&#47;Web.config">web.config<&#47;a> that will render your permalinks as Month and Name. </p>
<pre lang="XML" line="1">
<?xml version="1.0" encoding="UTF-8"?><br />
<configuration><br />
    <system.webServer><br />
        <defaultDocument><br />
            <files><br />
                <clear &#47;><br />
                <add value="index.php" &#47;><br />
                <add value="Default.htm" &#47;><br />
                <add value="Default.asp" &#47;><br />
                <add value="index.htm" &#47;><br />
                <add value="index.html" &#47;><br />
                <add value="iisstart.htm" &#47;><br />
            <&#47;files><br />
		<&#47;defaultDocument><br />
		<rewrite><br />
		  <rules><br />
		    <rule name="wordpress" patternSyntax="Wildcard"><br />
		      <match url="*" &#47;><br />
		        <conditions><br />
			  <add input="{REQUEST_FILENAME}" matchType="IsFile" negate="true" &#47;><br />
			  <add input="{REQUEST_FILENAME}" matchType="IsDirectory" negate="true" &#47;><br />
			<&#47;conditions><br />
		      <action type="Rewrite" url="index.php" &#47;><br />
		     <&#47;rule><br />
		   <&#47;rules><br />
		 <&#47;rewrite><br />
    <&#47;system.webServer><br />
<&#47;configuration><br />
<&#47;pre></p>
