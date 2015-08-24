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
<xsl:include href="order_history_table_travel.xsl" />
<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>
<xsl:template match="/">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>Order History - Travel</title>

    <script type="text/javascript">
 	var page_no = 1;
   function revealDiv(n)
    {
		page_no = n;
		var url = '?target_component[]=TransMgmtFacade&amp;target_function[]=get_order_history_page_xml&amp;pgn='+n+'&amp;OF_passthru=order_history_table_travel&amp;type_id=4';
		//HTML_AJAX.replace("order_history_page_div", '?target_component[]=TransMgmtFacade&amp;target_function[]=get_order_history_page_xml&amp;pgn='+n+'&amp;OF_passthru=order_history_table_travel&amp;type_id=4');
		//pagerLinks(n);
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
		Order History
		</xsl:template>

</xsl:stylesheet>