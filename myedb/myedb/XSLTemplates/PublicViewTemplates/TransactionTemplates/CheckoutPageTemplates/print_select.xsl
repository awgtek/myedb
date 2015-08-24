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

<xsl:template name="print_select">
 		 <tr>
		 <td>
		 <xsl:value-of select="./@prop_name"/>
		 </td>
		 <td>
		 	<xsl:choose>
				 <xsl:when test="@prop_name = 'City' or @prop_name = 'State' or @prop_name = 'Zip'" >
							<xsl:variable name="var_value" select="value" />
						 	<xsl:if test="@prop_id = 12">
								<xsl:value-of select="/myedbroot/lookup_table_cities/city[@city_id=$var_value]" />
							</xsl:if>
						 	<xsl:if test="@prop_id = 13">
								<xsl:value-of select="/myedbroot/lookup_table_states/state[@state_id=$var_value]" />
							</xsl:if>
						 	<xsl:if test="@prop_id = 14">
								<xsl:value-of select="/myedbroot/lookup_table_zips/zip[@zip_id=$var_value]" />
							</xsl:if>
				 </xsl:when>
				 <xsl:otherwise>
					<xsl:apply-templates select="./validator/select/option" mode="print_option_value"/>
				 </xsl:otherwise>
			 </xsl:choose>
		 </td>
		 </tr>
</xsl:template>

</xsl:stylesheet>