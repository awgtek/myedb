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
<xsl:template name="topstrip1_admin">

<table border="0" width="100%" cellspacing="0" cellpadding="0">
  <tr>
    <th colspan="2" valign="top" scope="col"><div align="left"><a href="index.php"><img src="/images/header-admin.gif" alt="New England Trade" border="0" /></a></div></th>
  </tr>
<tr style="background-image:url(../../../images/admin-functions.gif); background-repeat:no-repeat;">
    <td  valign="top"  nowrap="nowrap"><div class="top" style="width:179px; height:23px;padding-top:17px;">Admin Function</div>
	</td>
	<td  valign="top" width="100%" ><div class="top-nav" style="height:23px;padding-top:17px;"><a href="index.php">Admin Home</a>&nbsp;&nbsp;|&nbsp;&nbsp;
	<a href="index.php?ntctf=1&amp;type_id=4&amp;OF_passthru=show_order_history">Travel Requests</a>&nbsp;&nbsp;|&nbsp;&nbsp;
	<a href="index.php?ntctf=1&amp;OF_passthru=show_order_history">Manage Orders</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="index.php?target_component%5B%5D=RecordIniFacade&amp;target_function%5B%5D=search_by_prop_val_contains&amp;spi=8&amp;spv=&amp;type_id=3&amp;OF_passthru=showpersonrecs">BLOG</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="#">Member Site</a>&nbsp;&nbsp;|&nbsp;&nbsp;
	<a >
		<xsl:attribute name="href" >index.php?target_component=SecurityOperationsFacade&amp;target_function=process_logout</xsl:attribute>
	Logout
	</a></div>
	</td>
  </tr>
      
 </table>

</xsl:template>
</xsl:stylesheet>