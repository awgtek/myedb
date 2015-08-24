<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:include href="include/header.xsl"/>

<xsl:output method='html'/>

<!-- param values may be changed during the XSL Transformation -->
<xsl:param name="title">List PERSON</xsl:param>
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
    HTML_AJAX.replace('target', '?target_component=RecordIniFacade&amp;target_function=initializeRecordSet<xsl:for-each 
	select="//records/record">&amp;eids[]=<xsl:value-of select="@eid" /></xsl:for-each>&amp;type_id=<xsl:for-each 
	select="//records/record[position() = 1]"><xsl:value-of select="@type_id" /></xsl:for-each>&amp;output_function=output_html&amp;pageID='+n);
    }
    </script>

</head>
<body>
 <xsl:variable name="testvar" select="'hello'" />
<xsl:call-template name="make-header">
  <xsl:with-param name="value" select="$testvar"/>
</xsl:call-template>


  <script type="text/javascript" src="/server.php?client=all"></script>
<table width="100%" border="1">
  <tr>
    <td width="21%"></td>
    <td width="79%"></td>
  </tr>
  <tr>
    <td>
		<table>
			<xsl:apply-templates select="//categories/category[@is_disabled != 1]" />
		</table>
	 </td>
    <td><form method="post" action="{$script}">
      <div class="center">
        <div id="target">I'm the target, put page links here</div>
        <table border="0" width="400px">
          <caption>
            <xsl:value-of select="$title"/>
            </caption>
          <thead>
            <tr>
              <th>Person ID</th>
              <th>First Name</th>
              <th>Last Name</th>
              <th>Star Sign</th>
            </tr>
          </thead>
          <xsl:for-each select="(//record)[position() mod 2 = 1]">
            <xsl:variable name="node-position" select="position() * 2"/>    
            <xsl:element name="tbody">
              <xsl:attribute name="id">page<xsl:value-of select="position()"/></xsl:attribute>
              <xsl:attribute name="class">page</xsl:attribute>
              <xsl:apply-templates select="(//record)[position() &lt;= $node-position and position() &gt; $node-position - 2]" />
                          </xsl:element>
          </xsl:for-each>
        </table>
        <!-- insert the page navigation links 
  <xsl:call-template name="pagination" />-->
        <!-- create standard action buttons 
  <xsl:call-template name="actbar"/>-->
      </div>
    </form></td>
  </tr>
  <tr>
    <td></td>
    <td></td>
  </tr>
</table>
</body>
  <script type="text/javascript">
revealDiv(1);
</script>

</html>

</xsl:template>

<xsl:template match="record">

  <tr>
    <xsl:attribute name="class">
      <xsl:choose>
        <xsl:when test="position()mod 2">odd</xsl:when>
        <xsl:otherwise>even</xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>

    <td>
		<a >
		<xsl:attribute name="href">
			?target_component=RecordIniFacade&amp;target_function=initialize&amp;eid=<xsl:value-of select="@eid" />&amp;type_id=<xsl:value-of select="@type_id" />
		</xsl:attribute>
		
	<xsl:value-of select="property[@prop_name='Product Name']/value"/>
		</a>
	
	</td>
    <td><xsl:value-of select="property[@prop_name='Description']/value"/></td>
    <td><xsl:value-of select="property[@prop_name='Address Line 1']/value"/></td>
    <td><xsl:value-of select="property[@prop_name='Address Line 2']/value"/></td>
  </tr>

</xsl:template>

<xsl:template match="category">
<tr>	<td>
		<a >
		<xsl:attribute name="href">

?target_component=RecordIniFacade&amp;target_function=search_by_prop_val&amp;spi=6&amp;spv=<xsl:value-of select="@cat_id" />&amp;type_id=1&amp;output_function=output_paged_templated_content</xsl:attribute>
	<xsl:value-of select="." />
		</a>
	</td>
	</tr>

</xsl:template>

</xsl:stylesheet>
