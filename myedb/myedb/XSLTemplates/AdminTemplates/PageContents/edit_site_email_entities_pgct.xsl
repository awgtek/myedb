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
<xsl:include href="../../include/templates/generic/property.xsl" />
<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>

<xsl:param name="btn_sub" />


<xsl:template name="pagecontent">

<!--put page content here-->

<xsl:value-of select="$form_title" />
<br /><br />
	 <form method="post" action="index.php" enctype="multipart/form-data">
		<input type="hidden" name="target_component[]" value="RecordIniFacade" />
		<input type="hidden" name="target_function[]" value="update_record" />
		<input type="hidden" name="target_component[]" value="RecordIniFacade" />
		<input type="hidden" name="target_function[]" value="initialize" />
		<input type="hidden" name="eid">
			<xsl:attribute name="value">
				<xsl:value-of select="$eid"/>
			</xsl:attribute>
		</input>
		<input type="hidden" name="type_id" >
			<xsl:attribute name="value">
				<xsl:value-of select="$type_id"/>
			</xsl:attribute>
		</input>
		<input type="hidden" name="OF_passthru" value="edit_site_variables" />
		<label style="font-size:14px; background-color:#FF9999">
			<xsl:if test="$btn_sub = 'Update Record'">Record Updated!</xsl:if>
		</label>
		<xsl:for-each select="/myedbroot/record[1]">
		<table>
						 <xsl:apply-templates select="property[@prop_id=66]"/><!--Email subject-->
					<xsl:apply-templates select="property[@prop_id=67]" mode="in_textarea"/><!--Email message-->
		</table>
		</xsl:for-each>
		<input class="formbuttons" type="submit" id="btn_sub" name="btn_sub" >
			<xsl:choose>
				<xsl:when test="$auth_level = 1">
					 <xsl:attribute name="disabled">
					 </xsl:attribute>
				</xsl:when>
				<xsl:otherwise>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:attribute name="value">Update Record
			</xsl:attribute>
		</input>
	 </form>



</xsl:template>


</xsl:stylesheet>