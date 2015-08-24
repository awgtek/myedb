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
<xsl:import href="../include/empty_placeholder_templates.xsl" />
<xsl:include href="../include/page_sections/topstrip_member.xsl" />
<xsl:include href="../include/page_sections/leftnav_member.xsl" />
<!--<xsl:include href="page_sections/admin_search_form.xsl" />-->

<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>
<xsl:template name="pageframe">
<table  width="100%" border="0" cellspacing="0" align="left"  cellpadding="0" style="background-color:#FFFFFF;">
	<tr>
		<td colspan="2">
			<xsl:call-template name="topstrip_member" />
		</td>
	</tr>
	
  <tr>
    <td  width="179" nowrap="nowrap" valign="top" >
		<xsl:call-template name="leftnav_member" />
	</td>
	<td  valign="top" width="100%" >
      <div class="bodytext2">

		<table border="0" cellspacing="0" width="100%"  cellpadding="0">
		<!--	<tr>
			<td  width="100%" valign="top" colspan="3"><div class="products-header"><xsl:call-template name="page_frame_2_title" /></div></td>
		  </tr>
			<tr>
				<td width="80">&nbsp;</td>
				<td  valign="top">
		<xsl:call-template name="member_search_form" />
				</td>
				<td width="300">
					<xsl:call-template name="right_of_member_search_form" />
				</td>
			</tr>
			-->
			<tr>
				<td  width="100%" align="left" valign="top" colspan="3">
		<div id="site" >
		 	<xsl:call-template name="pagecontent" />
		 </div>
				</td>
			</tr>
		</table>
		</div>
	</td>
  </tr>
    <tr>
    <td colspan="2" valign="top"><div class="footer">© 2008 New England Trade    Site Design: <a href="http://www.entertainmentimage.com" target="_blank">EIC</a></div></td>
  </tr>

</table>

</xsl:template>
</xsl:stylesheet>