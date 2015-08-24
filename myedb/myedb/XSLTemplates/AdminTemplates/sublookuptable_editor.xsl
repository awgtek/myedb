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
<xsl:param name="cat_id">0</xsl:param>
<xsl:include href="../include/page_sections/leftnavdiv.xsl"/>
<xsl:include href="../include/page_sections/topstripdiv.xsl"/>
<xsl:include href="pageframe2.xsl" />
<xsl:include href="../include/head_includes.xsl"/>
<xsl:include href="PageContents/sublookuptable_editor_pgct.xsl" />
<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>

<xsl:template match="/">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>Edit Categories</title>
	<link href="/stylesheets/main_style.css" rel="stylesheet" type="text/css" />

	<script type="text/javascript" src="/server.php?client=all"></script>

    <script type="text/javascript">
	var curpageno;
    function revealDiv(n)
    {
		curpageno = n;
//    HTML_AJAX.replace("searchresultsdiv", '?target_component[]=ClientServerDataOps&amp;target_function[]=initialize_sub_lookup_table&amp;pgn='+n+'&amp;OF_passthru=subcat_edit_search_results&amp;table_name=subcategory&amp;cat_id=<xsl:value-of select="$cat_id" />');
	HTML_AJAX.grab('?target_component[]=ClientServerDataOps&amp;target_function[]=initialize_sub_lookup_table&amp;pgn='+n+'&amp;OF_passthru=subcat_edit_search_results&amp;table_name=subcategory&amp;cat_id=<xsl:value-of select="$cat_id" />', set_targets);
		//document.getElementById("hidethisdiv").style.display = 'none';
  //  HTML_AJAX.replace('target', '?target_component[]=RecordIniFacade&amp;target_function[]=donothing&amp;output_function=output_html&amp;pageID='+n);

    }
	function set_targets(result)
	{
		$("searchresultsdiv").innerHTML = result;
	    HTML_AJAX.replace('target', '?target_component[]=RecordIniFacade&amp;target_function[]=donothing&amp;output_function=output_html&amp;pageID='+curpageno);
	
	}
    </script>
		<xsl:call-template name="head_include_tags" />
</head>

<body>
		<xsl:call-template name="pageframe">
		</xsl:call-template>
</body>
<xsl:if test="$cat_id != 0">
  <script type="text/javascript">
revealDiv(1);
</script>
</xsl:if>
</html>
</xsl:template>



<xsl:template name="page_frame_2_title">
	Edit Subcategories
</xsl:template>
</xsl:stylesheet>