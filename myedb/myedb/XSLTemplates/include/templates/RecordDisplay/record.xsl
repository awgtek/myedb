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
<xsl:include href="misc.xsl" />
<xsl:include href="../generic/select_option.xsl"/>
<xsl:include href="../generic/property.xsl"/>
<xsl:include href="../../output_templates.xsl" />
<xsl:include href="../RecordTemplates/record_images_display.xsl" />

<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>
 <xsl:param name="group-size" select="2" /> <!--not used-->
			<xsl:variable name="n-rows" select="3"/>
			<!--
<xsl:variable name="cols" select="ceiling((count(/myedbroot/record/property[@prop_id=26 and string-length(value) &gt; 0]) ) div $n-rows)"/>cols from count of images-->

<xsl:template match="record">
 	<tr><td width="50%" valign="top">
	
	<table width="100%" border="0" cellspacing="0" cellpadding="0" >
		 <input type="hidden" name="rec_eid">
			<xsl:attribute name="value">
				<xsl:value-of select="@eid"/>
			</xsl:attribute>
		 </input>
		 <input type="hidden" name="rec_type_id">
			<xsl:attribute name="value">
				<xsl:value-of select="@type_id"/>
			</xsl:attribute>
		 </input>
 <xsl:apply-templates select="property[@prop_name='Product Name']" mode="print_text_with_field_name1"/>
 <xsl:apply-templates select="property[@prop_name='Description']" mode="print_text_with_field_name2"/>
 <tr>
 	<td width="150px" valign="top" class="product-green">Locations:</td>
	<td valign="top" class="product-green product-description"  style="padding-bottom:0;" >
 	<table border="0"  cellpadding="0" cellspacing="0"  >
  <xsl:for-each select="property[generate-id(.)=generate-id(key('record',@ron)) ]">
	<!--  Sort Primary key by name in ascending order 
	  --> 
	 	<xsl:sort select="@ron" order="ascending" data-type="number"/> 
		<xsl:variable name="addressnum" select="@ron" />
		<xsl:if test="@epi &gt; 0">
			<tr  class="sechead"><td style=" padding-top:0;  padding-bottom:12px; "  colspan="2" valign="top" class="product-green product-description"  > <!--Address <xsl:value-of select="$addressnum + 1"/>:-->
				<!-- skip line on second address on 
				<xsl:if test="$addressnum &gt; 0">
					<br />
				</xsl:if>-->
			
			<!--<xsl:for-each select="key('record',@ron)">
				<xsl:call-template name="formatted_location"  />
		 	</xsl:for-each>-->
				<xsl:apply-templates select="key('record',@ron)" mode="formatted_location_mode" />
			</td></tr>
		</xsl:if>
  </xsl:for-each>
	</table>
</td></tr>
 <xsl:apply-templates select="property[@prop_name='Notes / Restrictions']" mode="print_text_with_field_name2"/>
 <xsl:apply-templates select="property[@prop_name='Phone']" mode="print_text_with_field_name1"/>
 <xsl:apply-templates select="property[@prop_name='Website']" mode="print_text_with_field_name_hyperlink"/>
 <xsl:apply-templates select="property[@prop_id=55]" mode="print_text_with_mailto_hyperlink"/><!-- email-->
 <xsl:apply-templates select="property[@prop_id=52]" mode="print_text_with_field_name1"/><!-- main contact-->
	</table></td>
		<td width="50%" valign="top" align="left">
			
			<table border="0" width="100%" style="margin-left:10px; font-size:12px">
 <!--images -->
 					<!-- row oriented version -->
			<!--	<xsl:apply-templates select="property[@prop_id=26][(position() mod $group-size) = 1]"  mode="row-oriented">
				</xsl:apply-templates>   -->
				<!-- column oriented version -->
				<!--<xsl:apply-templates select="property[@prop_id=26 and string-length(value) &gt; 0]" mode="column-oriented" >
				</xsl:apply-templates>-->
				<xsl:call-template name="td-recursive-image-rows" /><!--images-->
			</table>
		</td>
	
	
	</tr>
	
	<tr>
	<td colspan="3">
	<table width="50%" border="0" cellspacing="1" cellpadding="5" >
	<xsl:if test="/myedbroot/record/property[@prop_id=15 and value != '']"><!--there are product detail lines with qty-->
		<tr  >
			<td colspan="4" class="product-detail-header" > Product Detail: </td>
		</tr>
	</xsl:if>
<!--  <xsl:for-each select="property[generate-id(.)=generate-id(key('product_detail_line',@ron)) ][1]">
			 <tr>
		<xsl:for-each select="key('product_detail_line',@ron)">
			 <td>
			 <xsl:value-of select="@prop_name"/>
			 </td>
		 </xsl:for-each>
			 </tr> 
 	</xsl:for-each>-->
		<xsl:for-each select="property[generate-id()=generate-id(key('product_detail_line',@ron)) and @epi &gt; 0 ][1]">
		  <tr>
					<xsl:for-each select="key('product_detail_line_no_qty',@ron)">
						<th align="left" width="175">
							<xsl:value-of select="@prop_name"/>
						</th>
					</xsl:for-each>
					<th align="left">Desired Quantity</th>
		  </tr>
		  </xsl:for-each>
		<xsl:variable name="limit_cnt" select="property[@prop_id = 56]/value " />
  <xsl:for-each select="property[generate-id(.)=generate-id(key('product_detail_line',@ron)) and @epi &gt; 0 ]">
	<!--  Sort Primary key by name in ascending order 
	  --> 
	 	<xsl:sort select="@ron" order="ascending" /> 
	  	<xsl:variable name="qty_cnt" select="key('product_detail_line',@ron)[@prop_id = 15]/value" />
		<xsl:variable name="effective_qty_cnt">
			<xsl:if test="$limit_cnt &lt; $qty_cnt and string(number($limit_cnt))!='NaN' "><xsl:value-of select="$limit_cnt" /></xsl:if>
			<xsl:if test="$limit_cnt &gt; $qty_cnt or string(number($limit_cnt))='NaN' "><xsl:value-of select="$qty_cnt" /></xsl:if>
		</xsl:variable>
		<xsl:if test="$qty_cnt &gt; 0">
		<tr>
    <xsl:attribute name="class">
      <xsl:choose>
        <xsl:when test="position()mod 2">product-green</xsl:when>
        <xsl:otherwise>product-tan</xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
			<xsl:for-each select="key('product_detail_line_no_qty',@ron)">
				<!--	<td width="150px" valign="top" class="product-green">
						<xsl:value-of select="@prop_name" />
					</td>-->
					 <td valign="top"  >
						<xsl:choose>
							<xsl:when test="@prop_id = '16'"> <!-- price -->
								<xsl:value-of select="format-number(value, '$###,###,##0.00')" />
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="value"/>
							</xsl:otherwise>
						</xsl:choose>
					 </td>
			 </xsl:for-each>
					 <td>
					 <xsl:if test="@epi &gt; 0 ">
						<select name="groups_to_add_to_transactions[]">
							<option value="0">Select quantity</option>
							<xsl:call-template name="qty-select">
								<xsl:with-param name="counter" select="1"/>
								<xsl:with-param name="count_limit" select="$effective_qty_cnt"/>
								<xsl:with-param name="optvalprefix">pgid<xsl:value-of select="@prop_group_id"/>rid<xsl:value-of select="@ron" />qty</xsl:with-param>
							</xsl:call-template>
						</select>
						<!--<input type="checkbox" name="groups_to_add_to_transactions[]" >
							<xsl:attribute name="value">pgid<xsl:value-of select="@prop_group_id"/>rid<xsl:value-of select="@ron" />
							</xsl:attribute>
						</input> Add to cart -->
					</xsl:if>
					</td>
				 </tr>
		</xsl:if>
 	</xsl:for-each>
	</table>
</td>

</tr>
 </xsl:template>
 
</xsl:stylesheet>