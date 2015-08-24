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
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ext="http://exslt.org/common" 
>
   <xsl:import href="../../include/thirdparty/fxsl-1.2/strSplit-to-Words.xsl"/> 
    <xsl:import href="../../include/templates/generic/misc/strTakeWords.xsl"/> 



<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>
<xsl:param name="group-size" select="2" /> 

<xsl:template name="pagecontent">
		      <div id="public_center_content" >

<table border="0">
	<tr>
		<td>
          <xsl:value-of select="/myedbroot/records/record[@eid=283]/property[@prop_id=2]/value" />
		</td>
		<td>
		
		</td>
	</tr>
	<tr>
		<td valign="top">
		

	<table border="0">
		<!--<xsl:apply-templates select="/myedbroot/entity_grouping/entity_grouping_record/entity_grouping_field[@field_name='eg_type' and .=1 and (position() mod $group-size) = 1]/../entity_grouping_field[@field_name='eid']" /> -->
		<xsl:apply-templates select="/myedbroot/entity_grouping/entity_grouping_record[entity_grouping_field[@field_name='eg_type' and .=1 ]][(position() mod $group-size) = 1]/entity_grouping_field[@field_name='eid']" > 
		</xsl:apply-templates>
	</table>
	
	</td>
<td valign="top"><table width="350px" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><img src="images/home/deal-of-day.jpg" /></td>
      </tr>
      <tr>
        <td style="background-image:url(/images/darkgreen.gif); color:#FFF; height:200px; padding:5px;" valign="top"><div class="dealofday">
			<xsl:variable name="dotd_eid" select="/myedbroot/entity_grouping/entity_grouping_record/entity_grouping_field[@field_name='eg_type' and .=3]/../entity_grouping_field[@field_name='eid']" />
			<img align="right" >
				<xsl:attribute name="src">
					<xsl:value-of select='$app_root_client' />/client_uploaded_images/<xsl:value-of select="/myedbroot/records/record[@eid=$dotd_eid]/property[@prop_id=61]/value" /></xsl:attribute>
			</img>	
			<a style="color:#FFF; font-weight:bold; ">
				<xsl:attribute name="href">
					/index.php?target_component%5B%5D=RecordIniFacade&amp;target_function%5B%5D=initialize&amp;eid=<xsl:value-of select="$dotd_eid"/>&amp;type_id=<xsl:value-of select="/myedbroot/records/record[@eid=$dotd_eid]/@type_id"/>&amp;OF_passthru=show_purchasable_product</xsl:attribute>
		<xsl:value-of select="/myedbroot/records/record[@eid=$dotd_eid]/property[@prop_id=1]/value" />
			</a><br /><br />
					<xsl:value-of select="/myedbroot/records/record[@eid=$dotd_eid]/property[@prop_id=60]/value" /><!-- deal of the day text-->

		<!--<p>
			
          </p>-->
        </div></td>
      </tr>
      <tr>
        <td><img src="images/home/deal-bottom.jpg"  /></td>
      </tr>
    </table></td>		
  </tr>
  <tr>
  	 <td><br /><br /><br /><br /><br /><br /><br /><br /><br />
<strong>Popular Trades</strong></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2">
	<xsl:for-each select="/myedbroot/entity_grouping/entity_grouping_record[entity_grouping_field[@field_name='eg_type' and .=2 ]]/entity_grouping_field[@field_name='eid']">
			<xsl:variable name="curid" select="."/>
			<a>
				<xsl:attribute name="href">
					/index.php?target_component%5B%5D=RecordIniFacade&amp;target_function%5B%5D=initialize&amp;eid=<xsl:value-of select="$curid"/>&amp;type_id=<xsl:value-of select="/myedbroot/records/record[@eid=$curid]/@type_id"/>&amp;OF_passthru=show_purchasable_product</xsl:attribute>
		<xsl:value-of select="/myedbroot/records/record[@eid=$curid]/property[@prop_id=1]/value" />
			</a> &nbsp;
	</xsl:for-each>
	</td>
  </tr>
 
</table>
</div>
		<xsl:call-template name="pub_search_res_div" />
	
</xsl:template>

<xsl:template match="entity_grouping_field">
	<xsl:variable name="currow" select="position()" />
	<tr>
	<xsl:for-each select=". | ../following-sibling::entity_grouping_record[entity_grouping_field[@field_name='eg_type' and .=1 ]][position() &lt; $group-size]/entity_grouping_field[@field_name='eid']">
		<xsl:variable name="curid" select="."/>
        <td width="45%" hspace="6" vspace="6" border="0" valign="top">
		<xsl:if test="string-length(/myedbroot/records/record[@eid=$curid]/property[@prop_id=27]/value) &gt; 0">
	<img  hspace="6" vspace="6" border="0">
		<xsl:attribute name="align">
		<xsl:if test="$currow mod 2 = 1">right</xsl:if>
		<xsl:if test="$currow mod 2 = 0">left</xsl:if>
		</xsl:attribute>
				<xsl:attribute name="src">
					<xsl:value-of select='$app_root_client' />/client_uploaded_images/<xsl:value-of select="/myedbroot/records/record[@eid=$curid]/property[@prop_id=27]/value" /></xsl:attribute>
	</img>
		</xsl:if>
		<strong>
			<a>
				<xsl:attribute name="href">
					/index.php?target_component%5B%5D=RecordIniFacade&amp;target_function%5B%5D=initialize&amp;eid=<xsl:value-of select="$curid"/>&amp;type_id=<xsl:value-of select="/myedbroot/records/record[@eid=$curid]/@type_id"/>&amp;OF_passthru=show_purchasable_product</xsl:attribute>
		<xsl:value-of select="/myedbroot/records/record[@eid=$curid]/property[@prop_id=1]/value" />
			</a>
		</strong><br />
          <br />
	  <xsl:variable name="vwordNodes"> 
        <xsl:call-template name="str-split-to-words"> 
          <xsl:with-param name="pStr" select="/myedbroot/records/record[@eid=$curid]/property[@prop_id=2]/value"/> 
          <xsl:with-param name="pDelimiters"  
                          select="', &#9;&#10;&#13;()-'"/> 
        </xsl:call-template> 
      </xsl:variable> 
      <xsl:call-template name="strTakeWords"> 
        <xsl:with-param name="pN" select="30"/> 
        <xsl:with-param name="pText" select="/myedbroot/records/record[@eid=$curid]/property[@prop_id=2]/value"/> 
        <xsl:with-param name="pWords" 
             select="ext:node-set($vwordNodes)/*"/> 
      </xsl:call-template> &nbsp;
	  <a>
				<xsl:attribute name="href">
					/index.php?target_component%5B%5D=RecordIniFacade&amp;target_function%5B%5D=initialize&amp;eid=<xsl:value-of select="$curid"/>&amp;type_id=<xsl:value-of select="/myedbroot/records/record[@eid=$curid]/@type_id"/>&amp;OF_passthru=show_purchasable_product</xsl:attribute>...</a>

       <!--   <xsl:value-of select="/myedbroot/records/record[@eid=$curid]/property[@prop_id=2]/value" />-->
		</td>
	</xsl:for-each>		
	</tr>
</xsl:template>


 <!--   <xsl:template match="word" priority="10"> 
      <xsl:value-of select="concat(position(), ' ', ., '&#10;')"/> 
    </xsl:template> -->
 
</xsl:stylesheet>