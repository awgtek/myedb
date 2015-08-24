<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:include href="../include/page_sections/leftnavdiv.xsl"/>
<xsl:include href="../include/page_sections/topstripdiv.xsl"/>
<xsl:include href="page_sections/search_member_users_form.xsl"/>
<xsl:include href="../include/head_includes.xsl"/>
<xsl:include href="pageframe3_noproductsearchform.xsl" />
<!--<xsl:include href="PageContents/showmember_personrecs_pgct.xsl" />-->
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
	<script type="text/javascript" src="/myedb/includes/js/search_functions.js" ></script>
		<xsl:call-template name="head_include_tags" />
    <style type="text/css">
      <![CDATA[
      <!--
      -->
      ]]>
    </style><xsl:variable name="the_type_id" select="//records/record[@type_id]"/>
    <script type="text/javascript">
    var n_pages = <xsl:value-of select="$n_pages"/>;
	var cur_page_no;
	var	searchrestbl_url = '?target_component[]=RecordIniFacade&amp;target_function[]=filtered_search_by_mixed_criteria&amp;OF_passthru=search_member_user_results';
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
			?target_component[]=RecordIniFacade&amp;target_function[]=initialize&amp;eid=<xsl:value-of select="@eid" />&amp;type_id=<xsl:value-of select="@type_id" />&amp;OF_passthru=edit_person_member</xsl:attribute>
		
	<xsl:value-of select="property[@prop_name='User ID']/value"/>
		</a>
		</div>
	</td>
     <td valign="top"><div align="center"><xsl:value-of select="property[@prop_id='9']/value"/></div><xsl:text> </xsl:text></td>
   <td valign="top"><div align="center"><xsl:value-of select="property[@prop_id='36']/value"/></div><xsl:text> </xsl:text></td>
   <!-- <td valign="top"><div align="center"><xsl:value-of select="property[@prop_name='User Authorization Level']/value"/></div><xsl:text> </xsl:text></td>-->
	<td valign="top"><div align="center">
		<form method="post" action="">
			<input type="hidden" name="target_component[]" value="RecordIniFacade" />
			<input type="hidden" name="target_function[]" value="delete_record" />
			<input type="hidden" name="target_component[]" value="RecordIniFacade" />
			<input type="hidden" name="target_function[]" value="filtered_search_by_mixed_criteria" />
			<input type="hidden" name="cspi[]" value="7"/>
			<input type="hidden" name="cspv[]" value=""/>
			<input type="hidden" name="cspt[]" value="3"/>
			<input type="hidden" name="spt[]" value="3"/>
			<input type="hidden" name="spi[]" value="25"/>
			<input type="hidden" name="spv[]" value="0"/>
			<input type="hidden" name="spc[]" value="-1"/>
			
			<input type="hidden" name="type_id" value="3" />
			<!--<input type="hidden" name="OF_passthru" value="showpersonrecs"  />-->
			
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
	List Member Users
</xsl:template>

</xsl:stylesheet>
