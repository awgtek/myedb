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
<xsl:template name="leftnav"><style type="text/css">
<xsl:comment>
.style1 {font-family: Arial, Helvetica, sans-serif}
</xsl:comment>
</style>


<!--
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>Untitled Document</title>
<style type="text/css">
<xsl:comment>
.style1 {font-family: Arial, Helvetica, sans-serif}
</xsl:comment>
</style>
</head>

<body>-->
<p class="style1">Search Area</p>
				<form method="post" action="index.php">
					<input type="text" name="cspv[]" /><br />
					<select name="cspi[]">
						<option value="1">By Name</option>
						<option value="2">By Description</option>
						<option value="12">By City</option>
						<option value="13">By State</option>
					</select>
					<br /><select name="type_id">
						<option value="1">Inventory type</option>
						<option value="2">Ticket type</option>
						<option value="4">Travel type</option>
						<option value="5">Informational type</option>
					</select>
					<br />
					<input type="hidden" name="spi[]" value="6" />
					<select name="spv[]">
							<option value="0">Any Category</option>
						<xsl:for-each select="//categories/category[@is_disabled != 1]">
							<option >
								<xsl:attribute name="value"><xsl:value-of select="@cat_id" /></xsl:attribute>
								<xsl:value-of select="catval" />
							</option>
						</xsl:for-each>
					</select>
					<input type="hidden" name="target_component[]" value="RecordIniFacade"/>
					<input type="hidden" name="target_function[]" value="filtered_search_by_mixed_criteria"/>
					<input type="hidden" name="output_function" value="admin_paged_content" />
					<br /><input type="submit" value="GO"/>
				</form>

<p class="style1"> <a href="index.php?target_component%5B%5D=RecordIniFacade&amp;target_function%5B%5D=initialize&amp;eid=0&amp;type_id=1&amp;output_function=show_record_for_edit">Insert Product</a><br />
    <a href="index.php?target_component%5B%5D=RecordIniFacade&amp;target_function%5B%5D=initialize&amp;eid=0&amp;type_id=2&amp;output_function=show_record_for_edit">Insert Ticket Item</a><br />
    <a href="index.php?target_component%5B%5D=RecordIniFacade&amp;target_function%5B%5D=initialize&amp;eid=0&amp;type_id=5&amp;output_function=show_record_for_edit">Insert Informational Item</a><br />
  <a href="index.php?target_component%5B%5D=RecordIniFacade&amp;target_function%5B%5D=initialize&amp;eid=0&amp;type_id=4&amp;output_function=show_record_for_edit">Insert Travel Item</a></p>
<p class="style1"><a href="index.php?target_component%5B%5D=RecordIniFacade&amp;target_function%5B%5D=initialize&amp;eid=0&amp;type_id=3&amp;output_function=edit_person">Insert User</a><br />
  <a href="index.php?target_component%5B%5D=RecordIniFacade&amp;target_function%5B%5D=search_by_prop_val_contains&amp;spi=8&amp;spv=&amp;type_id=3&amp;OF_passthru=showpersonrecs">List Users</a></p>
<p class="style1"><a href="index.php?target_component%5B%5D=ClientServerDataOps&amp;target_function%5B%5D=initialize_lookup_table&amp;table_name=category&amp;OF_passthru=lookuptable_editor">Manage Categories</a>
<br /><a href="index.php?target_component%5B%5D=ClientServerDataOps&amp;target_function%5B%5D=initialize_lookup_table&amp;table_name=state&amp;OF_passthru=lookuptable_editor">Edit States</a>
<br /><a href="index.php?target_component%5B%5D=ClientServerDataOps&amp;target_function%5B%5D=initialize_lookup_table&amp;table_name=status&amp;OF_passthru=lookuptable_editor">Edit Status codes</a></p>
<!--</body>
</html>-->

</xsl:template>
</xsl:stylesheet>