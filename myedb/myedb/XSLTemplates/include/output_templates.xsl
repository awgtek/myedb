<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet  [
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
<xsl:output method="html" encoding="utf-8"/>
<xsl:template match="/">

</xsl:template>
<!--
 <xsl:template name="inputrow" match="property">
 		 <tr>
		 <td>
		 <xsl:value-of select="@prop_name"/>
		 </td>
		 <td>
		 <input type="text"   >
		 <xsl:attribute name="id" >
			<xsl:value-of select="@ffi"/>
		 </xsl:attribute>
		 <xsl:attribute name="name" >
			<xsl:value-of select="@ffi"/>
		 </xsl:attribute>
		 <xsl:attribute name="value">
			<xsl:value-of select="value"/>
		 </xsl:attribute>
		 </input>
		 </td>
		 </tr>

 </xsl:template>
-->
	<xsl:template name="formatted_location" match="property[@prop_group_id='1']" mode="formatted_location_mode">
		 <xsl:choose>
			 <xsl:when test="@prop_name = 'City' or @prop_name = 'State' or @prop_name = 'Zip'" >
				<xsl:call-template name="formatted_city_state_zip" />
			 </xsl:when>
			 <xsl:otherwise>
				<xsl:if test="value != '' and @prop_id != '4'" ><!-- prop 4 is address line 1-->
<!--				<xsl:variable name="vRowInd">
<xsl:number />
</xsl:variable>
++
<xsl:value-of select="count(preceding-sibling::*[@col]) + 1"/>

<xsl:value-of select="position()" />=
<xsl:value-of select="$vRowInd" /> -->
					<br />
				</xsl:if>
				<xsl:apply-templates select="." mode="print_field_text"/>
			 </xsl:otherwise>
		 </xsl:choose>
	</xsl:template>

	<xsl:template name="formatted_city_state_zip">
		<xsl:param name="lookup_root" select="/myedbroot" />
		
		<xsl:variable name="var_value" select="value" />
		<xsl:if test="@prop_id = 12">
			 <br /> 
			<xsl:value-of select="$lookup_root/lookup_table_cities/city[@city_id=$var_value]" />,
		</xsl:if>
		<xsl:if test="@prop_id = 13">
			<xsl:value-of select="$lookup_root/lookup_table_states/state[@state_id=$var_value]" />
		</xsl:if>
		<xsl:if test="@prop_id = 14">
			<xsl:value-of select="$lookup_root/lookup_table_zips/zip[@zip_id=$var_value]" />
		</xsl:if>
		<xsl:text> </xsl:text>
	</xsl:template>

<!--  <xsl:template match="property" mode="print_field_text">
 		 <tr>
		 <td>
		 <xsl:value-of select="@prop_name"/>
		 </td>
		 <td>
			<xsl:value-of select="value"/>
		 </td>
		 </tr>

 </xsl:template>-->
<xsl:template name="print_select">
 		 <tr>
		 <td>
		 <xsl:value-of select="./@prop_name"/>
		 </td>
		 <td>
			<xsl:apply-templates select="./validator/select/option" mode="print_option_value"/>
		 </td>
		 </tr>
</xsl:template>

<xsl:template name="print_lookup_value_in_input_field">
	<xsl:param name="lkp_tbl_path" />
	<xsl:param name="lkp_tbl_plural" />
 		 <tr>
		 <td>
		 <xsl:value-of select="./@prop_name"/>
		 </td>
		 <td>
		 	<!--<xsl:variable name="var_value" select="value" />
			
			<xsl:apply-templates select="$lkp_tbl_path" mode="print_city_in_input_field">
				<xsl:with-param name="var_ffi" select="@ffi" />
				<xsl:with-param name="var_prop_id" select="@prop_id" />
			</xsl:apply-templates>-->
			
			<xsl:variable name="var_ffi" select="@ffi" />
			<xsl:variable name="var_prop_id" select="@prop_id" />
		
		<!--	<xsl:for-each select="$lkp_tbl_path" >
			</xsl:for-each>-->
				 <input type="text" class="input_text"   >
				 <xsl:attribute name="id" >standin_<xsl:value-of select="$var_ffi"/><!--NOTE!!! must add exception to validation_script.xsl!!-->
				 </xsl:attribute>
				 <xsl:attribute name="name" >standin_<xsl:value-of select="$var_ffi"/>
				 </xsl:attribute>
				 <xsl:attribute name="value">
					<xsl:value-of select="$lkp_tbl_path"/>
				 </xsl:attribute>
				 </input>
				<div style="background-color:#FFFF66">
					<xsl:attribute name="id">
						<xsl:value-of select="$var_ffi"/>_hint</xsl:attribute>
				</div>
				  <script type="text/javascript">   
						new Ajax.Autocompleter('standin_<xsl:value-of select="$var_ffi"/>','<xsl:value-of select="$var_ffi"/>_hint','<xsl:value-of select="$app_root_client" />/functions/lookuptables/lookup.php?prop_id=<xsl:value-of select="$var_prop_id"/>&amp;postedfield=standin_<xsl:value-of select="$var_ffi"/>');
					</script> 
				
		 </td>
		 </tr>
</xsl:template>

<xsl:template match="/myedbroot/lookup_table_cities/city" mode="print_city_in_input_field">
	<xsl:param name="var_ffi" />
	<xsl:param name="var_prop_id" />
		 <input type="text"   >
		 <xsl:attribute name="id" >standin_<xsl:value-of select="$var_ffi"/>
		 </xsl:attribute>
		 <xsl:attribute name="name" >standin_<xsl:value-of select="$var_ffi"/>
		 </xsl:attribute>
		 <xsl:attribute name="value">
			<xsl:value-of select="."/>
		 </xsl:attribute>
		 </input>
		<div style="background-color:#FFFF66">
			<xsl:attribute name="id">
				<xsl:value-of select="$var_ffi"/>_hint</xsl:attribute>
		</div>
		  <script type="text/javascript">   
				new Ajax.Autocompleter('standin_<xsl:value-of select="$var_ffi"/>','<xsl:value-of select="$var_ffi"/>_hint','<xsl:value-of select="$app_root_client" />/functions/lookuptables/lookup.php?prop_id=<xsl:value-of select="$var_prop_id"/>&amp;postedfield=standin_<xsl:value-of select="$var_ffi"/>');
			</script> 
		
</xsl:template> 

<xsl:template name="print_select_with_option_value_in_input_field">
 		 <tr>
		 <td>
		 <xsl:value-of select="./@prop_name"/>
		 </td>
		 <td>
			<xsl:apply-templates select="./validator/select/option" mode="print_option_value_in_input_field"/>
		 </td>
		 </tr>
</xsl:template>

<xsl:template match="option" mode="print_option_value">
	<xsl:if test="./@LUTR_id = ancestor::property/value"> 
		<xsl:value-of select="."/>
	</xsl:if>
</xsl:template> 

<xsl:template match="option" mode="print_option_value_in_input_field">
	<xsl:if test="./@LUTR_id = ancestor::property/value"> 
		 <input type="text"   >
		 <xsl:attribute name="id" >standin_<xsl:value-of select="ancestor::property/@ffi"/>
		 </xsl:attribute>
		 <xsl:attribute name="name" >standin_<xsl:value-of select="ancestor::property/@ffi"/>
		 </xsl:attribute>
		 <xsl:attribute name="value">
			<xsl:value-of select="."/>
		 </xsl:attribute>
		 </input>
		<div style="background-color:#FFFF66">
			<xsl:attribute name="id">
				<xsl:value-of select="ancestor::property/@ffi"/>_hint</xsl:attribute>
		</div>
		  <script type="text/javascript">   
				new Ajax.Autocompleter('standin_<xsl:value-of select="ancestor::property/@ffi"/>','<xsl:value-of select="ancestor::property/@ffi"/>_hint','<xsl:value-of select="$app_root_client" />/functions/lookuptables/lookup.php?prop_id=<xsl:value-of select="ancestor::property/@prop_id"/>&amp;postedfield=standin_<xsl:value-of select="ancestor::property/@ffi"/>');
			</script> 
		
	</xsl:if>
</xsl:template> 

 <xsl:template match="property" mode="append_standin">
 		 <tr>
		 <td>
		 <xsl:value-of select="@prop_name"/>
		 </td>
		 <td>
		 <input type="text"  class="input_text"  >
		 <xsl:attribute name="id" >standin_<xsl:value-of select="@ffi"/>
		 </xsl:attribute>
		 <xsl:attribute name="name" >standin_<xsl:value-of select="@ffi"/>
		 </xsl:attribute>
		 <xsl:attribute name="value">
			<xsl:value-of select="value"/>
		 </xsl:attribute>
		 </input>	
		 
		<div style="background-color:#FFFF66">
			<xsl:attribute name="id">
				<xsl:value-of select="@ffi"/>_hint</xsl:attribute>
		</div>
		  <script type="text/javascript">   
				new Ajax.Autocompleter('standin_<xsl:value-of select="@ffi"/>','<xsl:value-of select="@ffi"/>_hint','<xsl:value-of select="$app_root_client" />/functions/lookuptables/lookup.php?prop_id=<xsl:value-of select="@prop_id"/>&amp;postedfield=standin_<xsl:value-of select="@ffi"/>');
			</script> 

		 </td>
		 </tr>

 </xsl:template>
 
 <xsl:template match="property[@prop_id=8]" mode="password_check_and_append" >
 	<xsl:variable name="pswd_id"><xsl:value-of select="$pswd_prefix"/><xsl:value-of select="@ffi"/></xsl:variable>
  	<xsl:variable name="pswd_chk_id"><xsl:value-of select="$pswd_chk_prefix"/><xsl:value-of select="@ffi"/></xsl:variable>

 	<script>
		function check_password_equality()
		{
			document.getElementById('<xsl:value-of select="$pswd_id"/>').value = document.getElementById('<xsl:value-of select="$pswd_id"/>').value.trim();
			document.getElementById('<xsl:value-of select="$pswd_chk_id"/>').value = document.getElementById('<xsl:value-of select="$pswd_chk_id"/>').value.trim();
			return (document.getElementById('<xsl:value-of select="$pswd_id"/>').value == document.getElementById('<xsl:value-of select="$pswd_chk_id"/>').value);
		}
	</script>
	<script>
		function check_password_validity()
		{
			var re = /^.*(?=.{6,})(?=.*\d)(?=.*[A-Za-z]).*$|^$/;
			var pass_str = document.getElementById('<xsl:value-of select="$pswd_id"/>').value;
			return re.exec(pass_str);
		}
	</script>
 
  		 <tr>
		 <td>
		 <xsl:value-of select="@prop_name"/> &nbsp; <span class="bodytext2small">(Min 6 characters, at least<br /> one of each of numbers and characters)</span> :
		 </td>
		 <td>
		 <input type="password"   >
		 <xsl:attribute name="id" ><xsl:value-of select="$pswd_id"/>
		 </xsl:attribute>
		 <xsl:attribute name="name" ><xsl:value-of select="$pswd_id"/>
		 </xsl:attribute>
		 </input>	
		</td>
		</tr>
  		 <tr>
		 <td>
		 Retype <xsl:value-of select="@prop_name"/>:
		 </td>
		 <td>
		 <input type="password"   >
		 <xsl:attribute name="id" ><xsl:value-of select="$pswd_chk_id"/>
		 </xsl:attribute>
		 <xsl:attribute name="name" ><xsl:value-of select="$pswd_chk_id"/>
		 </xsl:attribute>
		 </input>	
		</td>
		</tr>
 
 </xsl:template>
 
 <xsl:template match="property" mode="lookup_standin_input_text_field_with_autocomplete">
 		 <tr>
		 <td>
		 <xsl:value-of select="@prop_name"/>
		 </td>
		 <td>
		 <input type="text"   >
		 <xsl:attribute name="id" >standin_<xsl:value-of select="@ffi"/>
		 </xsl:attribute>
		 <xsl:attribute name="name" >standin_<xsl:value-of select="@ffi"/>
		 </xsl:attribute>
		 <xsl:attribute name="value">
			<xsl:value-of select="value"/>
		 </xsl:attribute>
		 </input>	
		 
		<div style="background-color:#FFFF66">
			<xsl:attribute name="id">
				<xsl:value-of select="@ffi"/>_hint</xsl:attribute>
		</div>
		  <script type="text/javascript">   
				new Ajax.Autocompleter('standin_<xsl:value-of select="@ffi"/>','<xsl:value-of select="@ffi"/>_hint','<xsl:value-of select="$app_root_client" />/functions/lookuptables/lookup.php?prop_id=<xsl:value-of select="@prop_id"/>&amp;postedfield=standin_<xsl:value-of select="@ffi"/>');
			</script> 
		 </td>
		 </tr>

 </xsl:template>
 
 
 <xsl:template name="lookup_table_select"> 
 	<xsl:param name="lookup_table_path" />
 	<xsl:param name="lookup_table_id_attribute" />
		 <tr>
		 <td>
		 <xsl:value-of select="@prop_name"/>
		 </td>
		 <td>
		 <SELECT> 
<xsl:attribute name="name">
<xsl:value-of select="@ffi"/>
</xsl:attribute>
<xsl:attribute name="id">
<xsl:value-of select="@ffi"/>
</xsl:attribute>
<OPTION value="" selected="true">Select one</OPTION>
<xsl:call-template name="lookup_table_options">
	<xsl:with-param name="lookup_table_options_path" select="$lookup_table_path" />
	<xsl:with-param name="lookup_table_id_attribute" select="$lookup_table_id_attribute"/>
</xsl:call-template>
<!--<xsl:apply-templates select="/myedbroot/lookup_table_states/state" >
	<xsl:with-param name="state_id_value" select="value" />
</xsl:apply-templates>-->
</SELECT>
		 </td>
		 </tr>

</xsl:template>

<xsl:template name="lookup_table_options">
	<xsl:param name="lookup_table_options_path"/>
 	<xsl:param name="lookup_table_id_attribute" />
	<xsl:variable name="lookup_id_value" select="value"/>
	<xsl:for-each select="$lookup_table_options_path">
		<xsl:variable name="lookup_table_id" select="."/>
		<OPTION>
			<xsl:attribute name="value">
			<xsl:value-of select="."/>
			</xsl:attribute>
			<xsl:if test="$lookup_table_id = $lookup_id_value"> 
				<xsl:attribute name="SELECTED">true</xsl:attribute>
			</xsl:if>
			<xsl:value-of select=".."/>
		</OPTION>
	</xsl:for-each>
</xsl:template>


</xsl:stylesheet>