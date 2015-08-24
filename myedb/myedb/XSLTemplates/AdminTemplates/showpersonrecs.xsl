<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:include href="../include/page_sections/leftnavdiv.xsl"/>
<xsl:include href="../include/page_sections/topstripdiv.xsl"/>
<xsl:include href="pageframe2.xsl" />
<xsl:include href="PageContents/showpersonrecs_pgct.xsl" />

<xsl:output method='html'/>

<!-- param values may be changed during the XSL Transformation -->
<xsl:param name="title">List PERSON</xsl:param>
<xsl:param name="script">person_list.php</xsl:param>
<xsl:param name="numrows">0</xsl:param>
<xsl:param name="curpage">1</xsl:param>
<xsl:param name="lastpage">1</xsl:param>
<xsl:param name="script_time">0.2744</xsl:param>
<xsl:param name="n_pages">1</xsl:param>
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
	select="//records/record[position() = 1]"><xsl:value-of select="@type_id" /></xsl:for-each>&amp;output_function=output_person_links&amp;pageID='+n);
    }
    </script>

<!--<xsl:call-template name="horiz-menu-header-code"/>-->
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

<xsl:template match="record">

  <tr>
    <xsl:attribute name="class">
      <xsl:choose>
        <xsl:when test="position()mod 2">odd</xsl:when>
        <xsl:otherwise>even</xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>

    <td valign="top"><div align="center">
		<a >
		<xsl:attribute name="href">
			?target_component[]=RecordIniFacade&amp;target_function[]=initialize&amp;eid=<xsl:value-of select="@eid" />&amp;type_id=<xsl:value-of select="@type_id" />&amp;output_function=edit_person</xsl:attribute>
		
	<xsl:value-of select="property[@prop_name='User ID']/value"/>
		</a>
		</div>
	</td>
    <td valign="top"><div align="center"><xsl:value-of select="property[@prop_name='First Name']/value"/></div></td>
    <td valign="top"><div align="center"><xsl:value-of select="property[@prop_name='User Authorization Level']/value"/></div></td>
	<td valign="top"><div align="center">
		<form method="post" action="">
			<input type="hidden" name="target_component[]" value="RecordIniFacade" />
			<input type="hidden" name="target_function[]" value="delete_record" />
			<input type="hidden" name="target_component[]" value="RecordIniFacade" />
			<input type="hidden" name="target_function[]" value="search_by_prop_val_contains" />
			<input type="hidden" name="spi" value="8"/>
			<input type="hidden" name="spv" value=""/>
			<input type="hidden" name="type_id" value="3" />
			<input type="hidden" name="OF_passthru" value="showpersonrecs"  />
			
			<input type="hidden" name="eid"  >
			<xsl:attribute name="value">
				<xsl:value-of select="@eid" />
			</xsl:attribute>
			</input><input type="submit" value="delete"  onclick="return confirm('Are you sure you want to delete?')" />
					
		
		</form>
		</div>
	</td>
  </tr>

</xsl:template>

<xsl:template name="page_frame_2_title">
	List Users
</xsl:template>

</xsl:stylesheet>
