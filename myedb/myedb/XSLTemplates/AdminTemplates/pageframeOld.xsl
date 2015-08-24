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
<xsl:template name="pageframe">
<table width="979" border="0" cellspacing="0"  cellpadding="0">
  <tr>
    <td width="206"  valign="top">
		<xsl:call-template name="leftnavdiv" />
	</td>
	<td  valign="top" width="100%">
		<table border="0" cellspacing="0" width="100%"  cellpadding="0">
			<tr>
				<td>
		<xsl:call-template name="topstripdiv" />
				</td>
			</tr>
			<tr>
				<td valign="top">
		<div id="site" >
		 	<xsl:call-template name="pagecontent" />
		 </div>
		 			</td>
			 	</tr>
		</table>
	</td>
  </tr>
</table>

</xsl:template>
</xsl:stylesheet>