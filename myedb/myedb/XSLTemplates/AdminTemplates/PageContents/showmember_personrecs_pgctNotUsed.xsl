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
<xsl:template name="pagecontent">
		      <div class="bodytext2">


  <script type="text/javascript" src="/server.php?client=all"></script>
<table width="100%" border="0">
<!--  <tr>
    <td width="21%"></td>
    <td width="79%"></td>
  </tr>-->
  <tr>
    <td><form method="post" action="{$script}"></form>
      <div class="center">
        <div id="target"></div>
        <table border="0" width="100%">
          <!--<thead>-->
            <tr>
              <th valign="top"><div align="center"><strong>User ID</strong></div></th>
              <th valign="top"><div align="center"><strong>First Name</strong></div></th>
              <th valign="top"><div align="center"><strong>Last Name</strong></div></th>
            <!--<th valign="top"><div align="center"><strong>Auth Level</strong></div></th>-->
              <th valign="top"><div align="center"><strong>Delete</strong></div></th>
            </tr>
        <!--  </thead>-->
       <!--   <xsl:for-each select="(/myedbroot/records/record)[position() mod 2 = 1]">
          <xsl:for-each select="(/myedbroot/records/record)">-->
           <!-- <xsl:variable name="node-position" select="position() * 2"/>    
            <xsl:element name="tbody">
              <xsl:attribute name="id">page<xsl:value-of select="position()"/></xsl:attribute>
              <xsl:attribute name="class">page</xsl:attribute>
              <xsl:apply-templates select="(/myedbroot/records/record)[position() &lt;= $node-position and position() &gt; $node-position - 2]" />-->
              <xsl:apply-templates select="(/myedbroot/records/record)" />
		<!--            </xsl:element>
          </xsl:for-each>-->
        </table>
        <!-- insert the page navigation links 
  <xsl:call-template name="pagination" />-->
        <!-- create standard action buttons 
  <xsl:call-template name="actbar"/>-->
      </div>
    </td>
  </tr>
 <!-- <tr>
    <td></td>
    <td></td>
  </tr>-->
</table>
</div>
</xsl:template>
</xsl:stylesheet>