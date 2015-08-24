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
<xsl:include href="../../include/templates/generic/select_option.xsl"/>

<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>

<xsl:template match="medb_order_elem_record">

  <tr>
    <xsl:attribute name="class">
      <xsl:choose>
        <xsl:when test="position()mod 2">odd</xsl:when>
        <xsl:otherwise>even</xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>

    <td align="center">
		<a>
			<xsl:attribute name="href" >index.php?target_component%5B%5D=TransMgmtFacade&amp;target_function%5B%5D=get_order_details_page_xml&amp;order_id=<xsl:value-of select="medb_order_elem_field[@field_name='order_id']"/>&amp;OF_passthru=show_order_details</xsl:attribute>
			
		<xsl:value-of select="medb_order_elem_field[@field_name='order_id']"/>
		</a>
	</td>
    <td align="center"><xsl:value-of select="medb_order_elem_field[@field_name='date_added']"/></td>
    <td align="center"><xsl:value-of select="medb_order_elem_field[@field_name='details_xml']/travel_rec/user_full_name_elem"/></td>
  <!--  <td align="center"><xsl:value-of select="medb_order_elem_field[@field_name='details_xml']/item_count"/></td>-->
    <td align="center"><xsl:value-of select="medb_order_elem_field[@field_name='details_xml']/travel_rec/business_name"/></td>
    <td align="center"><xsl:value-of select="medb_order_elem_field[@field_name='details_xml']/travel_rec/product_name"/></td>
	<td align="center"><xsl:value-of select="medb_order_elem_field[@field_name='details_xml']/travel_rec/account_no"/></td>
	<td align="center"><xsl:value-of select="medb_order_elem_field[@field_name='details_xml']/travel_rec/check_in_date"/></td>
	<td align="center"><xsl:value-of select="medb_order_elem_field[@field_name='details_xml']/travel_rec/check_out_date"/></td>
	<td align="center">
		<xsl:if test="medb_order_elem_field[@field_name='approved'] = 1">
			Approved
		</xsl:if>
		<xsl:if test="medb_order_elem_field[@field_name='approved'] = 0">
			Pending
		</xsl:if>
		<xsl:if test="medb_order_elem_field[@field_name='approved'] = -1">
			Not Approved
		</xsl:if>
	</td>
	<td align="center">
	<script>
	</script>
		<input type="button" value="delete"  >
			<xsl:attribute name="onclick">
				var delete_confirmed = confirm('Order <xsl:value-of select="medb_order_elem_field[@field_name='order_id']"/> will be deleted');
				if (!delete_confirmed)
				{
					return;
				}
				else
				{
					var url = '?target_component[]=TransMgmtFacade&amp;target_function[]=delete_medb_order&amp;oid=<xsl:value-of select="medb_order_elem_field[@field_name='order_id']"/>&amp;OF_passthru=echo_data';
					HTML_AJAX.grab(url,revealDivCurrentCallBack);

					revealDivCurrent();
				}
				
			</xsl:attribute>
		</input>
	</td>
  </tr>

</xsl:template>



</xsl:stylesheet>