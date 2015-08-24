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
<xsl:include href="../../../include/templates/generic/location_items.xsl" />
<xsl:include href="../../../include/output_templates.xsl" />
<xsl:include href="print_field_text.xsl" />
<xsl:include href="../../../include/templates/generic/property.xsl"/>

<!--<xsl:include href="print_select.xsl" />-->
<xsl:include href="property.xsl" />
<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>



 <xsl:template match="record_with_ship_info">
 	<tr><td><table >
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


 	</table></td><td><table>

  <xsl:for-each select="property[generate-id(.)=generate-id(key('record',@ron)) ]">
	<!--  Sort Primary key by name in ascending order 
	  --> 
	 	<xsl:sort select="@ron" order="ascending" data-type="number"/> 
		<xsl:variable name="addressnum" select="@ron" />
		<tr class="sechead"><td colspan="2" > 
		select: <input type="radio" name="order_ship_addr"  >
			<xsl:attribute name="value">pgi<xsl:value-of select="@prop_group_id"/>ron<xsl:value-of select="@ron"/></xsl:attribute>
		</input>
		<xsl:if test="@epi = 0">
			New Shipping Address
		<input name="rep_prop_quals[]" type="hidden">
					<xsl:attribute name="value" >pqi1pgi<xsl:value-of select="@prop_group_id"/>ron<xsl:value-of select="@ron"/></xsl:attribute>
			</input>
		</xsl:if>
			<xsl:variable name="prop_group_id_var" select="@prop_group_id"/>
			<xsl:variable name="ron_var" select="@ron"/>
			<xsl:for-each select="/myedbroot/record/prop_qualifiers/prop_qualifier[@prop_group_id=$prop_group_id_var]">
					<xsl:if test="./@prop_qual_id = /record/rpqs/repeat_prop_qualifier[@prop_group_id=$prop_group_id_var and @ron=$ron_var]/@prop_qual_id"> 
					<xsl:value-of select="@qualifier"/>
					</xsl:if>
			</xsl:for-each>

		<xsl:for-each select="key('record',@ron)">
			<xsl:if test="@epi &gt; 0">
				<xsl:call-template name="formatted_location" />
			</xsl:if>
			<xsl:if test="@epi = 0">
				<xsl:choose>
					 <xsl:when test="@prop_name = 'State' " >
						<xsl:call-template name="states_select" />
					 </xsl:when>
					 <xsl:when test="@prop_name = 'Zip'" >
						<xsl:if test="@epi &gt; 0">
							<xsl:variable name="var_value" select="value" />
							<xsl:call-template name="print_lookup_value_in_input_field" >
								<xsl:with-param name="lkp_tbl_path" select="/myedbroot/lookup_table_zips/zip[@zip_id=$var_value]" />
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="@epi = 0">
							<xsl:apply-templates select="."  mode="lookup_standin_input_text_field_with_autocomplete" />
						</xsl:if>
					 </xsl:when>
					 <xsl:when test="@prop_name = 'City'" >
						<xsl:if test="@epi &gt; 0">
							<xsl:variable name="var_value" select="value" />
							<xsl:call-template name="print_lookup_value_in_input_field" >
								<xsl:with-param name="lkp_tbl_path" select="/myedbroot/lookup_table_cities/city[@city_id=$var_value]" />
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="@epi = 0">
							<xsl:apply-templates select="."  mode="lookup_standin_input_text_field_with_autocomplete" />
						</xsl:if>
					 </xsl:when>
					 <xsl:otherwise>
						<xsl:apply-templates select="." />
					 </xsl:otherwise>
				</xsl:choose>
			</xsl:if>
			
			
		 </xsl:for-each>
		</td></tr>
  </xsl:for-each>
		<tr class="sechead">
			<td colspan="2" >
				Will pick up: <input type="radio" name="order_ship_addr" value="will_pick_up"  />
			</td>
		</tr>
 	</table></td></tr>
	
 </xsl:template>
</xsl:stylesheet>