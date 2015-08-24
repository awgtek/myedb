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
<xsl:include href="../generic/misc/print_city_state_zip.xsl"/>
<xsl:include href="../generic/property.xsl"/>
<xsl:include href="../../output_templates.xsl" />

<xsl:include href="../RecordTemplates/record_images_display.xsl" />

<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>
 <xsl:param name="group-size" select="2" /> 
 <xsl:template match="record" mode="travel_item_display">
 	<tr>
		<td colspan="2">
			<table  border="0" cellspacing="0" cellpadding="0"  >
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
				 <xsl:apply-templates select="property[@prop_id=1]" mode="print_text_with_field_name1"/>
				 <xsl:apply-templates select="property[@prop_id=2]" mode="print_text_with_field_name2"/>
			</table>
		</td>
	</tr>
	
 </xsl:template>
 


</xsl:stylesheet>