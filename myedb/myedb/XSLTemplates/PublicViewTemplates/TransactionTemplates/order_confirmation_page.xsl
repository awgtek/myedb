<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
xmlns:exslt="http://exslt.org/common"
>
<xsl:include href="../../include/head_includes.xsl"/>
<xsl:include href="../PageContents/order_confirmation_page_pgct.xsl" />
<xsl:include href="../pageframe.xsl" />

<xsl:output method="html"/>


<xsl:template match="/">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/>
<title>Order Confirmation</title>
<link href="/stylesheets/main_style.css" rel="stylesheet" type="text/css" />
<xsl:call-template name="horiz-menu-header-code"/>
		<xsl:call-template name="head_include_tags" />
</head>
<body>
		<xsl:call-template name="pageframe">
		</xsl:call-template>
</body>
</html>

</xsl:template>


</xsl:stylesheet>