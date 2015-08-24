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
<xsl:template name="leftnav_admin">



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


<table border="0" cellspacing="0" cellpadding="0" style="width:179px;">
    <tr>
		<td class="logo">&nbsp;</td>
    </tr>
  <tr>
    <td colspan="2" valign="top"><div class="top">Admin Functions</div></td>
  </tr>	
    <tr><td style="background-image:url(images/nav-left.jpg); height:42px;">&nbsp;</td>
    </tr>
    <tr><td style="height:42px;"><div align="center">
		<p >Search Area</p>
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
					<br />
					<select name="srtpi[]">
						<option value="0">Sort by</option>
						<option value="1">By Name</option>
						<option value="12">By City</option>
						<option value="13">By State</option>
					</select>
					<input type="hidden" name="target_component[]" value="RecordIniFacade"/>
					<input type="hidden" name="target_function[]" value="filtered_search_by_mixed_criteria"/>
					<input type="hidden" name="output_function" value="admin_paged_content" />
					<br /><input type="submit" value="GO"/>
				</form>
				</div>
			</td>
    </tr>
    <tr>
	<td><img src="../images/nav-left-top.jpg" /></td>
	</tr>
	<tr>
	    <td width="179" valign="top" style="background-image:url(../images/left-nav.gif); background-repeat:no-repeat;">
		<div class="nav-top">
		<a href="index.php?target_component%5B%5D=RecordIniFacade&amp;target_function%5B%5D=initialize&amp;eid=0&amp;type_id=1&amp;output_function=show_record_for_edit">Manage Products</a><br />
    <a href="index.php?target_component%5B%5D=RecordIniFacade&amp;target_function%5B%5D=initialize&amp;eid=0&amp;type_id=2&amp;OF_passthru=show_info_record_for_edit">Insert Ticket Item</a><br />
    <a href="index.php?target_component%5B%5D=RecordIniFacade&amp;target_function%5B%5D=initialize&amp;eid=0&amp;type_id=5&amp;OF_passthru=show_info_record_for_edit">Insert Informational Item</a>
	<br />
  <a href="index.php?target_component%5B%5D=RecordIniFacade&amp;target_function%5B%5D=initialize&amp;eid=0&amp;type_id=4&amp;output_function=show_record_for_edit">Insert Travel Item</a>
	</div>
    <div class="nav-bottom">
<a href="#">Insert Member</a><br />
<a href="index.php?target_component%5B%5D=RecordIniFacade&amp;target_function%5B%5D=initialize&amp;eid=0&amp;type_id=3&amp;OF_passthru=edit_person_admin">Insert Admin User</a><br />
  <a href="index.php?target_component%5B%5D=RecordIniFacade&amp;target_function%5B%5D=filtered_search_by_mixed_criteria&amp;cspi[]=7&amp;cspv[]=&amp;cspt[]=3&amp;spt[]=3&amp;spi[]=25&amp;spv[]=0&amp;spc[]=1&amp;OF_passthru=show_admin_personrecs">List Admins</a>
  <br />
  <a href="index.php?target_component%5B%5D=ClientServerDataOps&amp;target_function%5B%5D=initialize_lookup_table&amp;table_name=category&amp;OF_passthru=lookuptable_editor">Manage Categories</a>
<br /><a href="index.php?target_component%5B%5D=ClientServerDataOps&amp;target_function%5B%5D=initialize_sub_lookup_table&amp;table_name=subcategory&amp;OF_passthru=sublookuptable_editor">Manage Subcategories</a>
	<br />
<a href="index.php?target_component%5B%5D=ClientServerDataOps&amp;target_function%5B%5D=initialize_lookup_table&amp;table_name=state&amp;OF_passthru=lookuptable_editor">Edit States</a>
<br /><a href="index.php?target_component%5B%5D=ClientServerDataOps&amp;target_function%5B%5D=initialize_lookup_table&amp;table_name=status&amp;OF_passthru=lookuptable_editor">Edit Status codes</a><br />
  <a href="#">Orders</a></div>
</td>
	
	</tr>
	
  

  
</table>



</xsl:template>
</xsl:stylesheet>