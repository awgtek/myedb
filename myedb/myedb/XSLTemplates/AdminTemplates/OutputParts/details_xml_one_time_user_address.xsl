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
<xsl:output method="html" encoding="utf-8"/>
<xsl:template match="medb_order_elem_field[@field_name='details_xml']" mode="one_time_user_address">
			<xsl:value-of select="user_full_name_elem"/>
			<br></br>
			<xsl:value-of select="shipaddr_addr1"/><br />
	<xsl:value-of select="shipaddr_addr2"/>
			<br />
			<xsl:value-of select="shipaddr_city"/>, 
			<xsl:value-of select="shipaddr_state"/>
			<xsl:text> </xsl:text>
			<xsl:value-of select="shipaddr_zip"/>
</xsl:template>
<xsl:template match="medb_order_elem_field[@field_name='details_xml']" mode="one_time_user_address_co_name">
			<xsl:value-of select="co_name"/>
			<br></br>
			<xsl:value-of select="shipaddr_addr1"/><br />
	<xsl:value-of select="shipaddr_addr2"/>
			<br />
			<xsl:value-of select="shipaddr_city"/>, 
			<xsl:value-of select="shipaddr_state"/>
			<xsl:text> </xsl:text>
			<xsl:value-of select="shipaddr_zip"/>
</xsl:template>
</xsl:stylesheet>