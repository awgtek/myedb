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

 <xsl:template match="property[@prop_id=27]">
	<xsl:variable name="currow" select="position()" />
	<tr>
	<xsl:for-each select=". | ./following-sibling::property[@prop_id=27][position() &lt; $group-size]">
		<xsl:variable name="curid" select="."/>
        <td  hspace="6" vspace="6" border="0" valign="top">
		<xsl:if test="string-length(value) &gt; 0">
			<img  hspace="6" vspace="6" border="0">
				<!--<xsl:attribute name="align">
				<xsl:if test="$currow mod 2 = 1">right</xsl:if>
				<xsl:if test="$currow mod 2 = 0">left</xsl:if>
				</xsl:attribute>-->
						<xsl:attribute name="src">
							<xsl:value-of select='$app_root_client' />/client_uploaded_images/<xsl:value-of select="value" /></xsl:attribute>
			</img>
		</xsl:if>
		</td>
	</xsl:for-each>		
	</tr>
 
 </xsl:template>
 
 <!-- not used see td-recursive-image-rows-->
 <xsl:template match="property[@prop_id=26]" mode="column-oriented">

<xsl:variable name="n-rows" select="ceiling(last() div $cols)"/>
cols:	<xsl:value-of select="$cols" />yooo<br /> rows: <xsl:value-of select="$n-rows" />==
          <xsl:call-template name="td-recursive"/>

 </xsl:template>
 
<xsl:template name="td-recursive-image-rows">
  <xsl:param name="index" select="1"/>
  <xsl:param name="modrow" select="1" />
 <!-- <tr><td>modrow:<xsl:value-of select="$modrow" />
  	,n-rows:<xsl:value-of select="$n-rows" /></td></tr>-->
	<tr>
    <xsl:for-each select="/myedbroot/record/property[@prop_id=26 and string-length(value) &gt; 0][position() mod $n-rows = $modrow]">
      <td  hspace="6" vspace="6" border="0" valign="top"><!-- cols:<xsl:value-of select="$cols"/>, -->
			<img hspace="6" vspace="6" border="0">
				<!--<xsl:attribute name="align">
				<xsl:if test="$currow mod 2 = 1">right</xsl:if>
				<xsl:if test="$currow mod 2 = 0">left</xsl:if>
				</xsl:attribute>-->
						<xsl:attribute name="src">
							<xsl:value-of select='$app_root_client' />/client_uploaded_images/<xsl:value-of select="value" /></xsl:attribute>
			</img>
	  
	  </td>
    </xsl:for-each>
	</tr>
  <xsl:if test="$index &lt; $n-rows">
    <xsl:call-template name="td-recursive-image-rows">
      <xsl:with-param name="index" select="$index + 1"/>
	  <xsl:with-param name="modrow" select="($index + 1) mod $n-rows"/>
    </xsl:call-template>
  </xsl:if>
</xsl:template>


 <xsl:template match="property[@prop_id=26]" mode="row-oriented">
	<xsl:variable name="currow" select="position()" />
	<tr>
	<xsl:for-each select=". | ./following-sibling::property[@prop_id=26][position() &lt; $group-size]">
		<xsl:variable name="curid" select="."/>
        <td  hspace="6" vspace="6" border="0" valign="top">
		<xsl:if test="string-length(value) &gt; 0">currow<xsl:value-of select="$currow" />position:<xsl:value-of select="position()"/>
			<img  hspace="6" vspace="6" border="0">
				<!--<xsl:attribute name="align">
				<xsl:if test="$currow mod 2 = 1">right</xsl:if>
				<xsl:if test="$currow mod 2 = 0">left</xsl:if>
				</xsl:attribute>-->
						<xsl:attribute name="src">
							<xsl:value-of select='$app_root_client' />/client_uploaded_images/<xsl:value-of select="value" /></xsl:attribute>
			</img>
		</xsl:if>
		</td>
	</xsl:for-each>		
	</tr>
 
 </xsl:template>
 
 
</xsl:stylesheet>