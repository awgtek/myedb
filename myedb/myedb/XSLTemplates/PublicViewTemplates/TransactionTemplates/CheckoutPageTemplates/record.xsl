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
<xsl:include href="../../../include/templates/generic/location_items.xsl" />
<xsl:include href="../../../include/output_templates.xsl" />
<xsl:include href="print_field_text.xsl" />
<xsl:include href="../../../include/templates/generic/property.xsl"/>

<!--<xsl:include href="print_select.xsl" />-->
<xsl:include href="property.xsl" />
<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>

 <xsl:template match="record">
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


 </xsl:template>
</xsl:stylesheet>