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
		      <div class="bodytext2">


<form method="get">
	<input type="hidden" name="target_component[]" value="ClientServerDataOps" />
	<input type="hidden" name="target_function[]" value="initialize_sub_lookup_table" />
	<input type="hidden" name="table_name"  >
		<xsl:attribute name="value">
			<xsl:value-of select="$table_name"/>
		</xsl:attribute>
	</input>
	<input type="hidden" name="OF_passthru" value="sublookuptable_editor" />
	<select name="cat_id">
		<xsl:for-each select="/myedbroot/categories/category" >
			<option>
				<xsl:if test="@cat_id = $cat_id">
					<xsl:attribute name="selected">1</xsl:attribute>
				</xsl:if>
				<xsl:attribute name="value"><xsl:value-of select="@cat_id" /></xsl:attribute>
				<xsl:value-of select="catval" />
			</option>
		</xsl:for-each>
	</select>
	<input type="submit" value="Select Master Category" />
</form>	
Insert new:
<form method="post">
	<input type="hidden" name="target_component[]" value="ClientServerDataOps" />
	<input type="hidden" name="target_function[]" value="insert_sublookuptable" />
	<input type="hidden" name="target_component[]" value="ClientServerDataOps" />
	<input type="hidden" name="target_function[]" value="initialize_sub_lookup_table" />
	<input type="hidden" name="table_name"  >
		<xsl:attribute name="value">
			<xsl:value-of select="$table_name"/>
		</xsl:attribute>
	</input>
	<input type="hidden" name="OF_passthru" value="sublookuptable_editor" />
	<input type="text" name="insert_value" />
	<select name="parent_tbl_id">
		<xsl:for-each select="/myedbroot/categories/category" >
			<option>
				<xsl:if test="@cat_id = $cat_id">
					<xsl:attribute name="selected">1</xsl:attribute>
				</xsl:if>
				<xsl:attribute name="value"><xsl:value-of select="@cat_id" /></xsl:attribute>
				<xsl:value-of select="catval" />
			</option>
		</xsl:for-each>
	</select>
	<input type="submit" value="Insert" />
</form>	
		<div id="target"> </div>
		<div id="searchresultsdiv" ></div>

<!--<form method="post">
	<input type="hidden" name="target_component[]" value="ClientServerDataOps" />
	<input type="hidden" name="target_function[]" value="update_lookuptable" />
	<input type="hidden" name="target_component[]" value="ClientServerDataOps" />
	<input type="hidden" name="target_function[]" value="initialize_sub_lookup_table" />
	<input type="hidden" name="table_name"  >
		<xsl:attribute name="value">
			<xsl:value-of select="$table_name"/>
		</xsl:attribute>
	</input>
	<input type="hidden" name="OF_passthru" value="sublookuptable_editor" />

	<xsl:apply-templates select="//lookup_item_group/lookup_item" />
	<input type="submit" value="Edit" />
</form>
-->

</div>
</xsl:template>
<!--
<xsl:template match="lookup_item">
	<input type="text"  >
		<xsl:attribute name="name">edit_<xsl:value-of select="@prim_key_col"/>
		</xsl:attribute>
		<xsl:attribute name="value">
			<xsl:value-of select="@lookup_value_col"/>
		</xsl:attribute>
	</input>
	<xsl:variable name="lvplti" select="@lookup_value_parent_lookup_tbl_id" />
	<xsl:value-of select="/myedbroot/categories/category[@cat_id=$lvplti]/catval" />
	<input type="checkbox"  >
		<xsl:attribute name="name">delete_<xsl:value-of select="@prim_key_col"/>
		</xsl:attribute>
	</input> delete?
	<br />
</xsl:template>
-->
</xsl:stylesheet>