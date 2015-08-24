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
<xsl:include href="../select_option.xsl" />

<xsl:output method="html" encoding="utf-8"/>
<xsl:template name="print_city_state_zip">
			<xsl:apply-templates select="./validator/select/option" mode="print_option_value"/>
			<xsl:if test="@prop_id = 12">,</xsl:if><xsl:text> </xsl:text>
			
</xsl:template>
</xsl:stylesheet>