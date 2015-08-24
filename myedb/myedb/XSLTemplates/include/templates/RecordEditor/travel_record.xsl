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
<xsl:include href="image_upload_group.xsl"/>
<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>
<xsl:template match="record">
 	<tr>
		<td valign="top" width="30%">
			<table >
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
				 <xsl:apply-templates select="property[@prop_id=32 and @ron=0]"/>
				 <xsl:apply-templates select="property[@prop_id=18 and @ron=0]"/>
 			</table>
		</td>
		
		<td valign="top">
			<table>
				<xsl:for-each select="key('record',0)">
				 <xsl:choose>
					 <xsl:when test="@prop_name = 'State' " >
						<xsl:apply-templates select="./validator/select" />
					 </xsl:when>
					 <xsl:when test="@prop_name = 'Zip'" >
						<xsl:if test="@epi &gt; 0">
							<xsl:call-template name="print_select_with_option_value_in_input_field" />
						</xsl:if>
						<xsl:if test="@epi = 0">
							<xsl:apply-templates select="."  mode="append_standin" />
						</xsl:if>
					 </xsl:when>
					 <xsl:when test="@prop_name = 'City'" >
						<xsl:if test="@epi &gt; 0">
							<xsl:call-template name="print_select_with_option_value_in_input_field" />
						</xsl:if>
						<xsl:if test="@epi = 0">
							<xsl:apply-templates select="."  mode="append_standin" />
						</xsl:if>
					 </xsl:when>
					 <xsl:otherwise>
						<xsl:apply-templates select="." />
					 </xsl:otherwise>
				 </xsl:choose>
				</xsl:for-each>
			</table>
		</td>
		<td valign="top">
		</td>
		
	</tr>
	

</xsl:template>
</xsl:stylesheet>