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

<!--put page content here-->
<form action="index.php" method="post">
	<input type="hidden" name="target_component[]" value="MetaDataOps" />
	<input type="hidden" name="target_function[]" value="GroupedItems_remove_entity_by_id" />
	<input type="hidden" name="target_component[]" value="MetaDataOps" />
	<input type="hidden" name="target_function[]" value="FI_get_xml_list" />
	<input type="hidden" name="OF_passthru" value="edit_entity_groupings" />

	<xsl:apply-templates select="/myedbroot/entity_grouping/entity_grouping_record/entity_grouping_field[@field_name='eg_type' and not(.=preceding::entity_grouping_field[@field_name='eg_type'])]" />
<!--
	<xsl:for-each select="/myedbroot/entity_grouping/entity_grouping_record/entity_grouping_field[@field_name='eg_type' and .=1]">
		<xsl:variable name="curid" select="../entity_grouping_field[@field_name='eid']"/>
		<xsl:variable name="cur_eg_id" select="../entity_grouping_field[@field_name='eg_id']"/>
		<xsl:variable name="curpos1" select="position()" />
		<xsl:for-each select="/myedbroot/records/record[@eid=$curid]">
			 <tr>
			 <td >
				<xsl:value-of select="$curpos1" />.) <xsl:value-of select="./property/value" />
			 </td>
			 <td>
				<input type="checkbox" name="eg_id" >
					<xsl:attribute name="value" ><xsl:value-of select="$cur_eg_id"/></xsl:attribute>
				</input>
			 </td>
			 </tr>
		</xsl:for-each>
	</xsl:for-each>
-->
	<input type="submit" value="Delete selected"/>
</form>

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



</xsl:template>
<xsl:template match="/myedbroot/entity_grouping/entity_grouping_record/entity_grouping_field[@field_name='eg_type']">
	<xsl:variable name="curtype" select="." />
	<xsl:value-of select="/myedbroot/entity_grouping_types/entity_grouping_types_record/entity_grouping_types_field[@field_name='eg_type_id' and .=$curtype]/../entity_grouping_types_field[@field_name='eg_type_name']" /><br />
	<table  border="0" cellspacing="4"  cellpadding="1">
		<xsl:for-each select="/myedbroot/entity_grouping/entity_grouping_record/entity_grouping_field[@field_name='eg_type' and .=$curtype]">
			<xsl:variable name="curid" select="../entity_grouping_field[@field_name='eid']"/>
			<xsl:variable name="cur_eg_id" select="../entity_grouping_field[@field_name='eg_id']"/>
			<xsl:variable name="curpos" select="position()" />
				 <tr>
				 <td >
					<xsl:value-of select="$curpos" />.) <xsl:value-of select="/myedbroot/records/record[@eid=$curid]/property/value" />
				 </td>
				 <td>
					<input type="checkbox" name="eg_id[]" >
						<xsl:attribute name="value" ><xsl:value-of select="$cur_eg_id"/></xsl:attribute>
					</input>
				 </td>
				 </tr>
		</xsl:for-each>
	</table>
</xsl:template>

</xsl:stylesheet>