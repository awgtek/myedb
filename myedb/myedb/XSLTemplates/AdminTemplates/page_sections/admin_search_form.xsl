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
<xsl:param name="sel_spv2_pv" select="0"  />
<xsl:param name="sel_spv3_pv" select="0"  />
<xsl:param name="sel_spv1_pv" select="0"  />
<xsl:param name="sel_type_id_pv" select="0"  />
<xsl:param name="sel_cspi1_pv" select="0"  />

<xsl:template name="admin_search_form">
    <script type="text/javascript">
    function updateSubcatSelectDiv(thediv, n)
    {
		var url = '?target_component[]=ClientServerDataOps&amp;target_function[]=initialize_sub_lookup_table'+'&amp;OF_passthru=subcat_select&amp;table_name=subcategory&amp;cat_id='+n;
 //   HTML_AJAX.replace(thediv, url );
    document.getElementById(thediv).innerHTML = HTML_AJAX.grab(url);

    }
    </script>
	<script>
		function handle_select_page_rows_count(obj)
		{
			//alert('ischecked? ' + obj.checked + ' value: ' + obj.value + obj.options[obj.selectedIndex].text);
			var url;
		//	url = '?target_component[]=MetaDataOps&amp;target_function[]=' + target_function + '&amp;output_function=max_grouped_items_reached&amp;eid='+eid+'&amp;grptype='+obj.name;
			url = "?target_component[]=RecordIniFacade&amp;target_function[]=update_record&amp;output_function=do_nothing&amp;rec_eid=<xsl:value-of select='/myedbroot/logged_in_user_record/record/@eid' />&amp;rec_type_id=3&amp;<xsl:value-of select='/myedbroot/logged_in_user_record/record/property[@prop_id=62]/@ffi' />="  + obj.value;
		//	HTML_AJAX.grab(url);
			HTML_AJAX.grab(url,grabCallback_handle_select_page_rows_count);
		}
		function grabCallback_handle_select_page_rows_count(result)
		{ //alert(result);
		}
	</script>

	<div class="bodytext2">

	<form method="post" action="index.php">
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
			Rows per page:
	<select onchange="handle_select_page_rows_count(this)">
	<!--	<option value="4">
		<xsl:if test="/myedbroot/logged_in_user_record/record/property[@prop_id=62]/value = 4" >
			<xsl:attribute name="selected">selected</xsl:attribute>
		</xsl:if>
		4</option>-->
		<option value="25">
		<xsl:if test="/myedbroot/logged_in_user_record/record/property[@prop_id=62]/value = 25" >
			<xsl:attribute name="selected">selected</xsl:attribute>
		</xsl:if>
		25</option>
		<option  value="50">
		<xsl:if test="/myedbroot/logged_in_user_record/record/property[@prop_id=62]/value = 50" >
			<xsl:attribute name="selected">selected</xsl:attribute>
		</xsl:if>
		50</option>
		<option  value="100">
		<xsl:if test="/myedbroot/logged_in_user_record/record/property[@prop_id=62]/value = 100" >
			<xsl:attribute name="selected">selected</xsl:attribute>
		</xsl:if>
		100</option>
		<option value="10000" >
		<xsl:if test="/myedbroot/logged_in_user_record/record/property[@prop_id=62]/value &gt; 1000" >
			<xsl:attribute name="selected">selected</xsl:attribute>
		</xsl:if>
		All</option>
	</select>
	<span class="search"  >search:  &nbsp;</span>
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
						<xsl:attribute name="onclick">
							$('cspv_input').value = $('cspv_id').value;
							$('cspve_input').value = $('cspve_id').checked;
							$('cspvi_input').value = $('cspvi_id').checked;
							
							$('sel_srtpi_pv').value = $('sel_srtpi').selectedIndex;
							$('sel_spv2_pv').value = $('sel_spv2').selectedIndex;
							$('sel_spv3_pv').value = $('sel_spv3').selectedIndex;
							$('sel_spv1_pv').value = $('sel_spv1').selectedIndex;
							$('sel_type_id_pv').value = $('sel_type_id').selectedIndex;
							$('sel_cspi1_pv').value = $('sel_cspi1').selectedIndex;

						</xsl:attribute>
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
						<option value="1">By Name</option>
						<option value="2">By Description</option>
						<option value="12">By City</option>
						<option value="13">By State</option>
						<option value="33">By Account No.</option>
						<option value="53">By Account Manager</option>
						<option value="54">By Keyword</option>
						<option value="15">By Quantity</option>
						<option value="by_eid">By Product Link Number</option>
					</select>
					<input type="hidden" id="sel_type_id_pv" name="sel_type_id_pv" />
					<select name="type_id" id="sel_type_id">
						<option value="0">Any type</option>
						<option value="1">Gift Certificate</option>
						<option value="2">Ticket type</option>
						<option value="4">Travel type</option>
						<option value="5">Informational type</option>
					</select>
					
					<input type="hidden" name="spi[]" value="6" />
					<input type="hidden" id="sel_spv1_pv" name="sel_spv1_pv" />
					<select name="spv[]" onchange="updateSubcatSelectDiv('subcatselectdiv',options[selectedIndex].value)" id="sel_spv1">
							<option value="0">Any Category</option>
						<xsl:for-each select="//categories/category[@is_disabled != 1]">
							<option >
								<xsl:attribute name="value"><xsl:value-of select="@cat_id" /></xsl:attribute>
								<xsl:value-of select="catval" />
							</option>
						</xsl:for-each>
					</select>
					<span id="subcatselectdiv" />
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
					<input type="hidden" name="spi[]" value="35" />
					<input type="hidden" id="sel_spv2_pv" name="sel_spv2_pv" />
					<select name="spv[]"  id="sel_spv2">
							<option value="0">Any Status</option>
						<xsl:for-each select="//lookup_table_statuses/status">
							<option >
								<xsl:attribute name="value"><xsl:value-of select="@status_id" /></xsl:attribute>
								<xsl:value-of select="." />
							</option>
						</xsl:for-each>
					</select>
					<input type="hidden" id="sel_srtpi_pv" name="sel_srtpi_pv" />
					<select name="srtpi[]"  id="sel_srtpi">
						<option value="0">Sort by</option>
						<option value="1">By Name</option>
						<option value="12">By City</option>
						<option value="13">By State</option>
						<option value="33">By Account No.</option>
						<option value="53">By Account Manager</option>
						<option value="35">By Status</option>
					</select>
					<input type="hidden" name="target_component[]" value="RecordIniFacade"/>
					<input type="hidden" name="target_function[]" value="filtered_search_by_mixed_criteria"/>
					<input type="hidden" name="output_function" value="admin_paged_content" /><!--i.e. showrecs.xsl -->
					<input type="button" value="reset" onclick="reset_search_controls();" />
			</td>
			<script >
			
				$('sel_srtpi')[<xsl:value-of select="$sel_srtpi_pv" />].selected = true;
				$('sel_spv2')[<xsl:value-of select="$sel_spv2_pv" />].selected = true;	
				$('sel_spv1')[<xsl:value-of select="$sel_spv1_pv" />].selected = true;
				updateSubcatSelectDiv('subcatselectdiv',$('sel_spv1')[$('sel_spv1').selectedIndex].value);//alert($('sel_spv2')[$('sel_spv2').selectedIndex].value);
				$('sel_spv3')[<xsl:value-of select="$sel_spv3_pv" />].selected = true;
				$('sel_type_id')[<xsl:value-of select="$sel_type_id_pv" />].selected = true;
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
					$('sel_spv2')[0].selected = true;	
					$('sel_spv1')[0].selected = true;
					updateSubcatSelectDiv('subcatselectdiv',$('sel_spv1')[$('sel_spv1').selectedIndex].value);//alert($('sel_spv2')[$('sel_spv2').selectedIndex].value);
					$('sel_spv3')[0].selected = true;
					$('sel_type_id')[0].selected = true;
					$('sel_cspi1')[0].selected = true;
				}
			</script>
			</tr>
			</table>
				</form>
	</div>
</xsl:template>
</xsl:stylesheet>