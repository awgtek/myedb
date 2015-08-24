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
<xsl:template name="status_set">

				 <xsl:for-each select="key('prop_list_by_name','Status')">
						<xsl:sort select="@ron" order="ascending" data-type="number"/> 
						<xsl:variable name="statuspropval" select="value" />
						<tr>
							<td>
								Status:
							</td>
							<td >
								<select >
									<xsl:attribute name="name"><xsl:value-of select="@ffi" /></xsl:attribute>
									<xsl:attribute name="id"><xsl:value-of select="@ffi" /></xsl:attribute>
									<OPTION value="" selected="true">Select one</OPTION>
								<xsl:for-each select="/myedbroot/lookup_table_statuses/status" >
									<option >
										<xsl:attribute name="value">
										<xsl:value-of select="@status_id"/>
										</xsl:attribute>
										<xsl:if test="@status_id = $statuspropval"> 
										<xsl:attribute name="SELECTED">true</xsl:attribute>
										</xsl:if>
										<xsl:value-of select="." />
									</option>
								</xsl:for-each>
								</select>
							</td>
						</tr>
						<tr>
							<td  colspan="2" >
								<xsl:if test="@epi &gt; 0">
									<input type="checkbox" name="props_to_delete[]" >
										<xsl:attribute name="value">pid<xsl:value-of select="@prop_id"/>rid<xsl:value-of select="@ron" />
										</xsl:attribute>
									</input> Delete? 
								</xsl:if>
							</td>
						</tr>
				 </xsl:for-each>


</xsl:template>
</xsl:stylesheet>