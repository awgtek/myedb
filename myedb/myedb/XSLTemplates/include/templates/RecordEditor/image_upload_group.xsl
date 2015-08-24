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

<xsl:key name="image_upload_key" match="property[@prop_group_id='3']" use="@ron" />

<xsl:template name="image_upload_group">
			<table>

				<xsl:variable name="images_added" select="count(property[@prop_group_id='3' and @ron &gt; '0'])" />
			  <xsl:for-each select="property[generate-id(.)=generate-id(key('image_upload_key',@ron)) ]">
				<!--  Sort Primary key by name in ascending order 
				  --> 
				<xsl:sort select="@ron" order="ascending" data-type="number"/> 
				<xsl:variable name="addressnum" select="@ron" />
					  <tr><td>
							<xsl:if test="@epi = 0">
								<table border="0" cellpadding="0" cellspacing="0" style="width: 100%; border: 0;">
								<tr>
								<td>
								<!--<input type="radio" name="rdio_image_upload" value="desktop" checked="true" >
									<xsl:attribute name="onfocus" >
										var regexstr = "";
										<xsl:for-each select="key('image_upload_key',@ron)">
											regexstr += '<xsl:value-of select="@ffi" />\|';
										</xsl:for-each>
										regexstr = regexstr.substr(0,regexstr.length - 2);
										regex_exceptions_hash[regexstr] = 0;
									
										hidelaptop('new_image_upload_div');return false;
									</xsl:attribute>
								</input>
								<span class="linkswhite">Don't add</span>-->
								<a href="#" >
									<xsl:attribute name="onclick"> 
										var regexstr = "";
										<xsl:for-each select="key('image_upload_key',@ron)">
											regexstr += '<xsl:value-of select="@ffi" />\|';
										</xsl:for-each>
										regexstr = regexstr.substr(0,regexstr.length - 2);
										
										 if (document.getElementById('new_image_upload_div_<xsl:value-of select="@ron" />').style.display == 'none')
										 {
											regex_exceptions_hash[regexstr] = 1;
											showlaptop('new_image_upload_div_<xsl:value-of select="@ron" />');return false;
										 }
										 else
										 {
											regex_exceptions_hash[regexstr] = 0;
											hidelaptop('new_image_upload_div_<xsl:value-of select="@ron" />');return false;
										 }
										
									</xsl:attribute>New image
								</a>
								<span class="linkswhite">
								</span>
								</td>
								</tr>
								</table>
							</xsl:if>
						</td>
						</tr>
					<tr>
					<td>
				  
				  <div >
						<xsl:if test="@epi = 0">
							<xsl:if test="$images_added &gt; 0">
								<xsl:attribute name="style" >background-color:#00FF99;display: none;</xsl:attribute>
							</xsl:if>
							<xsl:attribute name="id" >new_image_upload_div_<xsl:value-of select="@ron" /></xsl:attribute>
							<xsl:attribute name="class" >options</xsl:attribute>
						</xsl:if>

				  	<table>
				  
						<tr class="sechead">
							<td colspan="2" > Image <xsl:value-of select="$addressnum + 1"/> 
								<xsl:if test="@epi &gt; 0">
									<input type="checkbox" name="groups_to_delete[]" >
										<xsl:attribute name="value">pgid<xsl:value-of select="@prop_group_id"/>rid<xsl:value-of select="@ron" />
										</xsl:attribute>
									</input> Delete? 
								</xsl:if>
								
							<!--	<select name="rep_prop_quals[]">
									<option >
											<xsl:attribute name="value" >pqi0pgi<xsl:value-of select="@prop_group_id"/>ron<xsl:value-of select="@ron"/></xsl:attribute>
									Select
									</option>
									<xsl:variable name="prop_group_id_var" select="@prop_group_id"/>
									<xsl:variable name="ron_var" select="@ron"/>
									<xsl:for-each select="/record/prop_qualifiers/prop_qualifier[@prop_group_id=$prop_group_id_var]">
										<option >
											<xsl:attribute name="value" >pqi<xsl:value-of select="@prop_qual_id"/>pgi<xsl:value-of select="@prop_group_id"/>ron<xsl:value-of select="$ron_var"/></xsl:attribute>
											<xsl:if test="./@prop_qual_id = /record/rpqs/repeat_prop_qualifier[@prop_group_id=$prop_group_id_var and @ron=$ron_var]/@prop_qual_id"> 
												<xsl:attribute name="SELECTED">true</xsl:attribute>
											</xsl:if>
											<xsl:value-of select="@qualifier"/>
											
										</option>
									</xsl:for-each>
								</select>-->
				
							</td>
						</tr>
							<xsl:for-each select="key('image_upload_key',@ron)">
							 <xsl:choose>
								 <xsl:when test="@prop_id = 26 " >
									<xsl:apply-templates select="." mode="image_link" />
								 </xsl:when>
								 <xsl:when test="@prop_id = 27 " >
									<xsl:apply-templates select="." mode="image_link" />
								 </xsl:when>
								 <xsl:otherwise>
									<xsl:apply-templates select="." />
								 </xsl:otherwise>
							 </xsl:choose>
							</xsl:for-each>
					</table>
					</div>
					</td></tr>
			  	</xsl:for-each>
 			</table>

</xsl:template>
</xsl:stylesheet>