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


Note: Please add featured items through the Manage Products page.
<!--<iframe width="600" height="700" src="http://172.16.2.74/index.php?target_component[]=RecordIniFacade&amp;target_function[]=initialize&amp;eid=4&amp;type_id=1&amp;OF_passthru=edit_trade_of_the_day_properties" ></iframe>-->
<xsl:for-each select="/myedbroot/entity_grouping/entity_grouping_record/entity_grouping_field[@field_name='eg_type' and .=3]/../entity_grouping_field[@field_name='eid']">
<br /><br />	<a >
		<xsl:attribute name="class">thickbox</xsl:attribute>
		<xsl:attribute name="href">index.php?target_component%5B%5D=RecordIniFacade&amp;target_function%5B%5D=initialize&amp;eid=<xsl:value-of select="." />&amp;OF_passthru=edit_trade_of_the_day_properties&amp;keepThis=true&amp;TB_iframe=true&amp;height=500&amp;width=600
		</xsl:attribute>Edit Trade of the Day (id: <xsl:value-of select="." />) properties
	</a>
</xsl:for-each>
<!--
<a href="index.php?target_component%5B%5D=RecordIniFacade&amp;target_function%5B%5D=initialize&amp;eid=4&amp;type_id=1&amp;OF_passthru=edit_trade_of_the_day_properties&amp;keepThis=true&amp;TB_iframe=true&amp;height=500&amp;width=600" class="thickbox" title="">Update ThickBox content</a>-->

<br /><br />	<a >
		<xsl:attribute name="class">thickbox</xsl:attribute>
		<xsl:attribute name="href">index.php?target_component%5B%5D=RecordIniFacade&amp;target_function%5B%5D=initialize&amp;eid=283&amp;OF_passthru=edit_site_message&amp;keepThis=true&amp;TB_iframe=true&amp;height=500&amp;width=600
		</xsl:attribute>Edit site message
	</a>

<br /><br />	<a >
		<xsl:attribute name="class">thickbox</xsl:attribute>
		<xsl:attribute name="href">index.php?target_component%5B%5D=RecordIniFacade&amp;target_function%5B%5D=initialize&amp;eid=10&amp;OF_passthru=edit_travel_policy_message&amp;keepThis=true&amp;TB_iframe=true&amp;height=500&amp;width=600
		</xsl:attribute>Edit Travel Policy message
	</a>

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
						 <xsl:apply-templates select="property[@prop_id=63]"/><!--Limit Per Order-->
					<xsl:apply-templates select="property[@prop_id=64]" mode="in_textarea"/><!--Keywords-->
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
	 <br />
<a >
		<xsl:attribute name="href">index.php?target_component%5B%5D=RecordIniFacade&amp;target_function%5B%5D=initialize&amp;eid=12&amp;type_id=15&amp;OF_passthru=edit_site_email_entities&amp;form_title=Edit%20User%20Registration%20Email%20to%20Approver</xsl:attribute>Edit User Registration Email to Approver
	</a><br />
<a >
		<xsl:attribute name="href">index.php?target_component%5B%5D=RecordIniFacade&amp;target_function%5B%5D=initialize&amp;eid=13&amp;type_id=15&amp;OF_passthru=edit_site_email_entities&amp;form_title=Edit%20User%20Registration%20Approval%20Email%20to%20User</xsl:attribute>Edit User Registration Approval Email to User
	</a><br />
<a >
		<xsl:attribute name="href">index.php?target_component%5B%5D=ClientServerDataOps&amp;target_function%5B%5D=initialize_lookup_table&amp;table_name=city&amp;OF_passthru=lookuptable_editor</xsl:attribute>Edit Cities
	</a><br />
<a >
		<xsl:attribute name="href">index.php?target_component%5B%5D=ClientServerDataOps&amp;target_function%5B%5D=initialize_lookup_table&amp;table_name=state&amp;OF_passthru=lookuptable_editor</xsl:attribute>Edit States
	</a><br />
<a >
		<xsl:attribute name="href">index.php?target_component%5B%5D=ClientServerDataOps&amp;target_function%5B%5D=initialize_lookup_table&amp;table_name=zip&amp;OF_passthru=lookuptable_editor</xsl:attribute>Edit Zip Codes
	</a>

</xsl:template>


</xsl:stylesheet>