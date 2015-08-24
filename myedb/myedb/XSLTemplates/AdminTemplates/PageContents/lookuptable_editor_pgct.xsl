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

<!--<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>Untitled Document</title>
</head>

<body>
  <h2>Edit Categories:</h2>-->
<form method="post">
	<input type="hidden" name="target_component[]" value="ClientServerDataOps" />
	<input type="hidden" name="target_function[]" value="update_lookuptable" />
	<input type="hidden" name="target_component[]" value="ClientServerDataOps" />
	<input type="hidden" name="target_function[]" value="initialize_lookup_table" />
	<input type="hidden" name="table_name"  >
		<xsl:attribute name="value">
			<xsl:value-of select="$table_name"/>
		</xsl:attribute>
	</input>
	<input type="hidden" name="OF_passthru" value="lookuptable_editor" />

	<xsl:apply-templates select="//lookup_item_group/lookup_item" />
	<input type="submit" onclick="return confirm('Are you sure?');" value="Edit" />
</form>

Insert new:
<form method="post">
	<input type="hidden" name="target_component[]" value="ClientServerDataOps" />
	<input type="hidden" name="target_function[]" value="insert_lookuptable" />
	<input type="hidden" name="target_component[]" value="ClientServerDataOps" />
	<input type="hidden" name="target_function[]" value="initialize_lookup_table" />
	<input type="hidden" name="table_name"  >
		<xsl:attribute name="value">
			<xsl:value-of select="$table_name"/>
		</xsl:attribute>
	</input>
	<input type="hidden" name="OF_passthru" value="lookuptable_editor" />
	<input type="text" name="insert_value" />
	<input type="submit" value="Insert" />
</form>	
<!--</body>
</html>
-->
</div>
</xsl:template>
</xsl:stylesheet>