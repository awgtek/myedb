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
<xsl:template match="medb_order_elem_field[@field_name='details_xml']" mode="user_address">
			<xsl:value-of select="user_full_name_elem"/>
			<br></br>
			<xsl:value-of select="shipping_address/property[@prop_id=4]/value"/><br />
	<xsl:value-of select="shipping_address/property[@prop_id=5]/value"/>
			<br />
			<xsl:variable name="city_id" select="shipping_address/property[@prop_id=12]/value" />
			<xsl:value-of select="/myedbroot/lookup_table_cities/city[@city_id=$city_id]" />, 
			<xsl:variable name="state_id" select="shipping_address/property[@prop_id=13]/value" />
			<xsl:value-of select="/myedbroot/lookup_table_states/state[@state_id=$state_id]" />
			<xsl:text> </xsl:text>
			<xsl:variable name="zip_id" select="shipping_address/property[@prop_id=14]/value" />
			<xsl:value-of select="/myedbroot/lookup_table_zips/zip[@zip_id=$zip_id]" />
</xsl:template>
</xsl:stylesheet>