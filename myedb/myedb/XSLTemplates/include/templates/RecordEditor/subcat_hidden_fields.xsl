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
<xsl:template mode="subcat_hidden_fields" match="/myedbroot/record/property[@prop_id=50]">
		<xsl:param name="unstored_subcats" />
		<xsl:param name="stored_subcat_count" />
			<xsl:variable name="subcatpropval" select="value" />
										<xsl:variable name="subcat_curpos" select="position()" />
										<xsl:variable name="cursubcatid">
											<xsl:if test="@epi = 0"><!--$subcat_curpos will never be less than $stored_subcat_count because epi==0 nodes always come first-->
												<xsl:value-of select="$unstored_subcats[$subcat_curpos - $stored_subcat_count]/@subcat_id" />
											</xsl:if>
											<xsl:if test="@epi != 0">
												<xsl:value-of select="$subcatpropval" />
											</xsl:if>
										</xsl:variable><!--<xsl:value-of select="$cursubcatid" />,<xsl:value-of select="$subcatpropval" />-->
											<input type="checkbox"  style="display:none"  >
												<xsl:attribute name="name"><xsl:value-of select="@ffi" /></xsl:attribute>
												<xsl:attribute name="id"><xsl:value-of select="@ffi" /></xsl:attribute>
												<xsl:attribute name="value"><xsl:value-of select="$cursubcatid" /></xsl:attribute>
												<xsl:if test="@epi != 0">
													<xsl:attribute name="checked"></xsl:attribute>
												</xsl:if>
											</input>
						
											<input type="checkbox" name="props_to_delete[]"  style="display:none"  >
												<xsl:attribute name="value">pid<xsl:value-of select="@prop_id"/>rid<xsl:value-of select="@ron" />
												</xsl:attribute>
												<xsl:attribute name="id"><xsl:value-of select="@ffi" />_del</xsl:attribute>
											</input>
											

</xsl:template>
</xsl:stylesheet>