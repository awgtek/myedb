<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:include href="../include/templates/generic/select_option.xsl"/>
<xsl:include href="../search_records.xsl"/>
<!--<xsl:include href="../include/page_sections/page_includes.xsl"/>-->
<xsl:include href="../include/head_includes.xsl"/>
<xsl:include href="PageContents/public_welcome_page_pgct.xsl" />
<xsl:include href="pageframe.xsl" />

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
		<xsl:call-template name="head_include_tags" />
</head>
<body>

		<xsl:call-template name="pageframe">
		</xsl:call-template>



</body>

</html>

</xsl:template>



</xsl:stylesheet>
