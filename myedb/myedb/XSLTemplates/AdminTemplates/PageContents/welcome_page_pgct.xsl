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
<xsl:template name="pagecontent">
		      <div id="public_center_content" class="bodytext2">

<table width="100%" border="0" cellspacing="0"  cellpadding="0">
		 <tr>
		 <td >
		 
		 <div class="right">
  <h1>Welcome</h1>
  <p>You are logged in as <strong><xsl:value-of select="$logged_in_user_full_name"/></strong>. Please select a link to the left.</p>
</div>
		 </td>
		 </tr>

</table>
</div>
</xsl:template>
</xsl:stylesheet>