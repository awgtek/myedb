<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:include href="../include/page_sections/leftnavdiv.xsl"/>
<xsl:include href="../include/page_sections/topstripdiv.xsl"/>
<xsl:include href="../include/head_includes.xsl"/>
<xsl:include href="pageframe1.xsl" />

<xsl:include href="PageContents/edit_entity_groupings_pgct.xsl" />
<xsl:output method='html'/>

<!-- param values may be changed during the XSL Transformation -->
<xsl:param name="title">Edit Featured Items</xsl:param>

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
    </style>

		<xsl:call-template name="head_include_tags" />
</head>
<body>
		<xsl:call-template name="pageframe"><!--e.g. pageframe1.xsl, in which is called the pagecontent template in PageContents/xxx_pgct.xsl (see includes above) -->
		</xsl:call-template>
</body>


</html>

</xsl:template>

</xsl:stylesheet>
