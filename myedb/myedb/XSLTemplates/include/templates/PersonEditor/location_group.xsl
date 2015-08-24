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
<xsl:include href="../generic/location_items.xsl" />

<xsl:output method="html" encoding="utf-8"/>

<xsl:key name="record" match="property[@prop_group_id='1']" use="@ron" />
<xsl:key name="addressline1" match="property[@prop_name='Address Line 1']" use="@epi" />

<xsl:template name="location_group">
			<table>

			  <xsl:for-each select="property[generate-id(.)=generate-id(key('record',@ron)) ]">
				<!--  Sort Primary key by name in ascending order 
				  --> 
				<xsl:sort select="@ron" order="ascending" data-type="number"/> 
				<xsl:variable name="addressnum" select="@ron" />
				  <xsl:variable name="newaddresses" select="count(key('addressline1',0))" />
				  <xsl:if test="$newaddresses = 1" ><!--will be more than one if record has no addresses-->
					  <tr><td>
							<xsl:if test="@epi = 0">
								<script>//new record set to not do validation until group shown
										var regexstr = "";
										<xsl:for-each select="key('record',@ron)">
											regexstr += '<xsl:value-of select="@ffi" />\|';
										</xsl:for-each>
										regexstr = regexstr.substr(0,regexstr.length - 2);
										regex_exceptions_hash[regexstr] = 0;
								</script>
								<table border="0" cellpadding="0" cellspacing="0" style="width: 100%; border: 0;">
								<tr>
								<td>
								<span class="linkswhite">
											<a href="#" >
												<xsl:attribute name="onclick" >
										var regexstr = "";
										<xsl:for-each select="key('record',@ron)">
											regexstr += '<xsl:value-of select="@ffi" />\|';
										</xsl:for-each>
										regexstr = regexstr.substr(0,regexstr.length - 2);
										regex_exceptions_hash[regexstr] = 0;
									
										hidelaptop('laptop');return false;
									</xsl:attribute>Don't add
											</a>
											</span> | 
								<span class="linkswhite">
											<a href="#" >
												<xsl:attribute name="onclick" >
										var regexstr = "";
										<xsl:for-each select="key('record',@ron)">
											regexstr += '<xsl:value-of select="@ffi" />\|';
										</xsl:for-each>
										regexstr = regexstr.substr(0,regexstr.length - 2);
										regex_exceptions_hash[regexstr] = 1;
										showlaptop('laptop');return true;
									</xsl:attribute>Add Address
											</a>
											</span>
								</td>
								</tr>
								</table>
							</xsl:if>
						</td>
						</tr>
					</xsl:if>
					<tr>
					<td>
				  
				  <div >
						<xsl:if test="@epi = 0 and $newaddresses = 1">
							<xsl:attribute name="style" >background-image:url(/images/green.jpg);display: none;</xsl:attribute>
							<xsl:attribute name="id" >laptop</xsl:attribute>
							<xsl:attribute name="class" >options</xsl:attribute>
						</xsl:if>

				  	<table>
				  
						<tr  class="sechead">
							<td colspan="2" > Address <xsl:value-of select="$addressnum + 1"/> 
								<xsl:if test="@epi &gt; 0">
									<input type="checkbox" name="groups_to_delete[]" >
										<xsl:attribute name="value">pgid<xsl:value-of select="@prop_group_id"/>rid<xsl:value-of select="@ron" />
										</xsl:attribute>
									</input> Delete? 
								</xsl:if>
								
								<select name="rep_prop_quals[]">
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
								</select>
				
							</td>
						</tr>
							<xsl:for-each select="key('record',@ron)">
								<xsl:choose>
									 <xsl:when test="@prop_name = 'State' " >
										<xsl:call-template name="states_select" />
									 </xsl:when>
									 <xsl:when test="@prop_name = 'Zip'" >
										<xsl:if test="@epi &gt; 0">
											<xsl:variable name="var_value" select="value" />
											<xsl:call-template name="print_lookup_value_in_input_field" >
												<xsl:with-param name="lkp_tbl_path" select="/myedbroot/lookup_table_zips/zip[@zip_id=$var_value]" />
											</xsl:call-template>
										</xsl:if>
										<xsl:if test="@epi = 0">
											<xsl:apply-templates select="."  mode="append_standin" />
										</xsl:if>
									 </xsl:when>
									 <xsl:when test="@prop_name = 'City'" >
										<xsl:if test="@epi &gt; 0">
											<xsl:variable name="var_value" select="value" />
											<xsl:call-template name="print_lookup_value_in_input_field" >
												<xsl:with-param name="lkp_tbl_path" select="/myedbroot/lookup_table_cities/city[@city_id=$var_value]" />
											</xsl:call-template>
										</xsl:if>
										<xsl:if test="@epi = 0">
											<xsl:apply-templates select="."  mode="append_standin" />
										</xsl:if>
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