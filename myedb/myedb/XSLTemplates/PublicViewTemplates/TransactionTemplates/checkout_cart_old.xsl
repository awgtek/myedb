<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:exslt="http://exslt.org/common">
<!--<xsl:include href="include/templates/generic/select_option.xsl"/>-->
<xsl:include href="../include/page_sections/page_includes.xsl"/>
<xsl:include href="../include/head_includes.xsl"/>
<xsl:include href="CheckoutPageTemplates/record.xsl" />

 <xsl:param name="owner" select="'Nicolas Eliaszewicz'"/>
 <xsl:output method="html" encoding="UTF-8" indent="yes" />
<!--<xsl:template match="/">
  Hey! Welcome to <xsl:value-of select="$owner"/>'s sweet CD collection! 
  <xsl:apply-templates/>
 </xsl:template>-->
 <xsl:key name="record" match="/myedbroot/checkout_form/record/property[@prop_group_id='1']" use="@ron" />
  <xsl:key name="product_detail_line" match="property[@prop_group_id='2']" use="@ron" />
	<xsl:key name="prop_list_by_name" match="property" use="@prop_name" />

 
<xsl:template match="/">
<html>
  <head>
		<xsl:call-template name="head_include_tags" />
</head>
<body>
<xsl:call-template name="horiz-menu" />
<div id="site">

  <h2>Choose shipping destination:</h2>
	 <form method="post" action="index.php">
<input type="hidden" name="target_component[]" value="RecordIniFacade" />
<input type="hidden" name="target_function[]" value="update_record" />
<input type="hidden" name="target_component[]" value="TransMgmtFacade" />
<input type="hidden" name="target_function[]" value="finalize_order" />
<input type="hidden" name="OF_passthru" value="order_confirmation_page" />
	 <table border="0">
	 	<tr>
			<td>
				<table>
	 <xsl:apply-templates select="/myedbroot/checkout_form/record" />
	 			</table>
			</td>
			<td>
				<table>
					<tr>
						<td>
							<xsl:variable name="tmpTotal">
									<xsl:for-each select="/myedbroot/checkout_form/transactions/transaction ">
										<xsl:variable name="var_ron" select="@ron"/>
										<xsl:variable name="var_prop_group_id" select="@prop_group_id"/>
										<xsl:variable name="var_rec_eid" select="@eiddst"/>
										<item>
											<xsl:value-of select="@qty * record[@eid = $var_rec_eid]/property[@prop_group_id = $var_prop_group_id and @prop_id=16 and @ron = $var_ron]/value"/>
										</item>
										<item>
											0<xsl:choose>
												<xsl:when test="record[@eid = $var_rec_eid]/property[@prop_id=30]/value = 1">
													<xsl:value-of select="@qty * record[@eid = $var_rec_eid]/property[@prop_id=29]/value"/>
												</xsl:when>
												<xsl:otherwise>
													<xsl:value-of select="record[@eid = $var_rec_eid]/property[@prop_id=29]/value"/>
												</xsl:otherwise>
											</xsl:choose>
										</item>
									</xsl:for-each>
							</xsl:variable>
							Total order cost: 
								<xsl:value-of select="sum(exslt:node-set($tmpTotal)/*)" />
						</td>
					</tr>
					<tr>
						<td>Credit Card: <input type="text" name="CCinfo" />
						</td>
					</tr>
				</table>
			</td>
		</tr>
	 </table>
	 <xsl:variable name="password_field_id" select="/myedbroot/record/property[@prop_name = 'Password']/@ffi" />
	 <input class="formbuttons" type="submit" id="btn_sub" name="btn_sub" value="Finalize Order" >
	 	<xsl:attribute name="onclick">
		if (document.getElementById('<xsl:value-of select="$password_field_id" />'))
		{
			document.getElementById('<xsl:value-of select="$password_field_id" />').value = hex_md5(document.getElementById('<xsl:value-of select="$password_field_id" />').value);
		}
		</xsl:attribute>
	</input>
	<!--<input type="reset" id="btn_res" name="btn_res" value="Reset" />-->
	 </form>
	 </div>
</body>
</html>
 </xsl:template>
 


 


 
 <xsl:template match="select"> 
 		 <tr>
		 <td>
		 <xsl:value-of select="ancestor::property/@prop_name"/>
		 </td>
		 <td>
		 <SELECT> 
<xsl:attribute name="name">
<xsl:value-of select="ancestor::property/@ffi"/>
</xsl:attribute>
<OPTION value="" selected="true">Select one</OPTION>
<xsl:apply-templates select="./option"/>
</SELECT>
		 </td>
		 </tr>

</xsl:template>

<xsl:template match="option"> 
<OPTION> 
<xsl:attribute name="value">
<xsl:value-of select="@LUTR_id"/>
</xsl:attribute>
<xsl:if test="./@LUTR_id = ancestor::property/value"> 
<xsl:attribute name="SELECTED">true</xsl:attribute>
</xsl:if>
<xsl:value-of select="."/>
</OPTION>
</xsl:template>

 </xsl:stylesheet>
