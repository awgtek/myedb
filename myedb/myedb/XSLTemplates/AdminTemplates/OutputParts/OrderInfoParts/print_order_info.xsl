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
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:pl="urn:myedb:propertylist" xmlns:exslt="http://exslt.org/common">

<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>
<xsl:template name="print_order_info">
<a target="_blank" >

<xsl:attribute name="href">index.php?target_component%5B%5D=TransMgmtFacade&amp;target_function%5B%5D=get_order_details_page_xml&amp;order_id=<xsl:value-of select="/myedbroot/medb_order_elem/medb_order_elem_record/medb_order_elem_field[@field_name='order_id']"/>&amp;OF_passthru=print_order_invoice</xsl:attribute>
Print Invoice</a>
<table width="60%" cellspacing="20">

<tr>
<td class="adminincell" valign="top">Order Number: <xsl:value-of select="/myedbroot/medb_order_elem/medb_order_elem_record/medb_order_elem_field[@field_name='order_id']"/>

</td>
<td class="adminincell" valign="top">
Date Order Submitted: <xsl:value-of select="/myedbroot/medb_order_elem/medb_order_elem_record/medb_order_elem_field[@field_name='date_added']"/>
</td>
</tr>

<tr>
<td class="adminincell" valign="top">
  
  <p>
        <xsl:value-of select="/myedbroot/medb_order_elem/medb_order_elem_record/medb_order_elem_field[@field_name='details_xml']/co_account_number" /><br />
        <xsl:value-of select="/myedbroot/medb_order_elem/medb_order_elem_record/medb_order_elem_field[@field_name='details_xml']/co_business_name" /><br />
      Special requests:  <xsl:value-of select="/myedbroot/medb_order_elem/medb_order_elem_record/medb_order_elem_field[@field_name='details_xml']/chkout_special_requests" /><br />
   
    </p></td>
<td class="adminincell" valign="top">
  <p>
    <xsl:variable name="nset_ext" select="/myedbroot/medb_order_elem/medb_order_elem_record/medb_order_elem_field[@field_name='details_xml']/will_pick_up"/>                        
    Will pick up: <xsl:if test="$nset_ext">
      Yes
    </xsl:if>
    <xsl:if test="not($nset_ext)">
	No
            </xsl:if><br /><br />
			
          <xsl:apply-templates select="/myedbroot/medb_order_elem/medb_order_elem_record/medb_order_elem_field[@field_name='details_xml']"
			 mode="one_time_user_address_co_name" />
    </p></td>
</tr>			
			</table>
			<br />
			
			<table width="60%" border="1" cellpadding="0" cellspacing="0">
				<tr>
					<td class="adminincell2" nowrap="nowrap"><strong>
						Quantity
					</strong></td>
					<td class="adminincell2"  nowrap="nowrap"><strong>
						Product
					</strong></td>
					<td class="adminincell2"  nowrap="nowrap"><strong>
						Account No.
					</strong></td>
					<td class="adminincell2"  nowrap="nowrap"><strong>
						Price
					</strong></td>
					<td class="adminincell2"  nowrap="nowrap"><strong>
						Total
					</strong></td>
				</tr>
		<xsl:for-each select="/myedbroot/medb_order_elem/medb_order_elem_record/medb_order_elem_field[@field_name='details_xml']/transactions/transaction" >
			<tr>
				<xsl:variable name="qty" select="@qty" />
				<xsl:variable name="price" select="@price" />
				<xsl:variable name="linetotal" select="$qty * $price" />
				<td  valign="top" class="adminincell2">
					<xsl:value-of select="$qty" />
				</td>
				<td  valign="top" class="adminincell2">
					<xsl:value-of select="@product_name" />
				</td>
				<td  valign="top" class="adminincell2">
					<xsl:value-of select="@account_number" />
				</td>
				<td  valign="top" class="adminincell2">
					<xsl:value-of select="format-number($price, '$###,###,##0.00')" />
				</td>
				<td  valign="top" class="adminincell2">
					<xsl:value-of select="format-number($qty * $price, '$###,###,##0.00')" />
				</td>
			</tr>
		
		</xsl:for-each>
	</table>			
		
		<br />
		<xsl:variable name="tmpTotal">
				<xsl:for-each select="/myedbroot/medb_order_elem/medb_order_elem_record/medb_order_elem_field[@field_name='details_xml']/transactions/transaction ">
					<xsl:variable name="qty" select="@qty" />
					<xsl:variable name="price" select="@price" />
					<xsl:variable name="linetotal" select="$qty * $price" />
					<item>
						<xsl:value-of select="$qty * $price" />
					</item>
				</xsl:for-each>
		</xsl:variable>
		<table  width="60%" border="0" cellpadding="3" cellspacing="0">
		<tr>
		<td valign="top" >&nbsp;</td>
		<td width="27%" valign="top" class="adminincell2">
		<strong>Total order cost:</strong>		</td>
		<td width="19%" valign="top" class="adminincell2">
		<xsl:value-of select="format-number(sum(exslt:node-set($tmpTotal)/*), '$###,###,##0.00')" />		</td>
		</tr>
		<tr>
<td valign="top" colspan="2">&nbsp;<br /></td>
</tr>
		<!-- <tr>
<td valign="center" rowspan="4" class="adminincell" width="54%" align="center"></td>		 
     		<td colspan="2" valign="top" class="adminincell2"> <strong>Payment Method</strong></td>
		  </tr>
			<tr>
		<td width="27%" valign="top" class="adminincell2">
		Credit card number		</td>
		<td width="19%" valign="top" class="adminincell2">
		<xsl:value-of select="/myedbroot/medb_order_elem/medb_order_elem_record/medb_order_elem_field[@field_name='details_xml']/cc_info" />		</td>
		</tr>
			<tr>
		<td width="27%" valign="top" class="adminincell2">
		Credit card expiration date		</td>
		<td width="19%" valign="top" class="adminincell2">
		<xsl:value-of select="/myedbroot/medb_order_elem/medb_order_elem_record/medb_order_elem_field[@field_name='details_xml']/CCexpdate" />		</td>
		</tr>
			<tr>
		<td width="27%" valign="top" class="adminincell2">
		Credit card holder name		</td>
		<td width="19%" valign="top" class="adminincell2">
		<xsl:value-of select="/myedbroot/medb_order_elem/medb_order_elem_record/medb_order_elem_field[@field_name='details_xml']/CChldrname" />		</td>
		</tr>-->
		</table>
</xsl:template>

</xsl:stylesheet>