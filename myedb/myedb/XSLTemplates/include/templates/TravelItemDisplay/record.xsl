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
<xsl:include href="../generic/misc/print_city_state_zip.xsl"/>
<xsl:include href="../generic/property.xsl"/>
<xsl:include href="../../output_templates.xsl" />

<xsl:include href="../RecordTemplates/record_images_display.xsl" />

<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>
 <!--<xsl:param name="group-size" select="2" /> -->
			<xsl:variable name="n-rows" select="3"/>
 <xsl:template match="/myedbroot/record" mode="travel_item_display">
 	<tr>
		<td width="50%">
			<table width="100%" border="0" cellspacing="0" cellpadding="0"  >
				 <input type="hidden" name="rec_eid">
					<xsl:attribute name="value">
						<xsl:value-of select="@eid"/>
					</xsl:attribute>
				 </input>
				 <input type="hidden" name="rec_type_id">
					<xsl:attribute name="value">
						<xsl:value-of select="@type_id"/>
					</xsl:attribute>
				 </input>
				 <xsl:apply-templates select="property[@prop_id=1]" mode="print_text_with_field_name1"/>
				 <xsl:apply-templates select="property[@prop_id=2]" mode="print_text_with_field_name2"/>
				 <tr>
					<td width="150px" valign="top" class="product-green">Locations:</td>
					<td valign="top" class="product-green product-description"  style="padding-bottom:0;" >
					<table border="0"  cellpadding="0" cellspacing="0"  >
					  <xsl:for-each select="property[generate-id(.)=generate-id(key('record',@ron)) ]">
						<!--  Sort Primary key by name in ascending order 
						  --> 
							<xsl:sort select="@ron" order="ascending" data-type="number"/> 
							<xsl:variable name="addressnum" select="@ron" />
							<xsl:if test="@epi &gt; 0">
								<tr  class="sechead"><td style=" padding-top:0;  padding-bottom:12px; "  colspan="2" valign="top" class="product-green product-description"  > <!--Address <xsl:value-of select="$addressnum + 1"/>:-->
									<!-- skip line on second address on 
									<xsl:if test="$addressnum &gt; 0">
										<br />
									</xsl:if>-->
								
								<!--<xsl:for-each select="key('record',@ron)">
									<xsl:call-template name="formatted_location"  />
								</xsl:for-each>-->
									<xsl:apply-templates select="key('record',@ron)" mode="formatted_location_mode" />
								</td></tr>
							</xsl:if>
					  </xsl:for-each>
					</table>
				</td>
				</tr>
				 <xsl:apply-templates select="property[@prop_name='Notes / Restrictions']" mode="print_text_with_field_name2"/>
				 <xsl:apply-templates select="property[@prop_name='Phone']" mode="print_text_with_field_name1"/>
				 <xsl:apply-templates select="property[@prop_name='Website']" mode="print_text_with_field_name_hyperlink"/>
				 <xsl:apply-templates select="property[@prop_id=55]" mode="print_text_with_field_name2"/><!-- email-->
				 <xsl:apply-templates select="property[@prop_id=52]" mode="print_text_with_field_name1"/><!-- main contact-->
			</table>
		</td>
		<td valign="top" align="left">
			
			<table border="0" width="100%" style="margin-left:10px; font-size:12px">
				<xsl:call-template name="td-recursive-image-rows" /><!--images-->
			<!--	<xsl:apply-templates select="property[@prop_id=27][(position() mod $group-size) = 1]" > images
				</xsl:apply-templates>-->
			</table> 
		</td>
	</tr>
	
 </xsl:template>
 


</xsl:stylesheet>