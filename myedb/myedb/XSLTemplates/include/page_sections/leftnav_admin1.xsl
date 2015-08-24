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
<xsl:template name="leftnav_admin1">



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

<body>

<table width="179" border="1" cellspacing="0" cellpadding="0">
	<tr>
	    <td width="179" valign="top" style="background-image:url(../images/left-nav.gif); background-repeat:no-repeat;">-->
<div class="leftnavigation" style="width:179px;">
		<div class="nav-top" style="padding-top:5px; font-weight:bold; line-height:35px; font-size:13px; padding-left:10px; height:160px;font-family:Arial, Helvetica, sans-serif; padding-right:3px;">
		<!--<a href="index.php?target_component%5B%5D=RecordIniFacade&amp;target_function%5B%5D=initialize&amp;eid=0&amp;type_id=1&amp;output_function=show_record_for_edit">Manage Products</a><br />-->
		<a href="index.php?target_component%5B%5D=RecordIniFacade&amp;target_function%5B%5D=donothing&amp;OF_passthru=manage_products">Manage Products</a><br />
    <a href="index.php?target_component%5B%5D=RecordIniFacade&amp;target_function%5B%5D=initialize&amp;eid=0&amp;type_id=2&amp;output_function=show_record_for_edit">Insert Ticket Item</a><br />
    <a href="index.php?target_component%5B%5D=RecordIniFacade&amp;target_function%5B%5D=initialize&amp;eid=0&amp;type_id=5&amp;OF_passthru=show_info_record_for_edit">Insert Informational Item</a>
	<br />
  <a href="index.php?target_component%5B%5D=RecordIniFacade&amp;target_function%5B%5D=initialize&amp;eid=0&amp;type_id=4&amp;OF_passthru=show_info_record_for_edit">Insert Travel Item</a>
	<br />
  <a href="index.php?target_component%5B%5D=RecordIniFacade&amp;target_function%5B%5D=initialize&amp;eid=0&amp;type_id=1&amp;output_function=show_record_for_edit">Insert Gift Certificate</a>
	</div>
	<br />
	<br />
<xsl:if test="$auth_level &gt; 3">
	
    <div class="nav-bottom">
<a href="index.php?target_component%5B%5D=RecordIniFacade&amp;target_function%5B%5D=initialize&amp;eid=0&amp;type_id=3&amp;OF_passthru=edit_person_member">Insert Member</a><br />
<a href="index.php?target_component%5B%5D=RecordIniFacade&amp;target_function%5B%5D=initialize&amp;eid=0&amp;type_id=3&amp;OF_passthru=edit_person_admin">Insert Admin User</a><br />
  <a href="index.php?target_component%5B%5D=RecordIniFacade&amp;target_function%5B%5D=filtered_search_by_mixed_criteria&amp;cspi[]=7&amp;cspv[]=&amp;cspt[]=3&amp;spt[]=3&amp;spi[]=25&amp;spv[]=0&amp;spc[]=1&amp;OF_passthru=show_admin_personrecs&amp;init_req=1">List Admins</a>
	<br />
  <a href="index.php?target_component%5B%5D=RecordIniFacade&amp;target_function%5B%5D=filtered_search_by_mixed_criteria&amp;cspi[]=7&amp;cspv[]=&amp;cspt[]=3&amp;spt[]=3&amp;spi[]=25&amp;spv[]=0&amp;spc[]=-1&amp;OF_passthru=show_member_personrecs&amp;noencaps=1&amp;init_req=1">List Members</a>
	<br />
<a href="index.php?target_component%5B%5D=ClientServerDataOps&amp;target_function%5B%5D=initialize_lookup_table&amp;table_name=acctmgr&amp;OF_passthru=lookuptable_editor">Edit Account Managers</a>
  <br />
  <a href="index.php?target_component%5B%5D=ClientServerDataOps&amp;target_function%5B%5D=initialize_lookup_table&amp;table_name=category&amp;OF_passthru=lookuptable_editor">Manage Categories</a>
<br /><a href="index.php?target_component%5B%5D=ClientServerDataOps&amp;target_function%5B%5D=initialize_sub_lookup_table&amp;table_name=subcategory&amp;OF_passthru=sublookuptable_editor">Manage Subcategories</a>
<br /><a href="index.php?target_component%5B%5D=ClientServerDataOps&amp;target_function%5B%5D=initialize_lookup_table&amp;table_name=status&amp;OF_passthru=lookuptable_editor">Edit Status codes</a><br />
<a href="index.php?target_component%5B%5D=MetaDataOps&amp;target_function%5B%5D=FI_get_xml_list&amp;OF_passthru=edit_entity_groupings">Featured Items</a><br />
<a href="index.php?target_component%5B%5D=RecordIniFacade&amp;target_function%5B%5D=initialize&amp;eid=11&amp;type_id=15&amp;OF_passthru=edit_site_variables">Site Settings</a><br />
  <a href="#">Manage Members</a> <br />
  <a href="#">Export</a> <br />
  <a href="#">Statistics</a> <br />
  &nbsp;<!--to ensure empty spot at bottom of nav--></div>
  

</xsl:if>
</div>
<!--</td>
	
	</tr>
	
  

  
</table>


-->
</xsl:template>
</xsl:stylesheet>