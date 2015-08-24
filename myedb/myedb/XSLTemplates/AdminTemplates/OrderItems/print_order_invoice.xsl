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
<xsl:include href="../OutputParts/details_xml_one_time_user_address.xsl"/>
<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>
<xsl:template match="/">
<html>
<head>
<title>NewEnglandTrade: Admin Panel - Order Details for Order# <xsl:value-of select="/myedbroot/medb_order_elem/medb_order_elem_record/medb_order_elem_field[@field_name='order_id']"/></title>

<link href="/stylesheets/print_order.css" rel="stylesheet" type="text/css" />
</head>
<body>
<table width="100%" cellspacing="20">
<tr>
<td>
<img src="/images/logo.jpg" alt="New England Trade" border="0"  />
</td>
<td class="adminincell" valign="top">
Order Number: <xsl:value-of select="/myedbroot/medb_order_elem/medb_order_elem_record/medb_order_elem_field[@field_name='order_id']"/>
</td>
</tr>
<tr>
<td class="adminincell" valign="top">
<font size="3"><strong>NewEnglandTrade.info</strong></font>
</td>
<td class="adminincell" valign="top">
Date Order Submitted: <xsl:value-of select="/myedbroot/medb_order_elem/medb_order_elem_record/medb_order_elem_field[@field_name='date_added']"/>
</td>
</tr>

<tr>
<td class="adminincell" valign="top">
Sold to: <br />
			 <p>
        <xsl:value-of select="/myedbroot/medb_order_elem/medb_order_elem_record/medb_order_elem_field[@field_name='details_xml']/co_account_number" /><br />
        <xsl:value-of select="/myedbroot/medb_order_elem/medb_order_elem_record/medb_order_elem_field[@field_name='details_xml']/co_business_name" /><br />
      Special requests:  <xsl:value-of select="/myedbroot/medb_order_elem/medb_order_elem_record/medb_order_elem_field[@field_name='details_xml']/chkout_special_requests" /><br />
   
    </p>
</td>
<td class="adminincell" valign="top">
<table><tr><td class="adminincell" valign="top">Ship To:</td>

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
    </p>
		</td>
</tr></table>

			
</td>
</tr>			
			</table>
			<br />
			
			<table width="100%" border="1" cellpadding="0" cellspacing="0">
				<tr>
					<td class="adminincell2" nowrap="nowrap"><strong>
						Quantity
					</strong></td>
					<td class="adminincell2"  nowrap="nowrap"><strong>
						Product
					Name</strong></td>
					<td class="adminincell2"  nowrap="nowrap"><strong>
						Ref#
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
					<xsl:value-of select="@refno" />
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
		<table  width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr>
		<td valign="top" >&nbsp;</td>
		<td width="16%" valign="top" class="adminincell2">
		<strong>Total order cost:</strong>
		</td>
		<td width="16%" valign="top" class="adminincell2">
		<xsl:value-of select="format-number(sum(exslt:node-set($tmpTotal)/*), '$###,###,##0.00')" />
		</td>
		</tr>
		<tr>
<td valign="top" colspan="2">&nbsp;<br /></td>
</tr>
		 <tr>
<td valign="center" rowspan="2" class="adminincell" width="58%" align="center"><strong>Refunds 
      or Exchange will only be made within 60 days of Invoice.<br />
      No refunds on live tickets, vouchers, passes, ski tickets, sporting events 
      or other items that specify final sale.</strong></td>		 
     		<!--<td colspan="2" width="16%" valign="top" class="adminincell2"> <strong>Payment Method</strong></td>-->
			</tr>
		<!--	<tr>
		<td width="16%" valign="top" class="adminincell2">
		Credit card #
		</td>
		<td width="16%" valign="top" class="adminincell2">
		<xsl:value-of select="/myedbroot/medb_order_elem/medb_order_elem_record/medb_order_elem_field[@field_name='details_xml']/ccinfo/ccnum" />
		</td>
		</tr>-->
		</table>
     <table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
    <td valign="top" class="adminincell">
	  <br/>
	  <br/>
	  <div align="center"><font size="2"><strong>Thank you for your business.</strong></font></div>
    </td>
</tr>
</table> 
<br/>
<table width="200" border="1" cellpadding="0" cellspacing="0" class="adminbordertable">
<tr>
<td class="adminincell"><strong>Office Use Only</strong><br/><br/>TAMNT:<br/><br/>TAUTH:<br/><br/>CCAUTH:</td>
</tr>
</table>
</body>
</html>
</xsl:template>

</xsl:stylesheet>