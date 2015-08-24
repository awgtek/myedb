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
<xsl:include href="lookup_item.xsl" />
<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>
<xsl:param name="title">List Products</xsl:param>

<xsl:template match="/">
<table cellpadding="0" cellspacing="0">
  <tr>
    <td valign="top" >
      <div class="bodytext">
		<form method="post">
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
			<xsl:if test="count(//lookup_item_group/lookup_item) &gt; 0">
			<input type="submit" value="Edit" />
			</xsl:if>
			<xsl:if test="count(//lookup_item_group/lookup_item) = 0">
					No Results
			</xsl:if>
		</form>

      </div>

	</td>
	  </tr>
	  <tr>
		<td valign="top"><div><!--<img src="/images/bottom.gif" width="800" height="21" />--></div></td>
	  </tr>
</table>
</xsl:template>
</xsl:stylesheet>