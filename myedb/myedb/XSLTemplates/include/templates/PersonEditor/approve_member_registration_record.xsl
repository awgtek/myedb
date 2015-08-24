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
				 <xsl:apply-templates select="property[@prop_id='7']"  mode="print_text_with_field_name2" >
				 			<xsl:with-param name="field_title" select="'User ID (Email Address)'" />
				 			<xsl:with-param name="label_class" select="'none'" />
				 			<xsl:with-param name="value_class" select="'product-tan product-description'" />
				</xsl:apply-templates>
				 <xsl:if  test="$eid = 0">
				 </xsl:if>
				<xsl:apply-templates select="property[@prop_name='First Name']"   mode="print_text_with_field_name2">
				 			<xsl:with-param name="field_title" select="'First Name'" />
				 			<xsl:with-param name="label_class" select="'none'" />
				 			<xsl:with-param name="value_class" select="'product-tan product-description'" />
				</xsl:apply-templates>
				<xsl:apply-templates select="property[@prop_id=36]" mode="print_text_with_field_name2"><!-- Last Name -->
				 			<xsl:with-param name="field_title" select="'Last Name'" />
				 			<xsl:with-param name="label_class" select="'none'" />
				 			<xsl:with-param name="value_class" select="'product-tan product-description'" />
				</xsl:apply-templates>
				  <!--<xsl:apply-templates select="property[@prop_id=33]"/>Account No.-->
			<!--	<xsl:apply-templates select="property[@prop_id=55]">Email Address
				 			<xsl:with-param name="field_title" select="'* Email Address'" />
				</xsl:apply-templates>-->
				<xsl:apply-templates select="property[@prop_id=55]" mode="hidden_input_field"><!--email address-->
				</xsl:apply-templates>
				<xsl:apply-templates select="property[@prop_id=11]"  mode="print_text_with_field_name2">
				 			<xsl:with-param name="field_title" select="'Phone Number'" />
				 			<xsl:with-param name="label_class" select="'none'" />
				 			<xsl:with-param name="value_class" select="'product-tan product-description'" />
				</xsl:apply-templates>
				<xsl:apply-templates select="property[@prop_id=33]"  mode="print_text_with_field_name2">
				 			<xsl:with-param name="field_title" select="'Account Number'" />
				 			<xsl:with-param name="label_class" select="'none'" />
				 			<xsl:with-param name="value_class" select="'product-tan product-description'" />
				</xsl:apply-templates>
				<xsl:apply-templates select="property[@prop_id=65]"  mode="print_text_with_field_name2">
				 			<xsl:with-param name="field_title" select="'Business Name'" />
				 			<xsl:with-param name="label_class" select="'none'" />
				 			<xsl:with-param name="value_class" select="'product-tan product-description'" />
				</xsl:apply-templates>
 				<xsl:apply-templates select="property[@prop_id=25]" mode="hidden_input_field_with_passed_value"><!--@prop_name='User Authorization Level'-->
				 			<xsl:with-param name="passed_value" select="-1" />
				</xsl:apply-templates>
 				<xsl:apply-templates select="property[@prop_id=31]" mode="hidden_input_field_with_passed_value"><!--Active-->
					<xsl:with-param name="passed_value" select="1" />
				</xsl:apply-templates>
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