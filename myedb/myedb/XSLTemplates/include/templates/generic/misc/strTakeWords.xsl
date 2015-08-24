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
    <xsl:template name="strTakeWords"> 
      <xsl:param name="pN" select="10"/> 
      <xsl:param name="pText"/> 
      <xsl:param name="pWords"/> 
      <xsl:param name="pResult"/> 
 
      <xsl:choose> 
          <xsl:when test="not($pN > 0)"> 
            <xsl:value-of select="$pResult"/> 
          </xsl:when> 
          <xsl:otherwise> 
            <xsl:variable name="vWord" select="$pWords[1]"/> 
            <xsl:variable name="vprecDelims" select= 
               "substring-before($pText,$pWords[1])"/> 
 
            <xsl:variable name="vnewText" select= 
                "concat($vprecDelims, $vWord)"/> 
 
              <xsl:call-template name="strTakeWords"> 
                <xsl:with-param name="pN" select="$pN -1"/> 
                <xsl:with-param name="pText" select= 
                      "substring-after($pText, $vnewText)"/> 
                <xsl:with-param name="pWords" select= 
                     "$pWords[position() > 1]"/> 
                <xsl:with-param name="pResult" select= 
                 "concat($pResult, $vnewText)"/> 
              </xsl:call-template> 
          </xsl:otherwise> 
      </xsl:choose> 
    </xsl:template> 


</xsl:stylesheet>