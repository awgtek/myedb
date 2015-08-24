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
<xsl:include href="PageContents/RecordEditor_pgct.xsl" />
<xsl:include href="../include/output_templates.xsl"/>
<xsl:include href="../include/templates/RecordEditor/record_info.xsl"/>
<xsl:include href="../include/templates/generic/property.xsl"/>
<xsl:include href="../include/templates/generic/select_option.xsl"/>
<xsl:include href="../include/templates/generic/multi_phone.xsl"/>
<xsl:include href="../include/templates/RecordEditor/property.xsl"/>
<!--<xsl:include href="../include/templates/RecordEditor/right_of_admin_search_form.xsl"/>overrides template in empty_placeholder_templates.xsl-->
 <xsl:param name="owner" select="'Nicolas Eliaszewicz'"/>
 <xsl:output method="html" encoding="UTF-8" indent="yes" />
<!-- <xsl:template match="/">
 Hey! Welcome to <xsl:value-of select="$owner"/>'s sweet CD collection! 
  <xsl:apply-templates/>
 </xsl:template>-->
  <xsl:key name="product_detail_line" match="property[@prop_group_id='2']" use="@ron" />
	<xsl:key name="prop_list_by_name" match="property" use="@prop_name" />
	<xsl:key name="prop_list_by_id" match="/myedbroot/record/property" use="@prop_id" />
  <xsl:key name="phonekey" match="property[@prop_name='Phone']" use="@epi" />

 
<xsl:template match="/">
<html>
  	<head>
		<xsl:call-template name="head_include_tags" />
	</head>
	<body>

		<xsl:call-template name="pageframe">
		</xsl:call-template>

	</body>
</html>
 </xsl:template>
 
 <xsl:template name="page_frame_2_title">
 	<xsl:if test="$eid = 0">
		Insert
	</xsl:if>
	<xsl:if test="$eid &gt; 0">
		Update
	</xsl:if>
 
	<xsl:if test="$type_id = 4">
		 Travel Item
	</xsl:if>
	<xsl:if test="$type_id = 5">
		 Information Item
	</xsl:if>
	
</xsl:template>

 </xsl:stylesheet>
