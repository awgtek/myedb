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
xmlns:pl="urn:myedb:propertylist" xmlns:exslt="http://exslt.org/common" 
                  >
<xsl:include href="../OutputParts/details_xml_user_address.xsl"/>
<xsl:include href="../../include/templates/RecordDisplay/record.xsl"/>

<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>
<xsl:param name="current_date_time"/>
 <xsl:key name="res_prop_location" match="/myedbroot/medb_order_elem/medb_order_elem_record/medb_order_elem_field[@field_name='details_xml']/travel_product/record/property[@prop_group_id='1']" use="@ron" />

<xsl:template match="/">
<html>
<head>
<title>NewEnglandTrade: Travel Request Details for Order# <xsl:value-of select="/myedbroot/medb_order_elem/medb_order_elem_record/medb_order_elem_field[@field_name='order_id']"/></title>

<link href="/stylesheets/print_order.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<xsl:comment>
.style1 {font-family: "Times New Roman", Times, serif}
.style2 {font-size: larger}
</xsl:comment>
</style>
</head>
<body >
<table width="100%" cellspacing="20">
<tr>
<td>
  <div align="center"><img src="/images/logo.jpg" alt="New England Trade" border="0"  /></div></td>
<td class="adminincell" valign="top">


  <div align="center">
    <h1>
      <!--Order Number: <xsl:value-of select="/myedbroot/medb_order_elem/medb_order_elem_record/medb_order_elem_field[@field_name='order_id']"/>--> 
      <span class="style1">Reservation Request    </span></h1>
  </div></td>
</tr>
<tr>
<td class="adminincell" valign="top">
  <p align="center"><font size="3"><span class="style1"><strong>New England Trade, Inc.<br />
  926 Eastern Avenue<br />
  </strong>Malden, MA 02148<br />
  781-388-9200<br />
  Fax 781-321-4443<br />
    <a href="mailto:barter@newenglandtrade.com">barter@newenglandtrade.com</a></span></font></p>  </td>
<td valign="top" class="adminfont adminfontsize1 adminbordertable2">
  <p><xsl:value-of select="/myedbroot/medb_order_elem/medb_order_elem_record/medb_order_elem_field[@field_name='details_xml']/travel_product/record/property[@prop_id='1']/value"/>
    <xsl:for-each select="/myedbroot/medb_order_elem/medb_order_elem_record/medb_order_elem_field[@field_name='details_xml']/travel_product/record/property[generate-id(.)=generate-id(key('res_prop_location',@ron)) ]">
	<!--  Sort Primary key by name in ascending order 
	  --> 
	 	<xsl:sort select="@ron" order="ascending" data-type="number"/> 
			<xsl:if test="@epi &gt; 0">
				<br />
  				<xsl:apply-templates select="key('res_prop_location',@ron)" mode="formatted_location_mode" >
					<xsl:with-param name="lookup_root" select="//travel_lookups"/>
				</xsl:apply-templates>
			</xsl:if>
	</xsl:for-each>
  <br />
    Account# <xsl:value-of select="/myedbroot/medb_order_elem/medb_order_elem_record/medb_order_elem_field[@field_name='details_xml']/travel_product/record/property[@prop_id='33']/value"/></p>
  <p>Fax # _______________________  </p>
  </td>
</tr>
<tr><td colspan="2"><hr  color="#000000" /></td></tr>
<tr>
  <td>Date Reservation Submitted: <xsl:value-of select="/myedbroot/medb_order_elem/medb_order_elem_record/medb_order_elem_field[@field_name='date_added']"/> </td>
<td>Agreed to Terms &amp; Conditions - <xsl:value-of select="$current_date_time" /></td></tr>
<!--<tr>
<td class="adminincell" valign="top">
Sold to: <br />
			<xsl:apply-templates select="/myedbroot/medb_order_elem/medb_order_elem_record/medb_order_elem_field[@field_name='details_xml']"
			 mode="user_address" /></td>
<td class="adminincell" valign="top"></td>
</tr>			-->
			</table>
			<br />
			
			<table width="100%" border="1" cellpadding="0" cellspacing="0">
	<xsl:for-each select="/myedbroot/medb_order_elem/medb_order_elem_record/medb_order_elem_field/travel_res_submitted_fields/travel_res_submit_field[@res_field_name!='travel_res__expiration_date'
	and @res_field_name!='travel_res__credit_card_no' and @res_field_name!='travel_res__card_holders_name'
	]">
		<tr>
			<td width="20%" valign="top" class="adminincell2" ><xsl:value-of select="res_field_label" /></td>
			<td   valign="top" class="adminincell2" >
				<xsl:value-of select="res_field_value" />
			</td>
		</tr>
	</xsl:for-each>
	</table>			
		
		<br />
		<table  width="100%" border="0" cellpadding="0" cellspacing="0">
	<!--	<tr>
<td width="9%" valign="top">&nbsp;&nbsp;&nbsp; </td>
<td width="54%" valign="top"></td>
<td valign="top">&nbsp;</td>
<td valign="top">&nbsp;</td>
		</tr>-->
		<tr>
<td valign="top" colspan="4"><hr color="#000000" /></td>
</tr>

		<!--<tr>
<td valign="top" colspan="3">&nbsp;<br /></td>
</tr>-->
		 <tr>
<td colspan="2" rowspan="5" align="center" valign="center" class="adminfont adminfontsize2 "><strong>Property Confirmation Information</strong><br />
  <strong><span class="style2">Fax Back to 781-321-4443</span> </strong></td>		 
     		<td colspan="2" valign="top" class="adminincell2"> <strong>Credit Card Information</strong></td>
		  </tr>
			<tr>
		<td width="18%" valign="top" class="adminincell2">
		Credit card #		</td>
		<td width="19%" valign="top" class="adminincell2">
		<xsl:value-of select="/myedbroot/medb_order_elem/medb_order_elem_record/medb_order_elem_field[@field_name='details_xml']/travel_res_submitted_fields/travel_res_submit_field[@res_field_name='travel_res__credit_card_no']/res_field_value" />		</td>
		</tr>
			<tr>
		<td width="18%" valign="top" class="adminincell2">
		Expiration Date		</td>
		<td width="19%" valign="top" class="adminincell2">
		<xsl:value-of select="/myedbroot/medb_order_elem/medb_order_elem_record/medb_order_elem_field/travel_res_submitted_fields/travel_res_submit_field[@res_field_name='travel_res__expiration_date']/res_field_value" />&nbsp;		</td>
		</tr>
			<tr>
		<td width="18%" valign="top" class="adminincell2">
		Card Holders Name		</td>
		<td width="19%" valign="top" class="adminincell2">
		<xsl:value-of select="/myedbroot/medb_order_elem/medb_order_elem_record/medb_order_elem_field/travel_res_submitted_fields/travel_res_submit_field[@res_field_name='travel_res__card_holders_name']/res_field_value" />&nbsp;		</td>
		</tr>
		</table>
     <table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
    <td valign="top" class="adminfont adminfontsize2">
	  <p>Approved  By: _____________________________________ </p>
	  <p>Confirmation # ____________________________________</p>
	  <p>Trade Amount: ____________________________________</p>
	  <p>Cash Amount: _________________________________ : (Taxes; other charges)</p>
	  <p>Notes: _____________________________________________________________________________________________</p>
	      <hr />
		  <table width="100%">
		  <tr><td width="50%" class="adminfont adminfontsize2">
	        <p>Broker Use:	      </p>
	        <p>Date Promised: _______________________________</p>
	        <p>Date Confirmed: ______________________________      </p></td>
			<td class="adminfont adminfontsize2">
		      <p>Auth # 1 ____________________________________</p>
		      <p>Auth # 2 _____________________________________</p>
		      <p>Recip Account # _________________________________ </p></td>
		</tr>
		<tr><td colspan="2" class="adminfont adminfontsize2"><p><br />
		Notes: ____________________________________________________________________________________________________________________________</p>
		</td>
		</tr>
		</table>
	  
    </td>
</tr>
</table> 
<br/>
<!--
<table width="200" border="1" cellpadding="0" cellspacing="0" class="adminbordertable">
<tr>
<td class="adminincell"><strong>Office Use Only</strong><br/><br/>TAMNT:<br/><br/>TAUTH:<br/><br/>CCAUTH:</td>
</tr>
</table>-->
</body>
</html>
</xsl:template>

</xsl:stylesheet>