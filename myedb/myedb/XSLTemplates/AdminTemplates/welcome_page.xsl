<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:include href="../include/page_sections/leftnavdiv.xsl"/>
<xsl:include href="../include/page_sections/topstripdiv.xsl"/>
<xsl:include href="../include/head_includes.xsl"/>
<xsl:include href="pageframe1.xsl" />

<xsl:include href="PageContents/welcome_page_pgct.xsl" />
<xsl:output method='html'/>

<!-- param values may be changed during the XSL Transformation -->
<xsl:param name="title">List Products</xsl:param>
<xsl:param name="script">person_list.php</xsl:param>
<xsl:param name="numrows">0</xsl:param>
<xsl:param name="curpage">1</xsl:param>
<xsl:param name="lastpage">1</xsl:param>
<xsl:param name="script_time">0.2744</xsl:param>
<xsl:param name="n_pages">0</xsl:param>
<xsl:param name="page_links">0</xsl:param>

<!-- include common templates 
<xsl:include href="std.pagination.xsl"/>
<xsl:include href="std.actionbar.xsl"/>
-->
<xsl:template match="/">

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title><xsl:value-of select="$title"/></title>
<link href="/stylesheets/main_style.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
      <![CDATA[
      <!--
      -->
      ]]>
    </style><xsl:variable name="the_type_id" select="//records/record[@type_id]"/>


		<xsl:call-template name="head_include_tags" />
</head>
<body>
		<xsl:call-template name="pageframe">
		</xsl:call-template>
</body>


</html>

</xsl:template>


<!--
<xsl:template name="list_category_links">
	<xsl:param name="param_type_id" />
	<tr>
		<td>
			<xsl:value-of select="//types/type[@type_id=$param_type_id]"/> Categories:
		</td>
	</tr>
	<xsl:for-each select="//categories/category/cattypes[cattype = $param_type_id]" >
		<tr>	
		<td>
			<a >
			<xsl:attribute name="href">
	
	?target_component[]=RecordIniFacade&amp;target_function[]=search_by_prop_val&amp;spi=6&amp;spv=<xsl:value-of select="ancestor::category/@cat_id" />&amp;type_id=<xsl:value-of select="$param_type_id"/>&amp;output_function=admin_paged_content</xsl:attribute>
		<xsl:value-of select="ancestor::category/catval" />
			</a>
		</td>
		</tr>
	</xsl:for-each>
	<tr>
		<td>
			<a >
			<xsl:attribute name="href">
				?target_component[]=RecordIniFacade&amp;target_function[]=search_by_prop_val_contains&amp;spi=1&amp;spv=&amp;type_id=<xsl:value-of select="$param_type_id"/>&amp;output_function=admin_paged_content</xsl:attribute>
				Show all <xsl:value-of select="//types/type[@type_id=$param_type_id]"/> records				
			</a>
		</td>
	</tr>
</xsl:template>
-->
</xsl:stylesheet>
