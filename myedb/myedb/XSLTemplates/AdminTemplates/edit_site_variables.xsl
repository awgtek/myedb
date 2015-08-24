<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:include href="../include/page_sections/leftnavdiv.xsl"/>
<xsl:include href="../include/page_sections/topstripdiv.xsl"/>
<xsl:include href="../include/head_includes.xsl"/>
<xsl:include href="pageframe2.xsl" />

<xsl:include href="PageContents/edit_site_variables_pgct.xsl" />
<xsl:output method='html'/>

<!-- param values may be changed during the XSL Transformation -->
<xsl:param name="title">Edit Site Values</xsl:param>

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
<script type="text/javascript" >
	<xsl:attribute name="src"><xsl:value-of select='$app_root_client' />/thirdparty/ThickBox/thickbox.js</xsl:attribute>
</script>

<link rel="stylesheet"  type="text/css" media="screen" >
	<xsl:attribute name="href"><xsl:value-of select='$app_root_client' />/thirdparty/ThickBox/thickbox.css</xsl:attribute>
</link>
</head>
<body>
		<xsl:call-template name="pageframe"><!--e.g. pageframe1.xsl, in which is called the pagecontent template in PageContents/xxx_pgct.xsl (see includes above) -->
		</xsl:call-template>
</body>


</html>

</xsl:template>

</xsl:stylesheet>
