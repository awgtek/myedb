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
<xsl:include href="../include/page_sections/leftnavdiv.xsl"/>
<xsl:include href="../include/page_sections/topstripdiv.xsl"/>
<xsl:include href="../include/head_includes.xsl"/>
<xsl:include href="pageframe2.xsl" />
<xsl:include href="PageContents/lookuptable_editor_pgct.xsl" />
<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>

<xsl:template match="/">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title></title>
		<xsl:call-template name="head_include_tags" />

</head>

<body>
		<xsl:call-template name="pageframe">
		</xsl:call-template>
</body>
</html>
</xsl:template>

<xsl:template match="lookup_item">
	<input type="text"  >
		<xsl:attribute name="name">edit_<xsl:value-of select="@prim_key_col"/>
		</xsl:attribute>
		<xsl:attribute name="value">
			<xsl:value-of select="@lookup_value_col"/>
		</xsl:attribute>
	</input>
	<input type="checkbox"  >
		<xsl:attribute name="name">delete_<xsl:value-of select="@prim_key_col"/>
		</xsl:attribute>
	</input> delete?
	<xsl:if test="../@lookup_table_name = 'category' ">
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

<xsl:template name="page_frame_2_title">
	<xsl:if test="$table_name = 'state'">
		Edit States
	</xsl:if>
	<xsl:if test="$table_name = 'status'">
		Edit Status Codes
	</xsl:if>
	<xsl:if test="$table_name = 'category'">
		Edit Categories
	</xsl:if>
	<xsl:if test="$table_name = 'city'">
		Edit Cities
	</xsl:if>
	<xsl:if test="$table_name = 'state'">
		Edit States
	</xsl:if>
	<xsl:if test="$table_name = 'zip'">
		Edit Zip Codes
	</xsl:if>


</xsl:template>

</xsl:stylesheet>