<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="include/page_sections/page_includes.xsl"/>
<xsl:include href="include/head_includes.xsl"/>
<xsl:include href="include/templates/RecordDisplay/record.xsl"/>
 <xsl:param name="owner" select="'Nicolas Eliaszewicz'"/>
 <xsl:output method="html" encoding="UTF-8" indent="yes" />
<!--<xsl:template match="/">
  Hey! Welcome to <xsl:value-of select="$owner"/>'s sweet CD collection! 
  <xsl:apply-templates/>
 </xsl:template>-->
 <xsl:key name="record" match="property[@prop_group_id='1']" use="@ron" />
  <xsl:key name="product_detail_line" match="property[@prop_group_id='2']" use="@ron" />
	<xsl:key name="prop_list_by_name" match="property" use="@prop_name" />

 
<xsl:template match="/">
<html>
  <head>
<link href="/stylesheets/main_style.css" rel="stylesheet" type="text/css" />
		<xsl:call-template name="head_include_tags" />
</head>
<body>
<xsl:call-template name="horiz-menu" />

<div id="site">

  <h2>Product Details:</h2>
	 <form method="post" action="index.php">
	 <input type="hidden" name="target_component[]" value="TransMgmtFacade" />
<input type="hidden" name="target_function[]" value="create_transaction" />
<input type="hidden" name="target_component[]" value="RecordIniFacade" />
<input type="hidden" name="target_function[]" value="initialize" />
<input type="hidden" name="eid"  >
	<xsl:attribute name="value" ><xsl:value-of select="$eid" /></xsl:attribute>
</input>
<input type="hidden" name="type_id"  >
	<xsl:attribute name="value" ><xsl:value-of select="$type_id" /></xsl:attribute>
</input>
<input type="hidden" name="OF_passthru" value="show_purchasable_product" />
	 <table border="0">
	 <xsl:apply-templates select="/myedbroot/record" />
	 </table>
				<xsl:choose>
					<xsl:when test="$type_id != 5">
						 <input class="formbuttons" type="submit" id="btn_sub" name="btn_sub" value="Update Cart" />
					</xsl:when>
					<xsl:otherwise>
					</xsl:otherwise>
				</xsl:choose>
	<!--<input type="reset" id="btn_res" name="btn_res" value="Reset" />-->
	 </form>
	 </div>
</body>
</html>
 </xsl:template>
 

 

 



 </xsl:stylesheet>
