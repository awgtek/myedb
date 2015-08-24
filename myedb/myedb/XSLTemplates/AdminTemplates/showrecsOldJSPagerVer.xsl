<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:include href="../include/page_sections/page_includes.xsl"/>
<xsl:include href="../include/templates/generic/select_option.xsl"/>
<xsl:include href="search_records.xsl"/>
<xsl:include href="../include/head_includes.xsl"/>

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
<link href="/stylesheets/main_style.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
      <![CDATA[
      <!--
        caption { font-weight: bold; }
        th { background: #cceeff; }
        tr.odd { background: #eeeeee; }
        tr.even { background: #dddddd; }
        .center { text-align: center; }
		div.page {
		  background: #FFFF99;
		  border-top: 1px solid #FFBF99;
		  border-bottom: 1px solid #FFBF99;
		}
      -->
      ]]>
    </style><xsl:variable name="the_type_id" select="//records/record[@type_id]"/>
    <script type="text/javascript">
    var n_pages = <xsl:value-of select="$n_pages"/>;
    function revealDiv(n)
    {
        for (var count = 1; count &lt;= n_pages; count++) { //alert(document.getElementById("page"+count).innerHTML);
          document.getElementById("page"+count).style.display = 'none';
        }
        document.getElementById("page"+n).style.display = 'block';
    HTML_AJAX.replace('target', '?target_component[]=RecordIniFacade&amp;target_function[]=initializeRecordSet<xsl:for-each 
	select="//records/record">&amp;eids[]=<xsl:value-of select="@eid" /></xsl:for-each>&amp;type_id=<xsl:for-each 
	select="//records/record[position() = 1]"><xsl:value-of select="@type_id" /></xsl:for-each>&amp;output_function=output_html&amp;pageID='+n);
    }
    </script>

		<xsl:call-template name="head_include_tags" />
</head>
<body>
<xsl:call-template name="horiz-menu" />

<div id="site">

  <script type="text/javascript" src="/server.php?client=all"></script>
<table width="100%" border="1">

  <tr>
  <!--  <td>
		<table width="100%">
		<tr>
			<td>Search: 
				<form method="post" action="">
					<input type="text" name="spv" /><br />
					<select name="spi">
						<option value="1">By Name</option>
						<option value="2">By Description</option>
						<option value="12">By City</option>
						<option value="13">By State</option>
					</select>
					<br /><select name="type_id">
						<option value="1">Inventory type</option>
						<option value="2">Ticket type</option>
						<option value="4">Travel type</option>
						<option value="5">Informational type</option>
					</select>
					<input type="hidden" name="target_component[]" value="RecordIniFacade"/>
					<input type="hidden" name="target_function[]" value="search_by_prop_val_contains"/>
					<input type="hidden" name="output_function" value="admin_paged_content" />
					<br /><input type="submit" value="GO"/>
				</form>
			</td>
		</tr>
		<xsl:call-template name="list_category_links" >
			<xsl:with-param name="param_type_id" select="1" />
		</xsl:call-template>
		<xsl:call-template name="list_category_links" >
			<xsl:with-param name="param_type_id" select="2" />
		</xsl:call-template>
		</table>
	 </td>-->
    <td valign="top">
      <div class="center">
        <div id="target">No Search Results</div>
        <table border="0" width="100%">
          <caption>
            <xsl:value-of select="$title"/>
            </caption>
          <thead>
            <tr>
			<!--	<xsl:choose>
					<xsl:when test="$type_id = 4">
						<th>Property</th>
						<th>City</th>
						<th>State</th>
					</xsl:when>
					<xsl:otherwise>-->
					  <th>Product</th>
					  <th>Description</th>
					  <th>City</th>
					  <th>State</th>
			<!--		</xsl:otherwise>
				</xsl:choose>-->
            </tr>
          </thead>
		  <xsl:variable name="pagecnt" select="4" />
          <xsl:for-each select="(//record)[position() mod $pagecnt = 1]">
            <xsl:variable name="node-position" select="position() * $pagecnt"/>    
            <xsl:element name="tbody">
              <xsl:attribute name="id">page<xsl:value-of select="position()"/></xsl:attribute>
              <xsl:attribute name="class">page</xsl:attribute>
				<!--<xsl:choose>
					<xsl:when test="$type_id = 4">
		              <xsl:apply-templates select="(//record)[position() &lt;= $node-position and position() &gt; $node-position - $pagecnt]" mode="travel_type" />
					</xsl:when>
					<xsl:otherwise>-->
		              <xsl:apply-templates select="(//record)[position() &lt;= $node-position and position() &gt; $node-position - $pagecnt]" mode="product_type" />
			<!--		</xsl:otherwise>
				</xsl:choose>-->
            </xsl:element>
          </xsl:for-each>
        </table>
        <!-- insert the page navigation links 
  <xsl:call-template name="pagination" />-->
        <!-- create standard action buttons 
  <xsl:call-template name="actbar"/>-->
      </div>
    </td>
  </tr>
  <tr>
    <td></td>
    <td></td>
  </tr>
</table>
</div>
</body>
  <script type="text/javascript">
revealDiv(1);
</script>

</html>

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
