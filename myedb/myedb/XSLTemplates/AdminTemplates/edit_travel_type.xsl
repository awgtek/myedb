<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="../include/page_sections/page_includes.xsl"/>
<xsl:include href="../include/output_templates.xsl"/>
<xsl:include href="../include/head_includes.xsl"/>
<xsl:include href="../include/templates/RecordEditor/travel_record.xsl"/>
<xsl:include href="../include/templates/generic/property.xsl"/>
<xsl:include href="../include/templates/generic/select_option.xsl"/>
<xsl:include href="../include/templates/generic/multi_phone.xsl"/>
<xsl:include href="../include/templates/RecordEditor/property.xsl"/>
<xsl:output method="html" encoding="UTF-8" indent="yes" />

  <xsl:key name="product_detail_line" match="property[@prop_group_id='2']" use="@ron" />
	<xsl:key name="prop_list_by_name" match="property" use="@prop_name" />
  <xsl:key name="phonekey" match="property[@prop_name='Phone']" use="@epi" />

 
<xsl:template match="/">
<html>
  	<head>
		<xsl:call-template name="head_include_tags" />
	</head>
	<body>
		<xsl:call-template name="horiz-menu" />
		
		<div id="site">
		
		  <h2>Entity Product:</h2>
			 <form method="post" action="index.php" enctype="multipart/form-data">
			 	<input type="hidden" name="target_component[]" value="RecordIniFacade" />
				<input type="hidden" name="target_function[]" value="update_record" />
			 	<input type="hidden" name="target_component[]" value="RecordIniFacade" />
				<input type="hidden" name="target_function[]" value="initialize" />
				<input type="hidden" name="eid">
					<xsl:attribute name="value">
						<xsl:value-of select="$eid"/>
					</xsl:attribute>
				</input>
				<input type="hidden" name="type_id" >
					<xsl:attribute name="value">
						<xsl:value-of select="$type_id"/>
					</xsl:attribute>
				</input>
				<input type="hidden" name="OF_passthru" value="edit_travel_type" />
			 	<table border="0">
			 		<xsl:apply-templates select="record" />
			 	</table>
				<!--<input type="reset" id="btn_res" name="btn_res" value="Reset" />-->
				<input class="formbuttons" type="submit" id="btn_sub" name="btn_sub" value="Update Record" >
					<xsl:attribute name="onclick">
					return validate_inputs();
					</xsl:attribute>
				</input>
			 </form>
		 </div>
	</body>
</html>
 </xsl:template>
 
 
 </xsl:stylesheet>
