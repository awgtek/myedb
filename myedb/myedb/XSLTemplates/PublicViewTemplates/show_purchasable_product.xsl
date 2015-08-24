<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="../include/head_includes.xsl"/>
<xsl:include href="../include/templates/RecordDisplay/record.xsl"/>
<xsl:include href="PageContents/show_purchasable_product_pgct.xsl" />
<xsl:include href="pageframe.xsl" />
 <xsl:output method="html" encoding="UTF-8" indent="yes" />
 <xsl:key name="record" match="property[@prop_group_id='1']" use="@ron" />
  <xsl:key name="product_detail_line" match="property[@prop_group_id='2' ]" use="@ron" />
  <xsl:key name="product_detail_line_no_qty" match="property[@prop_group_id='2' and @prop_id != '15']" use="@ron" />
	<xsl:key name="prop_list_by_name" match="property" use="@prop_name" />

 
<xsl:template match="/">
<html>
  <head>
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
