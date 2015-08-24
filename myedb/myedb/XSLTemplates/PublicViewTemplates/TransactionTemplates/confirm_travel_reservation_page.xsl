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
<xsl:include href="../../include/templates/TravelItemDisplay/record.xsl"/>
<xsl:include href="../PageContents/confirm_travel_reservation_page_pgct.xsl" />
<xsl:include href="../pageframe.xsl" />

<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>
<xsl:template match="/">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link href="/stylesheets/main_style.css" rel="stylesheet" type="text/css" />
<xsl:call-template name="horiz-menu-header-code"/>
		<xsl:call-template name="head_include_tags" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>Confirm Travel Reservation</title>
</head>

<body>
		<xsl:call-template name="pageframe">
		</xsl:call-template>
</body>
</html>

</xsl:template>

<xsl:template match="travel_res_submit_field">
	<tr>
		<td>
			<xsl:value-of select="res_field_label"/>
		</td>
		<td>
			<xsl:value-of select="res_field_value" />
		</td>
	</tr>

</xsl:template>
</xsl:stylesheet>