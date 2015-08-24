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
<xsl:include href="lookup_item.xsl" />
<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>
<xsl:param name="title">List Products</xsl:param>

<xsl:template match="/">
	<input type="hidden" name="spi[]" value="50" />
	<input type="hidden" id="sel_spv3_pv" name="sel_spv3_pv" />
	<select name="spv[]"  id="sel_spv3">
			<option value="0">Any Subcategory</option>
			<xsl:apply-templates select="//lookup_item_group/lookup_item" mode="select_subcats" />
	</select>


</xsl:template>
</xsl:stylesheet>