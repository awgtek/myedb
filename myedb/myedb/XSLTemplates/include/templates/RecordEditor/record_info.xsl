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
<xsl:include href="location_group.xsl"/>
<xsl:include href="category_group.xsl"/>
<xsl:include href="status_set.xsl"/>
<xsl:include href="image_upload_group.xsl"/>
<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>

<xsl:template match="record">
 	<tr>
		<td valign="top" width="34%" style="background-image:url(/images/green.jpg);">
			<table border="0" >
				<input type="hidden" name="OF_passthru" value="show_info_record_for_edit" />
				 <input type="hidden" name="rec_eid">
					<xsl:attribute name="value">
						<xsl:value-of select="@eid"/>
					</xsl:attribute>
				 </input>
				 <input type="hidden" name="rec_type_id">
					<xsl:attribute name="value">
						<xsl:value-of select="@type_id"/>
					</xsl:attribute>
				 </input>
				 <xsl:apply-templates select="property[@prop_name='Product Name']"/>
 				<tr>
					<td colspan="2">
				<xsl:call-template name="location_group" />
					</td>
				</tr>

				 <xsl:apply-templates select="property[@prop_id=52]"/><!--Main contact-->

				 <xsl:for-each select="key('prop_list_by_name','Website')">
						<xsl:sort select="@ron" order="ascending" data-type="number"/> 
						<xsl:apply-templates select="." /><!--mode="print_delete_checkbox"-->
				 </xsl:for-each>
				 <xsl:apply-templates select="property[@prop_id=55]"/><!--Email Address-->
 			</table>
		</td>
		
		<td valign="top" width="33%">
			<table border="0">
				 <xsl:apply-templates select="property[@prop_name='Description']"/>
				<xsl:apply-templates select="property[@prop_name='Notes / Restrictions']"/>
				 <xsl:apply-templates select="property[@prop_id=51]"/><!--Broker Notes-->
			 </table>
		</td>
		<td valign="top" style="background-image:url(/images/green.jpg);" width="33%">
			<table>
				<xsl:apply-templates select="property[@prop_id=33]"/><!--Account no-->
				<xsl:apply-templates select="property[@prop_id=57]"/><!--Reference no-->
				<xsl:call-template name="status_set" />
				<xsl:call-template name="category_group" />

				<tr><td colspan="2"><xsl:call-template name="image_upload_group"/></td></tr>
				<xsl:apply-templates select="property[@prop_id=35]/validator/select"/>
				<!--<xsl:apply-templates select="property[@prop_id=29]"/>
 				<xsl:apply-templates select="property[@prop_id=30]" mode="checkbox"/>-->
					 <xsl:apply-templates select="property[@prop_id=56]"/><!--Limit Per Order-->
				<xsl:apply-templates select="property[@prop_id=54]" mode="in_textarea"/><!--Keywords-->
					 <xsl:apply-templates select="property[@prop_id=58]"/><!--User defined 1-->
					 <xsl:apply-templates select="property[@prop_id=59]"/><!--User defined 2-->
			</table>
		</td>
		
	</tr>
</xsl:template>
</xsl:stylesheet>