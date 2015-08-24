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
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exslt="http://exslt.org/common">

<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>

<xsl:param name="btn_sub" />

<xsl:template name="pagecontent">
		      <div id="public_center_content" >

		      <div class="bodytext2">

<table border='1' cellpadding="0" cellspacing="0">
	<tr>
		<td>
			<table  border="0" cellspacing="4" cellpadding="5" bgcolor="">
	<tr>
	<th>Product</th>
	<th>Price</th>
	<th>Expiration</th>
	<th>Quantity</th>
	<th>Delete</th>
	
	
	</tr>
	<xsl:apply-templates select="/myedbroot/transactions/transaction"/>
			</table>
		</td>
		<td valign="top">
		<xsl:variable name="tmpTotal">
				<xsl:for-each select="/myedbroot/transactions/transaction ">
					<xsl:variable name="var_ron" select="@ron"/>
					<xsl:variable name="var_prop_group_id" select="@prop_group_id"/>
					<xsl:variable name="var_rec_eid" select="@eiddst"/><!--for future possible compatibility if multiple records ever embedded into a transaction-->
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
		<table  border="0" cellspacing="4" cellpadding="5" bgcolor="">
		<tr>
		<th>
        Total order cost: 
		</th>
		</tr>
		<tr>
		<td align="right">
            <xsl:value-of select="format-number(sum(exslt:node-set($tmpTotal)/*), '$###,###,##0.00')" />
		</td>
		</tr>
		</table>
        
		</td>
	</tr>
</table>
<form action="" method="get">

	<input type="hidden" name="target_component[]" value="TransMgmtFacade"  />
	<input type="hidden" name="target_function[]" value="get_checkout_form_xml" />
	<!--<input type="hidden" name="type_id" value="3" />
	<input type="hidden" name="eid"  >
		<xsl:attribute name="value"><xsl:value-of select="$cur_user"/></xsl:attribute>
	</input>-->
	<input type="hidden" name="OF_passthru" value="checkout_cart" />
	<input type="submit" value="Checkout"  />
</form>
		</div>
</div>
		<xsl:call-template name="pub_search_res_div" />
</xsl:template>
</xsl:stylesheet>