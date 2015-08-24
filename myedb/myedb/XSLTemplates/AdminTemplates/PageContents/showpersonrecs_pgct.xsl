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
		      <div class="bodytext2">


  <script type="text/javascript" src="/server.php?client=all"></script>
<table width="100%" border="0">
<!--  <tr>
    <td width="21%"></td>
    <td width="79%"></td>
  </tr>-->
<tr>
<td>
<xsl:call-template name="admin_search_users_form" />
</td>

</tr>  
  <tr>
  <td>
	<table border="0" width="100%" cellpadding="0" cellspacing="0"><br />
		<tr>
			<td width="50%">
				<div id="target" style="display:inline; "></div>	
				</td>
			<td>
				<div style="display:inline; " id="launch_searchres_csv"></div>
			</td>
		</tr>
	</table>
		<div style=" text-align:center; display:inline;" id="searchresultsdiv" ></div>
  
  </td>
  </tr>
 <!-- <tr>
    <td></td>
    <td></td>
  </tr>-->
</table>
</div>
</xsl:template>
</xsl:stylesheet>