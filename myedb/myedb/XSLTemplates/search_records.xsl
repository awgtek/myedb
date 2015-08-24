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

<xsl:template match="record" mode="product_type">

  <tr>
    <xsl:attribute name="class">
      <xsl:choose>
        <xsl:when test="position()mod 2">odd</xsl:when>
        <xsl:otherwise>even</xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>

    <td>
		<a >
		<xsl:attribute name="href">
			?target_component[]=RecordIniFacade&amp;target_function[]=initialize&amp;eid=<xsl:value-of select="@eid" />&amp;type_id=<xsl:value-of select="@type_id" />&amp;OF_passthru=<xsl:choose>
				<xsl:when test="@type_id = 4">show_travel_item</xsl:when>
				<xsl:otherwise>show_purchasable_product</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		
	<xsl:value-of select="property[@prop_name='Product Name']/value"/>
		</a>
	
	</td>
    <td><xsl:value-of select="property[@prop_name='Description']/value"/></td>
    <td width="150px">
			<xsl:apply-templates select="property[@prop_id=12][1]/validator/select/option" mode="print_option_value"/> <xsl:text> </xsl:text>
			<xsl:apply-templates select="property[@prop_id=13][1]/validator/select/option" mode="print_option_value"/>
	</td>
    <td>
		<xsl:if test="property[@prop_id=27]/value != ''">
		<a>		<xsl:attribute name="href">
			?target_component[]=RecordIniFacade&amp;target_function[]=initialize&amp;eid=<xsl:value-of select="@eid" />&amp;type_id=<xsl:value-of select="@type_id" />&amp;OF_passthru=<xsl:choose>
				<xsl:when test="@type_id = 4">show_travel_item</xsl:when>
				<xsl:otherwise>show_purchasable_product</xsl:otherwise>
			</xsl:choose></xsl:attribute>
 <img >
				<xsl:attribute name="src"><xsl:value-of select='$app_root_client' />/client_uploaded_images/<xsl:value-of select="property[@prop_id=27]/value"/>
				</xsl:attribute>
			</img>
		</a>
		</xsl:if>
	</td>
  </tr>

</xsl:template>

<xsl:template match="record" mode="travel_type">

  <tr>
    <xsl:attribute name="class">
      <xsl:choose>
        <xsl:when test="position()mod 2">odd</xsl:when>
        <xsl:otherwise>even</xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>

    <td>
		<a >
		<xsl:attribute name="href">
			?target_component[]=RecordIniFacade&amp;target_function[]=initialize&amp;eid=<xsl:value-of select="@eid" />&amp;type_id=<xsl:value-of select="@type_id" />&amp;OF_passthru=show_travel_item</xsl:attribute>
		
	<xsl:value-of select="property[@prop_id=32]/value"/>
		</a>
	
	</td>
    <td><xsl:apply-templates select="property[@prop_id=12][1]/validator/select/option" mode="print_option_value"/></td>
    <td><xsl:apply-templates select="property[@prop_id=13][1]/validator/select/option" mode="print_option_value"/></td>
  </tr>

</xsl:template>


</xsl:stylesheet>