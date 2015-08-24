<?xml version="1.0" encoding="utf-8"?><!DOCTYPE xsl:stylesheet  [
	<!ENTITY nbsp   "&#160;">
	<!ENTITY copy   "&#169;">
	<!ENTITY reg    "&#174;">
	<!ENTITY trade  "&#8482;">
	<!ENTITY mdash  "&#8212;">
	<!ENTITY ldquo  "&#8220;">
	<!ENTITY rdquo  "&#8221;"> 
	<!ENTITY pound  "&#163;">
	<!ENTITY yen    "&#165;">
	<!ENTITY euro   "&#8364;">
]>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>
<xsl:template  name="topstrip_admin">
<!--
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>Untitled Document</title>
<style type="text/css">
<xsl:comment>
.style1 {font-family: Arial, Helvetica, sans-serif}
.style3 {font-size: 14px}
</xsl:comment>
</style>
</head>

<body>-->



<table width="100%" border="0" cellspacing="0" cellpadding="0" align="left">
  <tr>
    
    <td class="header"><div align="right"></div></td>
  </tr>
  <tr>
    <td style="background-image:url(/images/nav-left.jpg)">
	<div class="topnav">
     <table width="720" border="0" cellspacing="0" cellpadding="0" style="height:42px; background-image:url(/images/topnav.jpg)">
  <tr>
    <td width="144"><div align="center"><a href="#">NET Member Login</a></div></td>
    <td width="144"><div align="center"><a href="#">NET BLOG</a></div></td>
    <td width="144"><div align="center"><a href="#">NET Main Admin</a></div></td>
    <td width="144"><div align="center"><a >
		<xsl:attribute name="href" >index.php?target_component=SecurityOperationsFacade&amp;target_function=process_logout</xsl:attribute>
	Main Admin Logout
	</a></div></td>
    <td width="144"><div align="center">Logged in as <xsl:value-of select="$logged_in_user_full_name" /></div></td>
  </tr>
</table>
</div>
	
<!--	<div class="nav-top"><a href="#">NET Member Login</a>&nbsp;&nbsp;-&nbsp;&nbsp;<a href="#">NET BLOG</a>&nbsp;&nbsp;-&nbsp;&nbsp;
	<a href="#">NET Main Admin</a>&nbsp;&nbsp;-&nbsp;&nbsp;<a >
		<xsl:attribute name="href" >index.php?target_component=SecurityOperationsFacade&amp;target_function=process_logout</xsl:attribute>
	Main Admin Logout
	</a>&nbsp;You are logged in as <strong>gary</strong></div>-->
	
	</td>
  </tr>
 </table>
<!--
<p>&nbsp;</p>
</body>
</html>-->

</xsl:template>
</xsl:stylesheet>