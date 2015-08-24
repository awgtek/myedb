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

<xsl:template name="qty-select">
    <xsl:param name="counter"/>
	<xsl:param name="count_limit"/>
	<xsl:param name="optvalprefix"/>
	<option>
		<xsl:attribute name="value" ><xsl:value-of select="$optvalprefix"/><xsl:value-of select="$counter"/></xsl:attribute>
	    <xsl:value-of select="$counter"/>
	</option>
    <xsl:if test="$counter &lt; $count_limit">
        <xsl:call-template name="qty-select">
            <xsl:with-param name="counter" select="$counter + 1"/>
			<xsl:with-param name="count_limit" select="$count_limit"/>
			<xsl:with-param name="optvalprefix" select="$optvalprefix"/>
        </xsl:call-template>
    </xsl:if>
</xsl:template>

<xsl:template name="print_city_state_zip">
			<xsl:apply-templates select="./validator/select/option" mode="print_option_value"/>
			<xsl:if test="@prop_id = 12">,</xsl:if><xsl:text> </xsl:text>
			
</xsl:template>

</xsl:stylesheet>