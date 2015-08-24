<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:include href="../include/page_sections/leftnavdiv.xsl"/>
<xsl:include href="../include/page_sections/topstripdiv.xsl"/>
<xsl:include href="../include/head_includes.xsl"/>
<xsl:include href="pageframe2.xsl" />

<xsl:include href="PageContents/admin_paged_content_pgct.xsl" />
<xsl:output method='html'/>

<!-- param values may be changed during the XSL Transformation -->
<xsl:param name="title">List Products</xsl:param>
<xsl:param name="script">person_list.php</xsl:param>
<xsl:param name="numrows">0</xsl:param>
<xsl:param name="curpage">1</xsl:param>
<xsl:param name="lastpage">1</xsl:param>
<xsl:param name="script_time">0.2744</xsl:param>
<xsl:param name="n_pages">0</xsl:param>
<xsl:param name="page_links">0</xsl:param>

<!-- include common templates 
<xsl:include href="std.pagination.xsl"/>
<xsl:include href="std.actionbar.xsl"/>
-->
<xsl:template match="/">

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title><xsl:value-of select="$title"/></title>
	<script type="text/javascript" src="/myedb/includes/js/search_functions.js" ></script>
<link href="/stylesheets/main_style.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
      <![CDATA[
      <!--
      -->
      ]]>
    </style><xsl:variable name="the_type_id" select="//records/record[@type_id]"/>
		<xsl:call-template name="head_include_tags" />

    <script type="text/javascript">
    var n_pages = <xsl:value-of select="$n_pages"/>;
	var cur_page_no;
	var	searchrestbl_url = '?target_component[]=RecordIniFacade&amp;target_function[]=filtered_search_by_mixed_criteria&amp;OF_passthru=admin_product_search_results';
    </script>

	<script>
		var curcheckbox;
		function handle_featured_checkbox_click(obj)
		{
			//alert('ischecked? ' + obj.checked + ' value: ' + obj.value);
			var eid = obj.value;
			var target_function;
			var url;
			if (obj.checked)
			{
				target_function = "GroupedItems_add_entity";
			}
			else
			{
				target_function = "GroupedItems_remove_entity";
			}
			url = '?target_component[]=MetaDataOps&amp;target_function[]=' + target_function + '&amp;output_function=max_grouped_items_reached&amp;eid='+eid+'&amp;grptype='+obj.name;
			curcheckbox = obj.name;
			HTML_AJAX.grab(url,grabCallback_FixFeaturedCheckboxes);
		}
		
		function grabCallback_FixFeaturedCheckboxes(result)
		{ //alert(result);
			if (result==1)//max_featured_reached
			{
				alert("Maximum featured items reached. Uncheck featured items before adding new featured items.");
				disableCheckbox(document.getElementsByName(curcheckbox),true);//name of checkboxes on search_records.xsl
			}
			else
			{
				disableCheckbox(document.getElementsByName(curcheckbox),false);//name of checkboxes on search_records.xsl
			}
		}
		function disableCheckbox(checkbox, disable) {
		  var max = checkbox.length;
		  for (var i=0; i &lt; max; i++) {
		  	if (!checkbox[i].checked)
			{
				checkbox[i].disabled = disable;
			}
		  }
		}
	</script>

</head>
<body>
		<xsl:call-template name="pageframe">
		</xsl:call-template>
</body>
  <script type="text/javascript">
revealDiv(1); 
</script>

</html>

</xsl:template>
	  <xsl:template name="page_frame_2_title">
		Manage Products<br />
		</xsl:template>


<!--
<xsl:template name="list_category_links">
	<xsl:param name="param_type_id" />
	<tr>
		<td>
			<xsl:value-of select="//types/type[@type_id=$param_type_id]"/> Categories:
		</td>
	</tr>
	<xsl:for-each select="//categories/category/cattypes[cattype = $param_type_id]" >
		<tr>	
		<td>
			<a >
			<xsl:attribute name="href">
	
	?target_component[]=RecordIniFacade&amp;target_function[]=search_by_prop_val&amp;spi=6&amp;spv=<xsl:value-of select="ancestor::category/@cat_id" />&amp;type_id=<xsl:value-of select="$param_type_id"/>&amp;output_function=admin_paged_content</xsl:attribute>
		<xsl:value-of select="ancestor::category/catval" />
			</a>
		</td>
		</tr>
	</xsl:for-each>
	<tr>
		<td>
			<a >
			<xsl:attribute name="href">
				?target_component[]=RecordIniFacade&amp;target_function[]=search_by_prop_val_contains&amp;spi=1&amp;spv=&amp;type_id=<xsl:value-of select="$param_type_id"/>&amp;output_function=admin_paged_content</xsl:attribute>
				Show all <xsl:value-of select="//types/type[@type_id=$param_type_id]"/> records				
			</a>
		</td>
	</tr>
</xsl:template>
-->
</xsl:stylesheet>
