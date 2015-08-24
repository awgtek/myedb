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
<xsl:include href="topstrip_admin.xsl" />
<xsl:include href="topstrip_member.xsl" />
<xsl:include href="leftnav_admin.xsl" />
<xsl:include href="leftnav_member.xsl" />

<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>
<xsl:template name="horiz-menu">

<div id="topstripdiv">
	<xsl:if test="$auth_level = 10">
		<xsl:call-template name="topstrip_admin"/>
	</xsl:if>
	<xsl:if test="$auth_level &lt; 10">
		<xsl:call-template name="topstrip_member"/>
	</xsl:if>
</div>
<div id="leftnavdiv">
	<xsl:if test="$auth_level = 10">
		<xsl:call-template name="leftnav_admin" />
	</xsl:if>
	<xsl:if test="$auth_level &lt; 10">
		<xsl:call-template name="leftnav_member"/>
	</xsl:if>
</div>

</xsl:template>
</xsl:stylesheet>