<?xml version="1.0" encoding="utf-8"?>


<!DOCTYPE xsl:stylesheet  [
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
<xsl:include href="../include/page_sections/topstrip2_admin.xsl" />
<xsl:include href="../include/page_sections/leftnav_admin1.xsl" />

<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>
<xsl:template name="pageframe">
<table  width="100%" border="0" cellspacing="0" align="left"  cellpadding="0" style="background-color:#FFFFFF;">
	<tr>
		<td colspan="2">
			<xsl:call-template name="topstrip1_admin" />
		</td>
	</tr>
  <tr>
    <td  width="179" nowrap="nowrap" valign="top" style="background-image:url(/images/left-nav-repeat.gif); ">
		<xsl:call-template name="leftnav_admin1" />
	</td>
	<td  valign="top" width="100%" >
		<table border="0" cellspacing="0" width="100%"  cellpadding="0">

			<tr>
				<td  width="622" valign="top">
		<div id="site" >
		 	<xsl:call-template name="pagecontent" />
		 </div>
		 			</td>
			 	</tr>
		</table>
	</td>
  </tr>
    <tr>
    <td colspan="2" valign="top"><div class="footer">© 2008 New England Trade    Site Design: <a href="http://www.entertainmentimage.com" target="_blank">EIC</a></div></td>
  </tr>

</table>

</xsl:template>
</xsl:stylesheet>