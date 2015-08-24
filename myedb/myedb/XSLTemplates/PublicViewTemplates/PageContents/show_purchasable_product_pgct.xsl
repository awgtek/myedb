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

<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>

<xsl:param name="btn_sub" />
<xsl:param name="update_cart_msg" select="'Update Cart'" />

<xsl:template name="pagecontent">
		      <div id="public_center_content" >

		      <div class="">

  <table width="100%"  border="0" cellspacing="0" cellpadding="0">
	<tr>
	    <td width="680">
			<table width="100%"><tr><td width="160"><div style="height:10px; padding:10px;"><strong>Product Details:</strong></div></td>
						<td width="51">
							<label style="font-size:14px; background-color:#FF9999">
							<xsl:if test="$btn_sub = $update_cart_msg">Cart Updated!     <a href="index.php?target_component%5B%5D=TransMgmtFacade&amp;target_function%5B%5D=get_pending_transactions&amp;output_function=show_pending_transactions">see cart</a>
</xsl:if>
							</label>
				</td>
					</tr>
			</table>
		</td>
    	<td width="754">&nbsp;</td>
	</tr>
    <tr>
    <td class="yellow">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" >
			<tr>
				<td><strong><xsl:value-of select="/myedbroot/types/type[@type_id=/myedbroot/record/@type_id]" />  </strong></td>
				<td align="right"><strong>Item Number: <xsl:value-of select="/myedbroot/record/@eid" /></strong></td>
			</tr>
		</table>
	</td>
    <td class="yellow"></td>
  </tr>
</table>

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
	 <table width="100%"  border="0" cellspacing="0" cellpadding="0">
	 <xsl:apply-templates select="/myedbroot/record" />
	 </table>
				<xsl:choose>
					<xsl:when test="$type_id != 5">
						<xsl:if test="/myedbroot/record/property[@prop_id=15 and value != '']"><!--there are product detail lines with qty-->
							 <input class="formbuttons" type="submit" id="btn_sub" name="btn_sub" value="Update Cart" >
								<xsl:attribute name="value" ><xsl:value-of select="$update_cart_msg" /></xsl:attribute>
							 </input>
						 </xsl:if>
					</xsl:when>
					<xsl:otherwise>
					</xsl:otherwise>
				</xsl:choose>
	<!--<input type="reset" id="btn_res" name="btn_res" value="Reset" />-->
	 </form>
		</div>
</div>
		<xsl:call-template name="pub_search_res_div" />
</xsl:template>
</xsl:stylesheet>