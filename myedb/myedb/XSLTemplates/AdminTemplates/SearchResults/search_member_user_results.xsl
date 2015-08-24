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
<xsl:include href="search_member_user_records.xsl" />
<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>
<xsl:param name="title">List Products</xsl:param>

<xsl:template match="/">
<xsl:if test="count(/myedbroot/records/record) = 0">
	No Search Results
</xsl:if>
<xsl:if test="count(/myedbroot/records/record) &gt; 0">
	<table cellpadding="0" cellspacing="0" bgcolor="">
	  <tr>
		<td valign="top" >
		  <div class="bodytext" style="display:inline">
		 <table width="100%" border="0" cellspacing="4" cellpadding="1" bgcolor="">
		  <tr>
			<th width="25%" height="29" valign="top"><strong>User ID</strong></th>
		 <!--   <th width="45%" valign="top"><strong>Description</strong></th>-->
			<th width="10%" valign="top"><strong>First Name</strong></th>
			<th width="10%" valign="top"><strong>Last Name</strong></th>
			<th width="10%" valign="top"><strong>Phone Number</strong></th>
			<th width="10%" valign="top"><strong>Account Number</strong></th>
			<th width="10%" valign="top"><strong>Business Name</strong></th>
			<th width="10%" valign="top"><strong>Active</strong></th>
			<th width="10%" valign="top"><strong>Registered</strong></th>
		  <!--  <th width="10%" valign="top"><strong>Category 2</strong></th>
			<th width="10%" valign="top"><strong>Subcategory 2</strong></th>-->
	<xsl:if test="$auth_level = 4">
			<th width="8" valign="top"><strong>Delete</strong></th>
	</xsl:if>
		  </tr>
			  <!--  <table border="1" width="100%">
				  <caption>
					<xsl:value-of select="$title"/>
					</caption>-->
			   <!--   <thead>
					<tr>
						<xsl:choose>
							<xsl:when test="$type_id = 4">
								<th>Property</th>
								<th>City</th>
								<th>State</th>
							</xsl:when>
							<xsl:otherwise>-->
					<!--		  <th>Product</th>
							  <th>Description</th>
							  <th>City</th>
							  <th>State</th>
							</xsl:otherwise>
						</xsl:choose>
					</tr>
				  </thead>-->
				  <xsl:variable name="pagecnt" select="4" />
				<!--   <xsl:for-each select="(/myedbroot/records/record)[position() mod $pagecnt = 1]">-->
				<!--    <xsl:for-each select="(/myedbroot/records/record)">
				 <xsl:variable name="node-position" select="position() * $pagecnt"/>
					<xsl:element name="tbody">
					  <xsl:attribute name="id">page<xsl:value-of select="position()"/></xsl:attribute>
					  <xsl:attribute name="class">page</xsl:attribute>-->
						<!--<xsl:choose>
							<xsl:when test="$type_id = 4">
							  <xsl:apply-templates select="(//record)[position() &lt;= $node-position and position() &gt; $node-position - $pagecnt]" mode="travel_type" />
							</xsl:when>
							<xsl:otherwise>-->
						   <!--   <xsl:apply-templates select="(/myedbroot/records/record)[position() &lt;= $node-position and position() &gt; $node-position - $pagecnt]" mode="product_type" />-->
							  <xsl:apply-templates select="(/myedbroot/records/record)" mode="product_type" />
					<!--		</xsl:otherwise>
						</xsl:choose>-->
				<!--    </xsl:element>
				  </xsl:for-each>-->
			</table>
			<!-- insert the page navigation links 
	  <xsl:call-template name="pagination" />-->
			<!-- create standard action buttons 
	  <xsl:call-template name="actbar"/>-->
		  </div>
	
		</td>
		  </tr>
		  <tr>
			<td valign="top"><div><!--<img src="/images/bottom.gif" width="800" height="21" />--></div></td>
		  </tr>
	</table>
</xsl:if>

</xsl:template>
</xsl:stylesheet>