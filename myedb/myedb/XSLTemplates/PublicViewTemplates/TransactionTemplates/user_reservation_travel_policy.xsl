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
<xsl:include href="../../include/head_includes.xsl"/>
<xsl:include href="../../include/templates/TravelItemDisplay/record_brief.xsl"/>
<xsl:include href="../PageContents/user_reservation_travel_policy_pgct.xsl" />
<xsl:include href="../pageframe.xsl" />

<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>
 <xsl:key name="record" match="property[@prop_group_id='1']" use="@ron" />

<xsl:template match="/">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<link href="/stylesheets/main_style.css" rel="stylesheet" type="text/css" />
		<xsl:call-template name="head_include_tags" />
<title>User Reservation</title>
</head>

<body onload="reset_agree_on_browser_back();">
		<xsl:call-template name="pageframe">
		</xsl:call-template>

</body>

</html>

</xsl:template>

 <xsl:template match="record">

 	<tr>
		<td>
			<table >
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
				 <xsl:apply-templates select="property[@prop_id=32]" mode="print_text_with_field_name"/>
				 <xsl:apply-templates select="property[@prop_id=18]" mode="print_text_with_field_name"/>
				<tr>
					<td>									
						<xsl:for-each select="key('record',0)">
							 <xsl:choose>
								 <xsl:when test="@prop_name = 'City' or @prop_name = 'State' or @prop_name = 'Zip'" >
									<xsl:if test="@prop_name = 'City'">
										<br />
									</xsl:if>
									<xsl:call-template name="print_city_state_zip" />
								 </xsl:when>
								 <xsl:otherwise>
									<xsl:if test="value != ''" >
										<br />
									</xsl:if>
									<xsl:apply-templates select="." mode="print_field_text"/>
								 </xsl:otherwise>
							 </xsl:choose>
						</xsl:for-each>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</xsl:template>
</xsl:stylesheet>