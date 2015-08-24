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
<xsl:template name="list_category_links">
	<xsl:param name="param_type_id" />
	<tr>
		<td>
			<xsl:value-of select="//types/type[@type_id=$param_type_id]"/> Categories:
		</td>
	</tr>
	<xsl:for-each select="//categories/category[@is_disabled != 1]/cattypes[cattype = $param_type_id]" >
		<tr>	
			<td>
				<a >
				<xsl:attribute name="href">
		
		?target_component[]=RecordIniFacade&amp;target_function[]=search_by_prop_val&amp;spi=6&amp;spv=<xsl:value-of select="ancestor::category/@cat_id" />&amp;type_id=<xsl:value-of select="$param_type_id"/>&amp;output_function=output_paged_templated_content</xsl:attribute>
			<xsl:value-of select="ancestor::category/catval" />
				</a>
			</td>
		</tr>
	</xsl:for-each>
	<tr>
		<td>
			<a >
			<xsl:attribute name="href">
				?target_component[]=RecordIniFacade&amp;target_function[]=search_by_prop_val_contains&amp;spi=1&amp;spv=&amp;type_id=<xsl:value-of select="$param_type_id"/>&amp;output_function=output_paged_templated_content</xsl:attribute>
				All <xsl:value-of select="//types/type[@type_id=$param_type_id]"/> records				
			</a>
		</td>
	</tr>
</xsl:template>

</xsl:stylesheet>