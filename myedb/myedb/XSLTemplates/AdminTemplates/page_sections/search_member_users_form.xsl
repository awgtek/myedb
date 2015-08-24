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
<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>
<xsl:param name="cspv_input" select="''" />
<xsl:param name="cspve_input" select="''" />
<xsl:param name="cspvi_input" select="''" />
<xsl:param name="sel_srtpi_pv" select="0"  />
<!--<xsl:param name="sel_spv2_pv" select="0"  />
<xsl:param name="sel_spv3_pv" select="0"  />
<xsl:param name="sel_spv1_pv" select="0"  />
<xsl:param name="sel_type_id_pv" select="0"  />-->
<xsl:param name="sel_cspi1_pv" select="0"  />

<xsl:template name="admin_search_users_form">
	<div class="bodytext2">

	<form method="get" action="index.php" >
						<xsl:attribute name="onsubmit">
							$('cspv_input').value = $('cspv_id').value;
							$('cspve_input').value = $('cspve_id').checked;
							$('cspvi_input').value = $('cspvi_id').checked;
							
							$('sel_srtpi_pv').value = $('sel_srtpi').selectedIndex;
							//$('sel_spv2_pv').value = $('sel_spv2').selectedIndex;
							//$('sel_spv1_pv').value = $('sel_spv1').selectedIndex;
							$('sel_cspi1_pv').value = $('sel_cspi1').selectedIndex;
//alert($('sel_srtpi_pv').value + " is the value from " + $('sel_srtpi') + " or jquery: " + jQuery('#sel_srtpi').attr("selectedIndex"));
						</xsl:attribute>
		
		<input type="hidden" name="init_post" value="1" />
		<input type="hidden" name="cspv_input" id="cspv_input"  />
		<input type="hidden" name="cspve_input" id="cspve_input"  >
			<xsl:attribute name="value"><xsl:value-of select="$cspve_input"/></xsl:attribute>
		</input>
		<input type="hidden" name="cspvi_input" id="cspvi_input"  >
			<xsl:attribute name="value"><xsl:value-of select="$cspvi_input"/></xsl:attribute>
		</input>
	<table cellpadding="0" cellspacing="0" width="100%">
		<tr>
			<td>
	<span class="search"  >search:  &nbsp;</span>
						<input  name="cspt[]" type="hidden" value="3" />

					<input type="text" name="cspv[]" id="cspv_id" >
						<xsl:attribute name="value" ><xsl:value-of select="$cspv_input" /></xsl:attribute>
					</input> &nbsp;
					<label for="cspve_id" >Exact match</label>
					<input type="checkbox" name="cspve[]" id="cspve_id" />
		<!--				<xsl:attribute name="checked"><xsl:value-of select="$cspve_input" /></xsl:attribute>
					</input>-->
					<label for="cspvi_id" >Inverse match</label><input type="checkbox" name="cspvi[]" id="cspvi_id" />
					&nbsp;					
					<input type="submit" value="GO" >
					</input>

			</td>
		</tr>
		<tr>
			<td >
					<!--<input name="cspi[]" type="hidden" value="1" />name-->
					<!--<input name="cspi[]" type="hidden" value="33" />account number-->
					<!--<input name="cspi[]" type="hidden" value="6" />category-->
					<!--<input name="cspi[]" type="hidden" value="54" />keywords-->
					<input type="hidden" id="sel_cspi1_pv" name="sel_cspi1_pv" />
					<select name="cspi[]" id="sel_cspi1">
						<option value="7">By User ID</option>
						<option value="36">By Last Name</option>
						<option value="9">By First Name</option>
						<option value="11">By Phone Number</option>
						<option value="33">By Account Number</option>
						<option value="65">By Business Name</option>
						<option value="31">By Active</option>
						<option value="34">By Registered</option>
						<option value="by_eid">By site ID</option>
					</select>
					
					
				<!--	<input type="hidden" name="spi[]" value="6" />
					<select name="spv[]" onchange="updateSubcatSelectDiv('subcatselectdiv2',options[selectedIndex].value)">
							<option value="0">Any Category</option>
						<xsl:for-each select="//categories/category[@is_disabled != 1]">
							<option >
								<xsl:attribute name="value"><xsl:value-of select="@cat_id" /></xsl:attribute>
								<xsl:value-of select="catval" />
							</option>
						</xsl:for-each>
					</select>
					<span id="subcatselectdiv2" />-->
					<input type="hidden" name="spi[]" value="25" />
					<input type="hidden" name="spv[]" value="0" />
					<input type="hidden" name="spc[]" value="-1" />
				<!--	<input type="hidden" id="sel_spv2_pv" name="sel_spv2_pv" />
					<select name="spv[]"  id="sel_spv2">
							<option value="0">Any Authorization Level</option>
							<option value="4">Level 4</option>
					</select>-->
					<input type="hidden" id="sel_srtpi_pv" name="sel_srtpi_pv" />
					<select name="srtpi[]"  id="sel_srtpi">
						<option value="0">Sort by</option>
						<option value="7">By User ID</option>
						<option value="36">By Last Name</option>
						<option value="9">By First Name</option>
						<option value="11">By Phone Number</option>
						<option value="33">By Account Number</option>
						<option value="65">By Business Name</option>
						<option value="31">By Active</option>
						<option value="34">By Registered</option>
					</select>
					<input type="hidden" name="target_component[]" value="RecordIniFacade"/>
					<input type="hidden" name="target_function[]" value="filtered_search_by_mixed_criteria"/>
					<input type="hidden" name="OF_passthru" value="show_member_personrecs" /><!--i.e. showrecs.xsl -->
					<input type="button" value="reset" onclick="reset_search_controls();" />
			</td>
			<script >
			
				$('sel_srtpi')[<xsl:value-of select="$sel_srtpi_pv" />].selected = true;
				//$('sel_spv2')[<xsl:value-of select="$sel_spv2_pv" />].selected = true;	
				//updateSubcatSelectDiv('subcatselectdiv',$('sel_spv1')[$('sel_spv1').selectedIndex].value);//alert($('sel_spv2')[$('sel_spv2').selectedIndex].value);
				//$('')[<xsl:value-of select="$sel_type_id_pv" />].selected = true;
				$('sel_cspi1')[<xsl:value-of select="$sel_cspi1_pv" />].selected = true;
				if (jQuery('#cspve_input').val() == 'true')
				{
					jQuery('#cspve_id').attr('checked','checked'); //add the atrribute checked
				}
				else
				{
					jQuery('#cspve_id').removeAttr("checked");     //remove the attribute checked
				}
				if (jQuery('#cspvi_input').val() == 'true')
				{
					jQuery('#cspvi_id').attr('checked','checked'); //add the atrribute checked
				}
				else
				{
					jQuery('#cspvi_id').removeAttr("checked");     //remove the attribute checked
				}
			//	alert(jQuery('#cspve_input').val());
        
			</script>
			<script>
				function reset_search_controls() 
				{
					$("cspv_id").value = "";
					$("cspve_id").checked = "";
					$("cspvi_id").checked = "";
					$('sel_srtpi')[0].selected = true;
					//$('sel_spv2')[0].selected = true;	
					//updateSubcatSelectDiv('subcatselectdiv',$('sel_spv1')[$('sel_spv1').selectedIndex].value);//alert($('sel_spv2')[$('sel_spv2').selectedIndex].value);
					//$('sel_type_id')[0].selected = true;
					$('sel_cspi1')[0].selected = true;
				}
			</script>
			</tr>
			</table>
				</form>
	</div>
</xsl:template>
</xsl:stylesheet>