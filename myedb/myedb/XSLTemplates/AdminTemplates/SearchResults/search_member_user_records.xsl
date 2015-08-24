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
<xsl:include href="../../include/templates/generic/select_option.xsl"/>

<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>
<xsl:param name="spi" />

<xsl:template match="record" mode="product_type">

  <tr>
    <xsl:attribute name="class">
      <xsl:choose>
        <xsl:when test="position()mod 2">product-green</xsl:when>
        <xsl:otherwise>product-tan</xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>

    <td valign="top"><div align="left">
		<a >
		<xsl:attribute name="href">
			?target_component[]=RecordIniFacade&amp;target_function[]=initialize&amp;eid=<xsl:value-of select="@eid" />&amp;type_id=<xsl:value-of select="@type_id" />&amp;OF_passthru=edit_person_member</xsl:attribute>
		
	<xsl:value-of select="property[@prop_id='7']/value"/>
		</a>
		</div>
	</td>
 <!--   <td valign="top"><div align="left"><xsl:value-of select="property[@prop_name='Description']/value"/></div></td>-->
    <td valign="top"><div align="left"><xsl:value-of select="property[@prop_id='9']/value"/></div></td><!--first name -->
    <td valign="top"><div align="left"><xsl:value-of select="property[@prop_id='36']/value"/></div></td><!--last name -->
    <td valign="top"><div align="left"><xsl:value-of select="property[@prop_id='11']/value"/></div></td><!--phone -->
    <td valign="top"><div align="left"><xsl:value-of select="property[@prop_id='33']/value"/></div></td><!--phone -->
    <td valign="top"><div align="left"><xsl:value-of select="property[@prop_id='65']/value"/></div></td><!--phone -->
    <td valign="top"><div align="left"><xsl:value-of select="property[@prop_id='31']/value"/></div></td><!--phone -->
    <td valign="top"><div align="left"><xsl:value-of select="property[@prop_id='34']/value"/></div></td><!--phone -->
	<xsl:if test="$auth_level = 4">

		<td valign="top"><div align="left">
			<xsl:call-template name="print_delete_button" />
			</div>
		</td>
	</xsl:if>
  </tr>

</xsl:template>


<xsl:template name="print_delete_button">
		<form method="get" >
			<xsl:attribute name="action"><xsl:value-of select="$php_self"/></xsl:attribute>
			<input type="hidden" name="target_component[]" value="RecordIniFacade" />
			<input type="hidden" name="target_function[]" value="delete_record" />
			<input type="hidden" name="target_component[]"  >
				<xsl:attribute name="value">
					<xsl:value-of select="$target_component"/>
				</xsl:attribute>
			</input>
			<input type="hidden" name="target_function[]"   >
				<xsl:attribute name="value">
					<xsl:value-of select="$target_function"/>
				</xsl:attribute>
			</input>
			<input type="hidden" name="spi[]"   >
				<xsl:attribute name="value">
					<xsl:value-of select="$spi"/>
				</xsl:attribute>
			</input>
			<input type="hidden" name="spv[]"   >
				<xsl:attribute name="value">
					<xsl:value-of select="$spv"/>
				</xsl:attribute>
			</input>
			<input type="hidden" name="spc[]"   >
				<xsl:attribute name="value">
					<xsl:value-of select="$spc"/>
				</xsl:attribute>
			</input>
			<input type="hidden" name="cspi[]"   >
				<xsl:attribute name="value">
					<xsl:value-of select="$cspi"/>
				</xsl:attribute>
			</input>
			<input type="hidden" name="cspv[]"   >
				<xsl:attribute name="value">
					<xsl:value-of select="$cspv"/>
				</xsl:attribute>
			</input>
			<input type="hidden" name="cspt[]"   >
				<xsl:attribute name="value">
					<xsl:value-of select="$cspt"/>
				</xsl:attribute>
			</input>
			<input type="hidden" name="OF_passthru"   >
				<xsl:attribute name="value">
					<xsl:value-of select="'show_admin_personrecs'"/>
				</xsl:attribute>
			</input>
			
			<input type="hidden" name="eid"  >
			<xsl:attribute name="value">
				<xsl:value-of select="@eid" />
			</xsl:attribute>
			</input>
			<input type="submit" value="delete" onclick="return confirm('Are you sure you want to delete?')"  >
				<xsl:if test="$auth_level &lt; 4">
					<xsl:attribute name="disabled">disabled</xsl:attribute>
				</xsl:if>
			</input>
		
		</form>

</xsl:template>

</xsl:stylesheet>