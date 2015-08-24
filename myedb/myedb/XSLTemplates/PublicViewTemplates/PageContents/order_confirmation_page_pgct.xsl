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
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exslt="http://exslt.org/common">

<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>

<xsl:param name="btn_sub" />

<xsl:template name="pagecontent">
		      <div id="public_center_content" >
<div class="bodytext2">
<blockquote>
<br /><br />
<p align="center"><strong>Thank You for your   order</strong></p>
<p align="center"><strong>Your order number   is: <xsl:value-of select="/myedbroot/final_order_id" /></strong></p>
<p align="center"><strong><a href="index.php">Click here to return to our home page</a></strong></p>
</blockquote>
		</div>
</div>
		<xsl:call-template name="pub_search_res_div" />
</xsl:template>
</xsl:stylesheet>