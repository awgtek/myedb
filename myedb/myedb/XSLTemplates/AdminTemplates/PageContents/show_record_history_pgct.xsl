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
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:pl="urn:myedb:propertylist">
<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>
<xsl:template name="pagecontent">
		      <div class="bodytext2">

			<table border="1">
				<tr>
					<td>Date Created:</td><td><xsl:value-of select="/myedbroot/RecordHistory/date_created/text()" /> </td>
					<td>User Created:</td><td><xsl:value-of select="/myedbroot/RecordHistory/user_added/text()" /> </td>
				</tr>
				<tr>
					<td>Date Last Modified:</td><td><xsl:value-of select="/myedbroot/RecordHistory/date_last_modified/text()" /> </td>
					<td>User Last Modified:</td><td><xsl:value-of select="/myedbroot/RecordHistory/user_last_modified/text()" /> </td>
				</tr>
			</table>
			
			<table border="1" cellspacing="0">
				<tr><th>Field</th><th>Action</th><th>Date</th><th>User</th><th>Last Value</th></tr>
				<xsl:for-each select="/myedbroot/RecordHistory/prop_changes/records/record">
					<xsl:sort select="property[@prop_id='43']/value" order="descending"/>

					<tr>
						<td>
							<xsl:variable name="cur_prop_id" select="property[@prop_name='prop_id']/value" />
							<xsl:value-of select="/myedbroot/*/pl:property[@property_id=$cur_prop_id]/text()" />
						</td>
						<td><xsl:value-of select="property[@prop_id='42']/value" /></td>
						<td><xsl:value-of select="property[@prop_id='43']/value" /></td>
						<td><xsl:value-of select="property[@prop_id='41']/value" />
								(id: <xsl:value-of select="property[@prop_id='7']/value" />)</td>
						<td><xsl:value-of select="property[@prop_id='37' or @prop_id='44' or @prop_id='45'
						 or @prop_id='46' or @prop_id='47' or @prop_id='48' or @prop_id='49' ]/value" /></td>
					</tr>
					
				</xsl:for-each>
			
			</table>
			</div>
</xsl:template>
</xsl:stylesheet>