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


  <xsl:template match="property[@prop_name='Description' or @prop_name='Notes / Restrictions']">
 		 <tr>
		 <td>
		 <xsl:value-of select="@prop_name"/>
		 </td>
		 <td><textarea rows="6">
		 <xsl:attribute name="id" >
			<xsl:value-of select="@ffi"/>
		 </xsl:attribute>
		 <xsl:attribute name="name" >
			<xsl:value-of select="@ffi"/>
		 </xsl:attribute>
			<xsl:value-of select="value"/>
		 </textarea>
		 </td>
		 </tr>

 </xsl:template>
 
</xsl:stylesheet>