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


<table width="100%" border="0" cellspacing="0" bgcolor=""  cellpadding="0">
<!--		 <tr>
		 <td class="background"><div align="left" style="padding-left:8px;"><strong>Search Results:</strong></div></td>
		 <td class="background">
		</td>
		<td class="background">

		</td>
		 </tr>
-->
  <tr>
    <td valign="top">
<!--	<table width="100%" border="1" cellspacing="0" bgcolor=""  cellpadding="0">
		<tr>
			<td>
			</td>
		</tr>
	</table>-->
	<table border="0" width="100%" cellpadding="0" cellspacing="0"><br />
		<tr>
			<td width="50%">
				<div id="target" style="display:inline; "></div>	
				</td>
			<td>
				<div style="display:inline; " id="launch_searchres_csv"></div>
			</td>
		</tr>
	</table>
		<div style=" text-align:center; display:inline;" id="searchresultsdiv" ></div>
		<!--<xsl:call-template name="show_search_results" />-->
    </td>
  <!--  <td>
		<table width="100%">
		<tr>
			<td>Search: 
				<form method="post" action="">
					<input type="text" name="spv" /><br />
					<select name="spi">
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
					<input type="hidden" name="target_component[]" value="RecordIniFacade"/>
					<input type="hidden" name="target_function[]" value="search_by_prop_val_contains"/>
					<input type="hidden" name="output_function" value="admin_paged_content" />
					<br /><input type="submit" value="GO"/>
				</form>
			</td>
		</tr>
		<xsl:call-template name="list_category_links" >
			<xsl:with-param name="param_type_id" select="1" />
		</xsl:call-template>
		<xsl:call-template name="list_category_links" >
			<xsl:with-param name="param_type_id" select="2" />
		</xsl:call-template>
		</table>
	 </td>-->
  </tr>
  <tr>
    <td></td>
    <td></td>
  </tr>
</table>

</xsl:template>
</xsl:stylesheet>