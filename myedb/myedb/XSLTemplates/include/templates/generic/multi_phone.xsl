<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet  [
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
<xsl:output method="html" encoding="utf-8"/>
<xsl:template name="multi_phone">
 <xsl:for-each select="key('prop_list_by_name','Phone')">
	 	<xsl:sort select="@ron" order="ascending" data-type="number"/> 
	  <xsl:variable name="newphones" select="count(key('phonekey',0))" />
	  <xsl:if test="$newphones = 1" ><!--will be more than one if record has no phones-->
			<tr><td>
				<xsl:if test="@epi = 0">
					<script>
							var regexstr = "";
							<xsl:for-each select="key('prop_list_by_name','Phone')">
								regexstr += '<xsl:value-of select="@ffi" />\|';
							</xsl:for-each>
							regexstr = regexstr.substr(0,regexstr.length - 2);
							regex_exceptions_hash[regexstr] = 0;
					</script>
					<table width="206" border="0" cellpadding="0" cellspacing="0" style="width: 30% border: 0;">
					<tr width="100%">
					<td>
					<span class="linkswhite">
											<a href="#" >
												<xsl:attribute name="onclick" >
							var regexstr = "";
							<xsl:for-each select="key('prop_list_by_name','Phone')">
								regexstr += '<xsl:value-of select="@ffi" />\|';
							</xsl:for-each>
							regexstr = regexstr.substr(0,regexstr.length - 2);
							regex_exceptions_hash[regexstr] = 0;
						
							hidelaptop('phonediv');return false;
						</xsl:attribute>Don't add
											</a>
											</span> | 
					<span class="linkswhite">
											<a href="#" >
												<xsl:attribute name="onclick" >
							var regexstr = "";
							<xsl:for-each select="key('prop_list_by_name','Phone')">
								regexstr += '<xsl:value-of select="@ffi" />\|';
							</xsl:for-each>
							regexstr = regexstr.substr(0,regexstr.length - 2);
							regex_exceptions_hash[regexstr] = 1;
							showlaptop('phonediv');return true;
						</xsl:attribute>Add new phone
											</a>
											</span> </td>
					</tr>
					</table>
				</xsl:if>
			</td>
			</tr>
		</xsl:if>
		<tr>
		<td>
	  
	  <div >
			<xsl:if test="@epi = 0 and $newphones = 1">
				<xsl:attribute name="style" >background-image:url(/images/green.jpg);display: none;</xsl:attribute>
				<xsl:attribute name="id" >phonediv</xsl:attribute>
				<xsl:attribute name="class" >options</xsl:attribute>
			</xsl:if>

		<table>
		<tr  class="sechead">
		
		<td  colspan="2" >Phone:
		<xsl:if test="@epi &gt; 0">
			<input type="checkbox" name="props_to_delete[]" >
				<xsl:attribute name="value">pid<xsl:value-of select="@prop_id"/>rid<xsl:value-of select="@ron" />
				</xsl:attribute>
			</input> Delete? 
		</xsl:if>

		<select name="rep_prop_quals[]">
			<option >
					<xsl:attribute name="value" >pqi0pi<xsl:value-of select="@prop_id"/>ron<xsl:value-of select="@ron"/></xsl:attribute>
			Select
			</option>
			<xsl:variable name="prop_id_var" select="@prop_id"/>
			<xsl:variable name="ron_var" select="@ron"/>
			<xsl:for-each select="/record/prop_qualifiers/prop_qualifier[@prop_id=$prop_id_var]">
				<option >
					<xsl:attribute name="value" >pqi<xsl:value-of select="@prop_qual_id"/>pi<xsl:value-of select="@prop_id"/>ron<xsl:value-of select="$ron_var"/></xsl:attribute>
					<xsl:if test="./@prop_qual_id = /record/rpqs/repeat_prop_qualifier[@prop_id=$prop_id_var and @ron=$ron_var]/@prop_qual_id"> 
						<xsl:attribute name="SELECTED">true</xsl:attribute>
					</xsl:if>
					<xsl:value-of select="@qualifier"/>
					
				</option>
			</xsl:for-each>
		</select>

		</td></tr>
	 <xsl:apply-templates select="."/>
		</table>
			</div>
			</td>
		</tr>
 </xsl:for-each>
</xsl:template>
</xsl:stylesheet>