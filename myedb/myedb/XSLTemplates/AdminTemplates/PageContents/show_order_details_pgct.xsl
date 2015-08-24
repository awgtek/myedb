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
<xsl:include href="../OutputParts/OrderInfoParts/print_order_info.xsl" />
<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>
<xsl:template name="pagecontent">
    <div class="bodytext2">
		<table>
			<tr>
				<td>
		<select  >
			<xsl:attribute name="onchange">handle_order_approved_change(this,<xsl:value-of select="/myedbroot/medb_order_elem/medb_order_elem_record/medb_order_elem_field[@field_name='order_id']"/> );</xsl:attribute>
			<option value="0" >
				<xsl:if test="/myedbroot/medb_order_elem/medb_order_elem_record/medb_order_elem_field[@field_name='approved'] = 0">
					<xsl:attribute name="selected"></xsl:attribute>
				</xsl:if>
				Pending</option>
			<option value="1" >
				<xsl:if test="/myedbroot/medb_order_elem/medb_order_elem_record/medb_order_elem_field[@field_name='approved'] = 1">
					<xsl:attribute name="selected"></xsl:attribute>
				</xsl:if>
				Approved</option>
			<option value="-1" >
				<xsl:if test="/myedbroot/medb_order_elem/medb_order_elem_record/medb_order_elem_field[@field_name='approved'] = -1">
					<xsl:attribute name="selected"></xsl:attribute>
				</xsl:if>
				Disapproved</option>
			
		</select>
				</td>
				<td><div class="taskcompletemsg" id="status_change_message" />
				</td>
			</tr> 
		</table>
		<br />
		<xsl:choose>
			<xsl:when test="/myedbroot/medb_order_elem/medb_order_elem_record/medb_order_elem_field/travel_res_submitted_fields">
				<xsl:call-template name="print_travel_request_info" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="print_order_info" />
			</xsl:otherwise>
		</xsl:choose>

	</div>
</xsl:template>

<xsl:template name="print_travel_request_info">
<a target="_blank" >

<xsl:attribute name="href">index.php?target_component%5B%5D=TransMgmtFacade&amp;target_function%5B%5D=get_order_details_page_xml&amp;order_id=<xsl:value-of select="/myedbroot/medb_order_elem/medb_order_elem_record/medb_order_elem_field[@field_name='order_id']"/>&amp;OF_passthru=print_travel_request</xsl:attribute>
Print Travel Request</a>
	<table>
	<tr><td>Note:</td><td><i>Click value to edit</i></td></tr>
	<tr><td>Order #</td><td><xsl:value-of select="$order_id" /></td></tr>
	<xsl:apply-templates select="/myedbroot/medb_order_elem/medb_order_elem_record/medb_order_elem_field/travel_res_submitted_fields/travel_res_submit_field" />
	</table>
</xsl:template>

<xsl:template match="travel_res_submit_field">
	<tr>
		<td bgcolor="#FFCC99"><xsl:value-of select="res_field_label" /></td><td width="250em"><div 
		>
		<xsl:attribute name="id"><xsl:value-of select="@res_field_name" />
		</xsl:attribute>
		<!--<xsl:value-of select="res_field_value" />-->
		<xsl:call-template name="append-pad">
			<xsl:with-param name="padChar" select="'&nbsp;&nbsp;&nbsp;'" />
			<xsl:with-param name="padVar" select="res_field_value" />
			<xsl:with-param name="length" select="1" />
		</xsl:call-template>
		</div>
		
	<!--	<div id="editme">Click me, click me!</div>
<script type="text/javascript">
 new Ajax.InPlaceEditor('editme', '/demoajaxreturn.html');
</script>-->
			<script>
			       new Ajax.InPlaceEditor('<xsl:value-of select="@res_field_name" />', 'index.php', {
		rows: 2,
        clickToEditText: "Click to edit me",
		callback: function(form, value) { return 'target_component%5B%5D=TransMgmtFacade&amp;target_function%5B%5D=update_medb_order_res_field_name_value&amp;OF_passthru=echo_serialized_data&amp;order_id=<xsl:value-of select="$order_id" />&amp;res_field_value='+encodeURIComponent(value) }

      });

			</script>

		</td>
	</tr>
</xsl:template>
  <xsl:template name="append-pad">    <!-- recursive template to left
justify and append  -->
                                      <!-- the value with whatever padChar
is passed in   -->
    <xsl:param name="padChar"> </xsl:param>
    <xsl:param name="padVar"/>
    <xsl:param name="length"/>
    <xsl:choose>
      <xsl:when test="string-length($padVar) &lt; $length">
        <xsl:call-template name="append-pad">
          <xsl:with-param name="padChar" select="$padChar"/>
          <xsl:with-param name="padVar" select="concat($padVar,$padChar)"/>
          <xsl:with-param name="length" select="$length"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
       <!-- <xsl:value-of select="substring($padVar,1,$length)"/>-->
       		<xsl:value-of select="$padVar"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>



</xsl:stylesheet>