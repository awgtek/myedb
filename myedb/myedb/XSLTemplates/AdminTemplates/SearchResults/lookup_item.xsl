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


<xsl:template match="lookup_item">
	<input type="text"  >
		<xsl:attribute name="name">edit_<xsl:value-of select="@prim_key_col"/>
		</xsl:attribute>
		<xsl:attribute name="value">
			<xsl:value-of select="@lookup_value_col"/>
		</xsl:attribute>
	</input>
	<xsl:variable name="lvplti" select="@lookup_value_parent_lookup_tbl_id" />
	<xsl:value-of select="/myedbroot/categories/category[@cat_id=$lvplti]/catval" />
	<input type="checkbox"  >
		<xsl:attribute name="name">delete_<xsl:value-of select="@prim_key_col"/>
		</xsl:attribute>
	</input> delete?
	<xsl:if test="../@lookup_table_name = 'subcategory' ">
		<input type="checkbox" >
			<xsl:if test="@is_disabled = 1">
				<xsl:attribute name="checked"></xsl:attribute>
			</xsl:if>
			<xsl:attribute name="name">disable_<xsl:value-of select="@prim_key_col"/>
			</xsl:attribute>
		</input> disabled
	</xsl:if>
	<br />
</xsl:template>
</xsl:stylesheet>