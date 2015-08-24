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
<xsl:include href="../RecordEditor/location_group.xsl"/>

<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>
 <xsl:template match="record">
 	<tr>
		<td valign="top" width="34%" style="background-image:url(/images/green.jpg);">
			<table border="0" cellpadding="1" cellspacing="1" >
			<tr><td>Fields required *</td>
			</tr>
				 <input type="hidden" name="rec_eid">
					<xsl:attribute name="value">
						<xsl:value-of select="@eid"/>
					</xsl:attribute>
				 </input>
				 <input type="hidden" name="rec_type_id">
					<xsl:attribute name="value">
						<xsl:value-of select="@type_id"/>
					</xsl:attribute>
				 </input>
				 <xsl:apply-templates select="property[@prop_id='7']" >
				 			<xsl:with-param name="field_title" select="'* User ID (Email Address)'" />
				</xsl:apply-templates>
				 <xsl:if  test="$eid = 0">
				 </xsl:if>
					 <!--<xsl:apply-templates select="property[@prop_name='Password']"/>-->
				 <xsl:apply-templates select="property[@prop_id=8]" mode="hidden_input_field" /><!--password-->
				<xsl:apply-templates select="property[@prop_id=8]" mode="password_check_and_append" /><!--password -->
				<xsl:apply-templates select="property[@prop_name='First Name']">
				 			<xsl:with-param name="field_title" select="'* First Name'" />
				</xsl:apply-templates>
				<xsl:apply-templates select="property[@prop_id=36]"><!-- Last Name -->
				 			<xsl:with-param name="field_title" select="'* Last Name'" />
				</xsl:apply-templates>
				  <!--<xsl:apply-templates select="property[@prop_id=33]"/>Account No.-->
			<!--	<xsl:apply-templates select="property[@prop_id=55]">Email Address
				 			<xsl:with-param name="field_title" select="'* Email Address'" />
				</xsl:apply-templates>-->
				<xsl:apply-templates select="property[@prop_id=55]" mode="hidden_input_field">
				</xsl:apply-templates>
				<xsl:apply-templates select="property[@prop_id=11]">
				 			<xsl:with-param name="field_title" select="'Phone Number'" />
				</xsl:apply-templates>
				<xsl:apply-templates select="property[@prop_id=33]"><!--Email Address-->
				 			<xsl:with-param name="field_title" select="'Account Number'" />
				</xsl:apply-templates>
				<xsl:apply-templates select="property[@prop_id=65]"><!--Email Address-->
				 			<xsl:with-param name="field_title" select="'Business Name'" />
				</xsl:apply-templates>
 				<xsl:apply-templates select="property[@prop_id=25]" mode="hidden_input_field_with_passed_value"><!--@prop_name='User Authorization Level'-->
				 			<xsl:with-param name="passed_value" select="-1" />
				</xsl:apply-templates>
 				<xsl:apply-templates select="property[@prop_id=31]" mode="checkbox"/><!--Active-->
 				<xsl:apply-templates select="property[@prop_id=34]" mode="checkbox"/><!--Registered-->
 			</table>
		</td>
<!--		<td valign="top" width="33%">
			<xsl:call-template name="location_group" />
		</td>
		<td valign="top" style="background-image:url(/images/green.jpg);" width="33%">
			<table>

				<xsl:call-template name="multi_phone" />
				
	</table></td>
	-->
	</tr>
	
 </xsl:template>

</xsl:stylesheet>