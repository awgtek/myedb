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
<xsl:include href="../include/templates/generic/select_option.xsl"/>

<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>
<xsl:param name="spi" />

<xsl:template match="record" mode="product_type">

  <tr>
    <xsl:attribute name="class">
      <xsl:choose>
        <xsl:when test="position()mod 2">product-green</xsl:when>
        <xsl:otherwise>product-tan</xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>

    <td valign="top"><div align="left">
		<a >
		<xsl:attribute name="href">
			?target_component[]=RecordIniFacade&amp;target_function[]=initialize&amp;eid=<xsl:value-of select="@eid" />&amp;type_id=<xsl:value-of select="@type_id" />&amp;OF_passthru=show_<xsl:if test="@type_id = 4 or @type_id = 5">info_</xsl:if>record_for_edit</xsl:attribute>
		
	<xsl:value-of select="property[@prop_name='Product Name']/value"/>
		</a>
		</div>
	</td>
 <!--   <td valign="top"><div align="left"><xsl:value-of select="property[@prop_name='Description']/value"/></div></td>-->
    <td valign="top"><div align="left"><xsl:value-of select="property[@prop_id='33']/value"/></div></td><!--account number -->
    <td valign="top"><div align="left"><xsl:value-of select="@eid"/></div></td><!--Product Link number -->
    <td valign="top"><div align="left">
		<xsl:variable name="var_city" select="property[@prop_id=12][1]/value" />
		<xsl:value-of select="/myedbroot/lookup_table_cities/city[@city_id=$var_city and @is_disabled != 1]" />
		</div>
	</td>
    <td valign="top"><div align="left">
		<xsl:variable name="var_state" select="property[@prop_id=13][1]/value" />
		<xsl:value-of select="/myedbroot/lookup_table_states/state[@state_id=$var_state and @is_disabled != 1]" />
		</div>
	</td>
    <td valign="top"><div align="left">
		<xsl:variable name="var_acctmgr" select="property[@prop_id=53][1]/value" />
		<xsl:value-of select="/myedbroot/lookup_table_acctmgrs/acctmgr[@acctmgr_id=$var_acctmgr and @is_disabled != 1]" />
		</div>
	</td>
    <td valign="top"><div align="left">
		<xsl:variable name="var_status" select="property[@prop_id=35][1]/value" />
		<xsl:value-of select="/myedbroot/lookup_table_statuses/status[@status_id=$var_status and @is_disabled != 1]" />
		</div>
	</td>
    <td valign="top"><div align="left">
		<xsl:variable name="var_category1" select="property[@prop_id=6][1]/value" />
		<xsl:value-of select="/myedbroot/categories/category[@cat_id=$var_category1 and @is_disabled != 1]/catval" />
		</div>
	</td>
    <td valign="top"><div align="left">
		<xsl:variable name="_var_category1" select="property[@prop_id=6][1]/value" /><!--not sure why I can't just use var_category1 without it giving me errors-->
		<xsl:variable name="var_subcat1" select="property[@prop_id=50]/value" />
		<xsl:value-of select="/myedbroot/subcategories/subcategory[@subcat_id=$var_subcat1 and @cat_id=$_var_category1 and @is_disabled != 1][1]/@subcat_name" />
		</div>
	</td>
 <!--   <td valign="top"><div align="left">
		<xsl:variable name="var_category2" select="property[@prop_id=6][2]/value" />
		<xsl:value-of select="/myedbroot/categories/category[@cat_id=$var_category2 and @is_disabled != 1]/catval" />
		</div>
	</td>
    <td valign="top"><div align="left">
		<xsl:variable name="_var_category2" select="property[@prop_id=6][2]/value" />not sure why I can't just use var_category1 without it giving me errors
		<xsl:variable name="var_subcat2" select="property[@prop_id=50]/value" />
		<xsl:value-of select="/myedbroot/subcategories/subcategory[@subcat_id=$var_subcat2 and @cat_id=$_var_category2 and @is_disabled != 1][1]/@subcat_name" />
		</div>
	</td>-->
	<xsl:if test="$auth_level = 4">

		<td valign="top"><div align="left">
			<xsl:call-template name="print_delete_button" />
			</div>
		</td>
		<td valign="top"><div align="left">
			<xsl:call-template name="print_grouped_items_check_box" >
				<xsl:with-param name="param_eg_type" select="$eg_type__featured" />
				<xsl:with-param name="param_NumGroupedItemsMax" select="$NumFeaturedMax" />
				<xsl:with-param name="GroupedItems_type" select="'FeaturedItems'"/>
			</xsl:call-template>
			</div>
		</td>
		<td valign="top"><div align="left">
			<xsl:call-template name="print_grouped_items_check_box" >
				<xsl:with-param name="param_eg_type" select="$eg_type__populartrades" />
				<xsl:with-param name="param_NumGroupedItemsMax" select="$NumPopularTradesMax" />
				<xsl:with-param name="GroupedItems_type" select="'PopularTrades'"/>
			</xsl:call-template>
			</div>
		</td>
		<td valign="top"><div align="left">
			<xsl:call-template name="print_grouped_items_check_box" >
				<xsl:with-param name="param_eg_type" select="$eg_type__tradeoftheday" />
				<xsl:with-param name="param_NumGroupedItemsMax" select="$NumTradeOfTheDayMax" />
				<xsl:with-param name="GroupedItems_type" select="'TradeOfTheDay'"/>
			</xsl:call-template>
			</div>
		</td>
	</xsl:if>
  </tr>

</xsl:template>

<xsl:template match="record" mode="travel_type">

  <tr>
    <xsl:attribute name="class">
      <xsl:choose>
        <xsl:when test="position()mod 2">odd</xsl:when>
        <xsl:otherwise>even</xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>

    <td valign="top"><div align="left">
		<a >
		<xsl:attribute name="href">
			?target_component[]=RecordIniFacade&amp;target_function[]=initialize&amp;eid=<xsl:value-of select="@eid" />&amp;type_id=<xsl:value-of select="@type_id" />&amp;OF_passthru=edit_travel_type</xsl:attribute>
		
	<xsl:value-of select="property[@prop_id=32]/value"/>
		</a>
		</div>
	</td>
    <td valign="top"><div align="left"><xsl:apply-templates select="property[@prop_id=12][1]/validator/select/option" mode="print_option_value"/></div></td>
    <td valign="top"><div align="left"><xsl:apply-templates select="property[@prop_id=13][1]/validator/select/option" mode="print_option_value"/></div></td>
	<td valign="top"><div align="left">
		<xsl:call-template name="print_delete_button" />
		</div>
	</td>
  </tr>

</xsl:template>

<xsl:template name="print_grouped_items_check_box">
	<xsl:param name="param_eg_type" />
	<xsl:param name="param_NumGroupedItemsMax" />
	<xsl:param name="GroupedItems_type" />
	<xsl:variable name="group_type_count" select="count(/myedbroot/entity_grouping/entity_grouping_record/entity_grouping_field[@field_name='eg_type' and .=$param_eg_type])" />
	<xsl:variable name="max_reached" select="$group_type_count &gt;= $param_NumGroupedItemsMax" />
	<input type="checkbox" onclick="handle_featured_checkbox_click(this);"   >
			<xsl:attribute name="name">
				<xsl:value-of select="$GroupedItems_type" />
			</xsl:attribute>
			<xsl:attribute name="value">
				<xsl:value-of select="@eid" />
			</xsl:attribute>
			<xsl:variable name="featured_eid" select="@eid" />
			<xsl:choose>
				<xsl:when test="/myedbroot/entity_grouping/entity_grouping_record[entity_grouping_field[@field_name='eg_type' and . = $param_eg_type] and entity_grouping_field[@field_name='eid' and . = $featured_eid] ]">
					<xsl:attribute name="checked">
					</xsl:attribute>
				</xsl:when>
				<xsl:otherwise>
					<xsl:if test="$max_reached">
						<xsl:attribute name="disabled">disabled
						</xsl:attribute>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:if test="$auth_level &lt; 4">
				<xsl:attribute name="disabled">disabled</xsl:attribute>
			</xsl:if>
	</input>
</xsl:template>

<xsl:template name="print_delete_button">
		<form method="post" action="">
			<input type="hidden" name="target_component[]" value="RecordIniFacade" />
			<input type="hidden" name="target_function[]" value="delete_record" />
			<input type="hidden" name="target_component[]"  >
				<xsl:attribute name="value">
					<xsl:value-of select="$target_component"/>
				</xsl:attribute>
			</input>
			<input type="hidden" name="target_function[]"   >
				<xsl:attribute name="value">
					<xsl:value-of select="$target_function"/>
				</xsl:attribute>
			</input>
			<input type="hidden" name="spi"   >
				<xsl:attribute name="value">
					<xsl:value-of select="$spi"/>
				</xsl:attribute>
			</input>
			<input type="hidden" name="spv"   >
				<xsl:attribute name="value">
					<xsl:value-of select="$spv"/>
				</xsl:attribute>
			</input>
			<input type="hidden" name="type_id"   >
				<xsl:attribute name="value">
					<xsl:value-of select="$type_id"/>
				</xsl:attribute>
			</input>
			<input type="hidden" name="output_function"   >
				<xsl:attribute name="value">
					<xsl:value-of select="$output_function"/>
				</xsl:attribute>
			</input>
			
			<input type="hidden" name="eid"  >
			<xsl:attribute name="value">
				<xsl:value-of select="@eid" />
			</xsl:attribute>
			</input>
			<input type="submit" value="delete" onclick="return confirm('Are you sure you want to delete?')"  >
				<xsl:if test="$auth_level &lt; 4">
					<xsl:attribute name="disabled">disabled</xsl:attribute>
				</xsl:if>
			</input>
		
		</form>

</xsl:template>

</xsl:stylesheet>