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
<xsl:include href="list_category_links.xsl" />

<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>
<xsl:template name="leftnav_member"><style type="text/css">
<xsl:comment>
.style1 {font-family: Arial, Helvetica, sans-serif}
</xsl:comment>
</style>

	<script>
		function handle_select_page_rows_count(obj)
		{
			//alert('value attribute ' + obj.options[obj.selectedIndex].text + ' value: ' + obj.value);
			var url;
		//	url = '?target_component[]=MetaDataOps&amp;target_function[]=' + target_function + '&amp;output_function=max_grouped_items_reached&amp;eid='+eid+'&amp;grptype='+obj.name;
			url = "?target_component[]=RecordIniFacade&amp;target_function[]=update_record&amp;output_function=do_nothing&amp;rec_eid=<xsl:value-of select='/myedbroot/logged_in_user_record/record/@eid' />&amp;rec_type_id=3&amp;<xsl:value-of select='/myedbroot/logged_in_user_record/record/property[@prop_id=62]/@ffi' />=" + obj.value;
		//	HTML_AJAX.grab(url);
			HTML_AJAX.grab(url,grabCallback_handle_select_page_rows_count);
		}
		function grabCallback_handle_select_page_rows_count(result)
		{ //alert(result);
		}
	</script>
<table style="width:179px;">
<!--<tr>
	<td>

<a href="index.php?target_component%5B%5D=TransMgmtFacade&amp;target_function%5B%5D=get_pending_transactions&amp;output_function=show_pending_transactions">Cart</a>
<div style="background-image:url(images/home/left-nav-header.gif); background-repeat:no-repeat; color:#FFF; height:23px; padding-left:3px;">Search</div>
	</td>
</tr>-->
<tr>
	<td>
		<table width="100%">
			<tr>
				<td  style="width:170px; font-size:12px">
				<form method="post" action="index.php" id="searchform" style="width:170px">
					<input type="text" name="cspv[]" /> <br />(Enter name, number, <br />category, or keyword)
					<input name="cspi[]" type="hidden" value="1" /><!--name-->
					<input name="cspi[]" type="hidden" value="33" /><!--account number-->
					<input name="cspi[]" type="hidden" value="6" /><!--category-->
					<input name="cspi[]" type="hidden" value="54" /><!--keywords-->
					<br />
					<!--<select name="cspi[]">
						<option value="1">By Name</option>
						<option value="2">By Description</option>
						<option value="12">By City</option>
						<option value="13">By State</option>
						<option value="33">By Account No</option>
						<option value="6">By Category</option>
					</select>-->
					<!--<br /><select name="type_id">
						<option value="0">Any type</option>
						<option value="1">Gift certificates</option>
						<option value="2">Ticket type</option>
						<option value="4">Travel type</option>
						<option value="5">Informational type</option>
					</select>
					<br />-->
					<input type="hidden" name="spi[]" value="15" />
					<input type="hidden" name="spv[]" value="0" />
					<input type="hidden" name="spc[]" value="1" /><!--set to 1 if quantity (15) should be greater than 0-->
					<input type="hidden" name="spt[]" value="" />
					<input type="hidden" name="spg[]" value="1" />
					
					<input type="hidden" name="spi[]" value="1" />
					<input type="hidden" name="spv[]" value="" />
					<input type="hidden" name="spc[]" value="0" /><!--spc is only for numeric and is meaningless currently for prodid "1" (product name). We put 0 so that the criteria set isn't skipped-->
					<input type="hidden" name="spt[]" value="4" />
					<input type="hidden" name="spg[]" value="1" />
					
					<!--the above two groups are "OR'd" groups, indicated by the spg value. They should come first. 
					Below is the continuation of the previous pattern of ANDing sets of spx. I.e. the below would be 
					intersected with the set of eids produced above-->
					<input type="hidden" name="spi[]" value="6" />
					<select name="spv[]" id="spv[]" style="visibility:hidden">
							<option value="0">Any Category</option>
						<xsl:for-each select="//categories/category">
							<option >
								<xsl:attribute name="value"><xsl:value-of select="@cat_id" /></xsl:attribute>
								<xsl:value-of select="catval" />
							</option>
						</xsl:for-each>
					</select>
					<input type="hidden" name="spc[]" value="" /><!--leave spc blank to skip search and just select all (and let the other spx sets do the filtering-->
					<input type="hidden" name="spt[]" value="" />
					<input type="hidden" name="spg[]" value="" />

					<input type="hidden" name="spi[]" value="50" /><!--subcategory-->
					<input type="hidden" name="spv[]" value="0"  id="subcatspv" />
					<input type="hidden" name="spc[]" value="" /><!--leave spc blank to skip search and just select all (and let the other spx sets do the filtering-->
					<input type="hidden" name="spt[]" value="" />
					<input type="hidden" name="spg[]" value="" />
					
				<!--	
					<br />
					<select name="srtpi[]">
						<option value="0">Sort by</option>
						<option value="1">By Name</option>
						<option value="12">By City</option>
						<option value="13">By State</option>
					</select>
					-->
					<input type="hidden" name="target_component[]" value="RecordIniFacade"/>
					<input type="hidden" name="target_function[]" value="filtered_search_by_mixed_criteria"/>
					<input type="hidden" name="output_function" value="output_paged_templated_content" />
					<br /><input type="submit" value="GO"/>
				</form>
					Rows per page:
	<select onchange="handle_select_page_rows_count(this)">
		<option value="20">
		<xsl:if test="/myedbroot/logged_in_user_record/record/property[@prop_id=62]/value = 20" >
			<xsl:attribute name="selected">selected</xsl:attribute>
		</xsl:if>
		20</option>
		<option  value="40">
		<xsl:if test="/myedbroot/logged_in_user_record/record/property[@prop_id=62]/value = 40" >
			<xsl:attribute name="selected">selected</xsl:attribute>
		</xsl:if>
		40</option>
		<option  value="60">
		<xsl:if test="/myedbroot/logged_in_user_record/record/property[@prop_id=62]/value = 60" >
			<xsl:attribute name="selected">selected</xsl:attribute>
		</xsl:if>
		60</option>
		<option value="10000" >
		<xsl:if test="/myedbroot/logged_in_user_record/record/property[@prop_id=62]/value &gt; 1000" >
			<xsl:attribute name="selected">selected</xsl:attribute>
		</xsl:if>
		All</option>
	</select>
				</td>
			</tr>
		<!--	<xsl:call-template name="list_category_links" >
				<xsl:with-param name="param_type_id" select="1" />
			</xsl:call-template>
			<xsl:call-template name="list_category_links" >
				<xsl:with-param name="param_type_id" select="2" />
			</xsl:call-template>
			<xsl:call-template name="list_category_links" >
				<xsl:with-param name="param_type_id" select="4" />
			</xsl:call-template>
			<xsl:call-template name="list_category_links" >
				<xsl:with-param name="param_type_id" select="5" />
			</xsl:call-template>
			-->
		</table>
	</td>
</tr>
<tr>
	<td>
<div class="homeleftnav">
    <div style="background-image:url(images/home/left-nav-header.gif); background-repeat:no-repeat; color:#FFF; height:23px; padding-left:3px;">
    Barter Categories
    </div>
    <div class="navigationmain">
		<!--<br />
        Member Directory
        <a href="#">
			<xsl:attribute name="onclick">
				jQuery(jq("spv[]") +" option[value=1]").attr("selected",true); 
				//alert( jq("spv[]")); 
				jQuery("#searchform").submit();
				return false;
			</xsl:attribute>
		Restaurants
		</a><br />
         <a href="#">
			<xsl:attribute name="onclick">
				jQuery(jq("spv[]") +" option[value=9]").attr("selected",true); 
				jQuery("#searchform").submit();
				return false;
			</xsl:attribute>
		Sports &amp; Tickets
		</a><br />
        <a href="#">
			<xsl:attribute name="onclick">
				jQuery(jq("spv[]") +" option[value=11]").attr("selected",true); 
				jQuery("#searchform").submit();
				return false;
			</xsl:attribute>
		Travel
		</a><br />
        <a href="#">
			<xsl:attribute name="onclick">
				jQuery(jq("spv[]") +" option[value=3]").attr("selected",true); 
				jQuery("#searchform").submit();
				return false;
			</xsl:attribute>
		What's new
		</a>-->
        <xsl:apply-templates select="/myedbroot/categories/category[@is_disabled != 1]" />
     
    </div>
    <div style="background-image:url(images/home/left-nav-header.gif); background-repeat:no-repeat; color:#FFF; height:23px; padding-left:3px;">Information</div>
    <div class="navigationmain">
		<a href="http://newenglandtrade.com/contact-us/default.aspx" target="_blank">Contact Us</a><br />
      <a href="http://newenglandtrade.com/barter-expo/default.aspx" target="_blank">Barter Expo</a><br />
      <a href="http://newenglandtrade.com/blog/" target="_blank">Visit our Blog</a><br />
      <a href="index.php?target_component%5B%5D=RecordIniFacade&amp;target_function%5B%5D=donothing&amp;OF_passthru=barter_loop" >Barter Loop</a>
    </div>
    <div style="background-image:url(images/home/left-nav-header.gif); background-repeat:no-repeat; color:#FFF; height:23px; padding-left:3px;">Shopping Cart</div>
    <div class="navigationmain">
    <a href="index.php?target_component%5B%5D=TransMgmtFacade&amp;target_function%5B%5D=get_pending_transactions&amp;output_function=show_pending_transactions">Shopping Cart <br />
Information</a>
    </div>
    </div>	
	</td>
</tr>

</table>
					
</xsl:template>
<xsl:template match="category[@is_disabled != 1]">
	<xsl:if test="position() != 1">
<br />
</xsl:if>
        <a >
			<xsl:attribute name="href">javascript:getandputsubcats_public(<xsl:value-of select="@cat_id" />,"<xsl:value-of select="catval" />");</xsl:attribute>
	<!--		<xsl:attribute name="onclick">
				jQuery(jq("spv[]") +" option[value=<xsl:value-of select="@cat_id" />]").attr("selected",true); 
				jQuery("#searchform").submit();
				return false;
			</xsl:attribute>-->
		<xsl:value-of select="catval" />
		</a>
</xsl:template>
</xsl:stylesheet>