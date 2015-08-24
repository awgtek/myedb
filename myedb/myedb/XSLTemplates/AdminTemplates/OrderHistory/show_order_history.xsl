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
xmlns:pl="urn:myedb:propertylist">
<xsl:include href="../../include/page_sections/leftnavdiv.xsl"/>
<xsl:include href="../../include/page_sections/topstripdiv.xsl"/>
<xsl:include href="../pageframe2.xsl" />
<xsl:include href="../PageContents/show_order_history_pgct.xsl" />
<xsl:include href="../../include/head_includes.xsl"/>
<xsl:include href="order_history_table.xsl" />
<xsl:param name="order_hist_eid" />
<xsl:param name="type_id" />
<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>
<xsl:template match="/">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>Order History </title>


    <script type="text/javascript">
	var page_no = 1;
	var sort_order = "desc";
	var order_by = "date_added";
	
    function revealDiv(n)
    {
		page_no = n;//old function for single eid: get_product_order_history_page_xml
		var url = '?target_component[]=TransMgmtFacade&amp;target_function[]=get_order_history_page_xml&amp;'+
		<xsl:if test="string-length($order_hist_eid) &gt; 0" >'eid=<xsl:value-of select="$order_hist_eid" />&amp;'+</xsl:if>
		<xsl:if test="string-length($type_id) &gt; 0" >'type_id=<xsl:value-of select="$type_id" />&amp;'+</xsl:if>
		'o='+order_by+'&amp;od='+sort_order+'&amp;pgn='+page_no+'&amp;OF_passthru='+
		<xsl:if test="string-length($type_id) = 0" >'admin_order_history_table'</xsl:if>
		<xsl:if test="string-length($type_id) &gt; 0" >'order_history_table_travel'</xsl:if>
		
	//	HTML_AJAX.replace("order_history_page_div", );

    	HTML_AJAX.grab(url,grabCallback);
  	}
	
	function grabCallback(result) {
    	document.getElementById('order_history_page_div').innerHTML = result;

		//setTimeout(pagerLinks(n), 5000)
		pagerLinks(page_no);

    }
	function pagerLinks(n)
	{
		HTML_AJAX.replace('target', 'index.php?target_component[]=RecordIniFacade&amp;target_function[]=donothing&amp;output_function=output_html&amp;pageID='+n);
	
	}
    </script>

		<xsl:call-template name="head_include_tags" />
		<style>
			th {text-align:center;}
		</style>
</head>
<body>
		<xsl:call-template name="pageframe">
		</xsl:call-template>
</body>
<script type="text/javascript">
	revealDiv(1); 
	function revealDiv_online(o)
	{
		order_by = o;
		revealDiv(page_no);
	}
	function revealDivCurrentCallBack(result)
	{
		alert(result);
		revealDiv(page_no);
	}
	function set_sort_order()
	{// alert('hello' + jQuery('#chk_sort_order_change:checked').val());
		var asc = jQuery('#chk_sort_order_change').is(':checked');
		//alert("hello"+ jQuery('#chk_sort_order_change').is(':checked'));
		if (asc)
		{
			sort_order = "asc";
		}
		else
		{ 
			sort_order = "desc";
		}
	}
</script>
</html>

</xsl:template>
	  <xsl:template name="page_frame_2_title">
		Order History 
		</xsl:template>

</xsl:stylesheet>