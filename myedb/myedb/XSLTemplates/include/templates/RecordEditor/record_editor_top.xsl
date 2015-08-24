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
<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>
<xsl:template name="record_editor_top">
		      <div class="bodytext2">

<table width="100%" border="0" cellspacing="0"  cellpadding="0">

		 <tr>
		 <td class="background"><a >
		  	<xsl:attribute name="href">index.php?target_component%5B%5D=RecordIniFacade&amp;target_function%5B%5D=get_record_history_page_xml&amp;eid=<xsl:value-of select="$eid"/>&amp;type_id=<xsl:value-of select="$type_id"/>&amp;OF_passthru=show_record_history</xsl:attribute>Product history</a> 
		</td>
		<td>
			<a>
				<xsl:attribute name="href">index.php?target_component%5B%5D=RecordIniFacade&amp;target_function%5B%5D=donothing&amp;order_hist_eid=<xsl:value-of select="$eid"/>&amp;OF_passthru=show_order_history</xsl:attribute>
				Order History
			</a>
		</td>
		<td class="background">
		Product link: <input type="text" style="width:300px"  >
						<xsl:attribute name="value">http://<xsl:value-of select="$httphost" />index.php?pl=<xsl:value-of select="$eid"/></xsl:attribute>
					</input>

		</td>
		<td>
			<table>
				<!--<xsl:apply-templates select="myedbroot/record/property[@prop_id=53]" mode="notablecells"/>Account Manager-->
								<xsl:for-each select="myedbroot/record/property[@prop_id=53]">
											<xsl:call-template name="lookup_table_select" >
												<xsl:with-param name="lookup_table_path" select="/myedbroot/lookup_table_acctmgrs/acctmgr/@acctmgr_id" />
												<xsl:with-param name="lookup_table_id_attribute" select="@acctmgr_id" />
											</xsl:call-template>
								</xsl:for-each>
			</table>
		</td>
		 </tr>
		 </table>
		 
		 </div>


</xsl:template>
</xsl:stylesheet>