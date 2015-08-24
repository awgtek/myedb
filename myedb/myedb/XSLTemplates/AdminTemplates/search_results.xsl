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
<xsl:include href="search_records.xsl" />
<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>

<xsl:template name="show_search_results">
      <div class="center">
        <div id="target">No Search Results</div>
        <table border="0" width="100%">
          <caption>
            <xsl:value-of select="$title"/>
            </caption>
          <thead>
            <tr>
			<!--	<xsl:choose>
					<xsl:when test="$type_id = 4">
						<th>Property</th>
						<th>City</th>
						<th>State</th>
					</xsl:when>
					<xsl:otherwise>-->
					  <th>Product</th>
					  <th>Description</th>
					  <th>City</th>
					  <th>State</th>
			<!--		</xsl:otherwise>
				</xsl:choose>-->
            </tr>
          </thead>
		  <xsl:variable name="pagecnt" select="4" />
          <xsl:for-each select="(//record)[position() mod $pagecnt = 1]">
            <xsl:variable name="node-position" select="position() * $pagecnt"/>
            <xsl:element name="tbody">
              <xsl:attribute name="id">page<xsl:value-of select="position()"/></xsl:attribute>
              <xsl:attribute name="class">page</xsl:attribute>
				<!--<xsl:choose>
					<xsl:when test="$type_id = 4">
		              <xsl:apply-templates select="(//record)[position() &lt;= $node-position and position() &gt; $node-position - $pagecnt]" mode="travel_type" />
					</xsl:when>
					<xsl:otherwise>-->
		              <xsl:apply-templates select="(//record)[position() &lt;= $node-position and position() &gt; $node-position - $pagecnt]" mode="product_type" />
			<!--		</xsl:otherwise>
				</xsl:choose>-->
            </xsl:element>
          </xsl:for-each>
        </table>
			<div id="hidethisdiv" > replacce
			</div>
        <!-- insert the page navigation links 
  <xsl:call-template name="pagination" />-->
        <!-- create standard action buttons 
  <xsl:call-template name="actbar"/>-->
      </div>



</xsl:template>
</xsl:stylesheet>