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
<xsl:param name="group-size" select="2" /> 

<xsl:template name="pagecontent">
		      <div id="public_center_content" >
<form action="http://cl.exct.net/subscribe.aspx?lid=163267" 

name="subscribeForm" method="post" onSubmit="return checkForm();"> 

<input type="hidden" name="thx" value="www.newenglandtrade.info/index.php?target_component%5B%5D=RecordIniFacade&amp;target_function%5B%5D=donothing&amp;OF_passthru=barter_loop1"/> 

<input type="hidden" name="err" value="www.newenglandtrade.info/index.php?target_component%5B%5D=RecordIniFacade&amp;target_function%5B%5D=donothing&amp;OF_passthru=barter_loop3"/> 

<input type="hidden" name="usub" value="www.newenglandtrade.info/index.php?target_component%5B%5D=RecordIniFacade&amp;target_function%5B%5D=donothing&amp;OF_passthru=barter_loop2"/> 

<input type="hidden" name="MID" value="10207"/>

 

<table cellpadding="0" cellspacing="0" border="0" id="table2"> 

<tr> 

<td><font face="Verdana" size="2">Name:</font></td> 

<td><input type="text" name="Full Name"/></td> 

</tr> 

<tr> 

<td><font face="Verdana" size="2">Company Name:</font></td> 

<td><input type="text" name="User Defined"/></td> 

</tr> 

<tr> 

<td><font face="Verdana" size="2">Email:</font></td> 

<td><input type="text" name="Email Address"/></td> 

</tr> 

<tr> 

<td><input type="radio" name="Email Type" value="HTML" checked="checked"/> 

<font face="Verdana" size="2">HTML</font> 

</td> 

<td> 

<input type="radio" name="Email Type" value="TEXT"/> 

<font face="Verdana" size="2"> Text</font> 

</td> 

</tr> 

<tr> 

<td><input type="radio" name="SubAction" value="sub_add_update" checked="checked" /> 

<font face="Verdana" size="2">Subscribe</font> 

</td> 

<td><input type="radio" name="SubAction" value="unsub"/> 

<font face="Verdana" size="2">Unsubscribe</font> 

</td> 

</tr> 

<tr> 

<td><input type="submit" value="Submit"/></td> 

<td align="right"> 

<font face="verdana" size="1" color="#4C5487">&nbsp; 

</font></td> 

</tr> 

</table> 

</form>

</div>
		<xsl:call-template name="pub_search_res_div" />

</xsl:template>

</xsl:stylesheet>