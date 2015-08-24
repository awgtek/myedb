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
 <xsl:template match="select"> 
 		 <tr>
		 <td>
		 <xsl:value-of select="ancestor::property/@prop_name"/>
		 </td>
		 <td>
		 <SELECT> 
<xsl:attribute name="name">
<xsl:value-of select="ancestor::property/@ffi"/>
</xsl:attribute>
<xsl:attribute name="id">
<xsl:value-of select="ancestor::property/@ffi"/>
</xsl:attribute>
<OPTION value="" selected="true">Select one</OPTION>
<xsl:apply-templates select="./option"/>
</SELECT>
		 </td>
		 </tr>

</xsl:template>

<xsl:template match="option"> 
<OPTION> 
<xsl:attribute name="value">
<xsl:value-of select="@LUTR_id"/>
</xsl:attribute>
<xsl:if test="./@LUTR_id = ancestor::property/value"> 
<xsl:attribute name="SELECTED">true</xsl:attribute>
</xsl:if>
<xsl:value-of select="."/>
</OPTION>
</xsl:template>

<xsl:template match="option" mode="print_option_value">
	<xsl:if test="./@LUTR_id = ancestor::property/value"> 
		<xsl:value-of select="."/>
	</xsl:if>
</xsl:template> 

</xsl:stylesheet>