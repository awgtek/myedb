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

<xsl:template name="category_group">

	<script>
		var cat_subcat_ins = new Array();
		var cat_subcat_dels = new Array();
	</script>

				 <xsl:for-each select="key('prop_list_by_name','Category')">
						<xsl:sort select="@ron" order="ascending" data-type="number"/> 
						<xsl:variable name="catpropval" select="value" />
						<xsl:variable name="stored_cat_count" select="count(../property[@prop_id = 6 and @epi != 0])" />
						<xsl:variable name="stored_cat_nodes" select="../property[@prop_id = 6 and @epi != 0]" /> 
						<xsl:variable name="curpos" select="position()" />
						<xsl:variable name="curcatval">
							<xsl:if test="@epi = 0">
								<xsl:value-of select="/myedbroot/categories/category[not(@cat_id = $stored_cat_nodes/value)][$curpos - $stored_cat_count]/catval" />
							</xsl:if>
							<xsl:if test="@epi != 0">
								<xsl:value-of select="/myedbroot/categories/category[ @cat_id = $catpropval]/catval" />
							</xsl:if>
						</xsl:variable>
						<xsl:variable name="curcatid">
							<xsl:if test="@epi = 0">
								<xsl:value-of select="/myedbroot/categories/category[not(@cat_id = $stored_cat_nodes/value)][$curpos - $stored_cat_count]/@cat_id" />
							</xsl:if>
							<xsl:if test="@epi != 0">
								<xsl:value-of select="/myedbroot/categories/category[ @cat_id = $catpropval]/@cat_id" />
								<!-- or could just do <xsl:value-of select="$catpropval" /> -->
							</xsl:if>
						</xsl:variable>
						<!--<xsl:apply-templates select="./validator/select"/>-->
						<xsl:if test="/myedbroot/categories/category[@cat_id = $curcatid]/@is_disabled != 1" >
							<tr>
								<td>
									Category:
								</td>
								<td >
									<input type="hidden" >
										<xsl:attribute name="id"><xsl:value-of select="@ffi" />_stored</xsl:attribute>
										<xsl:attribute name="value"><xsl:value-of select="value" /></xsl:attribute>
									</input>
									<input type="checkbox" >
										<xsl:attribute name="onClick">
											if (document.getElementById('<xsl:value-of select="@ffi" />_stored').value)
											{ 
												document.getElementById('<xsl:value-of select="@ffi" />_del').checked = ! (this.checked); 
											}
											if (!(this.checked))
											{
												for (var i=0; i &lt; cat_subcat_ins[<xsl:value-of select="$curcatid" />].length; i++)
												{
													//alert (cat_subcat_ins[<xsl:value-of select="$curcatid" />][i]);
													document.getElementById(cat_subcat_ins[<xsl:value-of select="$curcatid" />][i]).checked = false;
												}
											/*	for (var i=0; i &lt; cat_subcat_dels[<xsl:value-of select="$curcatid" />].length; i++)
												{
													//alert (cat_subcat_ins[<xsl:value-of select="$curcatid" />][i]);
													document.getElementById(cat_subcat_dels[<xsl:value-of select="$curcatid" />][i]).checked = true;
												} */ //don't need this because stored procedure del_prop_by_ron deletes subcats already
											}
										</xsl:attribute>
										<xsl:attribute name="name"><xsl:value-of select="@ffi" /></xsl:attribute>
										<xsl:attribute name="id"><xsl:value-of select="@ffi" /></xsl:attribute>
										<xsl:attribute name="value"><xsl:value-of select="$curcatid" /></xsl:attribute>
										<xsl:if test="@epi != 0">
											<xsl:attribute name="checked"></xsl:attribute>
										</xsl:if>
									</input>
									<xsl:value-of select="$curcatval" />
				
									<input type="checkbox" name="props_to_delete[]"  style="visibility:hidden">
										<xsl:attribute name="value">pid<xsl:value-of select="@prop_id"/>rid<xsl:value-of select="@ron" />
										</xsl:attribute>
										<xsl:attribute name="id"><xsl:value-of select="@ffi" />_del</xsl:attribute>
									</input>
						<!--			<select >
										<xsl:attribute name="name"><xsl:value-of select="@ffi" /></xsl:attribute>
										<xsl:attribute name="id"><xsl:value-of select="@ffi" /></xsl:attribute>
										<OPTION value="" selected="true">Select one</OPTION>
									<xsl:for-each select="/myedbroot/categories/category[@is_disabled != 1]" >
										<option >
											<xsl:attribute name="value">
											<xsl:value-of select="@cat_id"/>
											</xsl:attribute>
											<xsl:if test="@cat_id = $catpropval"> 
											<xsl:attribute name="SELECTED">true</xsl:attribute>
											</xsl:if>
											<xsl:value-of select="catval" />
										</option>
									</xsl:for-each>
									</select>
									-->
								</td>
							</tr>
							<tr bgcolor="#6699CC">
								<td>
									Subcategory:
								</td>
								<td>
								<script>
									cat_subcat_ins[<xsl:value-of select="$curcatid" />] = new Array();
									cat_subcat_dels[<xsl:value-of select="$curcatid" />] = new Array();
								</script>
								 <xsl:for-each select="key('prop_list_by_name','Subcategory')">
										<xsl:sort select="@ron" order="ascending" data-type="number"/> 
										<xsl:variable name="subcatpropval" select="value" />
										<xsl:variable name="stored_subcat_count" select="count(../property[@prop_id = 50 and @epi != 0])" />
										<xsl:variable name="stored_subcat_nodes" select="../property[@prop_id = 50 and @epi != 0]" /> 
										<xsl:variable name="subcat_curpos" select="position()" />
										<xsl:variable name="cursubcatval">
											<xsl:if test="@epi = 0">
												<xsl:value-of select="/myedbroot/subcategories/subcategory[not(@subcat_id = $stored_subcat_nodes/value)][$subcat_curpos - $stored_subcat_count]/@subcat_name" />
											</xsl:if>
											<xsl:if test="@epi != 0">
												<xsl:value-of select="/myedbroot/subcategories/subcategory[ @subcat_id = $subcatpropval]/@subcat_name" />
											</xsl:if>
										</xsl:variable>
										<xsl:variable name="cursubcatid">
											<xsl:if test="@epi = 0">
												<xsl:value-of select="/myedbroot/subcategories/subcategory[not(@subcat_id = $stored_subcat_nodes/value)][$subcat_curpos - $stored_subcat_count]/@subcat_id" />
											</xsl:if>
											<xsl:if test="@epi != 0">
												<xsl:value-of select="/myedbroot/subcategories/subcategory[ @subcat_id = $subcatpropval]/@subcat_id" />
											</xsl:if>
										</xsl:variable>
										<xsl:if test="($curcatid = /myedbroot/subcategories/subcategory[@subcat_id = $cursubcatid]/@cat_id) 
												and /myedbroot/subcategories/subcategory[@subcat_id = $cursubcatid]/@is_disabled != 1">
											<div style="border:thin" >
											<input type="hidden" >
												<xsl:attribute name="id"><xsl:value-of select="@ffi" />_stored</xsl:attribute>
												<xsl:attribute name="value"><xsl:value-of select="value" /></xsl:attribute>
											</input>
												<script>
													cat_subcat_ins[<xsl:value-of select="$curcatid" />].push( '<xsl:value-of select="@ffi" />');
												</script>
												<xsl:if test="number(value) &gt; 0">
												<script>
													cat_subcat_dels[<xsl:value-of select="$curcatid" />].push( '<xsl:value-of select="@ffi" />_del');
												</script>
												</xsl:if>
											<input type="checkbox" >
												<xsl:attribute name="onClick">
													if (document.getElementById('<xsl:value-of select="@ffi" />_stored').value)
													{ 
														document.getElementById('<xsl:value-of select="@ffi" />_del').checked = ! (this.checked); 
													}
												</xsl:attribute>
												<xsl:attribute name="name"><xsl:value-of select="@ffi" /></xsl:attribute>
												<xsl:attribute name="id"><xsl:value-of select="@ffi" /></xsl:attribute>
												<xsl:attribute name="value"><xsl:value-of select="$cursubcatid" /></xsl:attribute>
												<xsl:if test="@epi != 0">
													<xsl:attribute name="checked"></xsl:attribute>
												</xsl:if>
											</input>
											<xsl:value-of select="$cursubcatval" />
						
											<input type="checkbox" name="props_to_delete[]"  style="visibility:hidden">
												<xsl:attribute name="value">pid<xsl:value-of select="@prop_id"/>rid<xsl:value-of select="@ron" />
												</xsl:attribute>
												<xsl:attribute name="id"><xsl:value-of select="@ffi" />_del</xsl:attribute>
											</input>
											</div>
										</xsl:if>
									</xsl:for-each>
								</td>
							</tr>
						</xsl:if>
				<!--		<tr>
							<td  colspan="2" >
								<xsl:if test="@epi &gt; 0">
									<input type="checkbox" name="props_to_delete[]" >
										<xsl:attribute name="value">pid<xsl:value-of select="@prop_id"/>rid<xsl:value-of select="@ron" />
										</xsl:attribute>
									</input> Delete? 
								</xsl:if>
							</td>
						</tr>-->
				 </xsl:for-each>
				<!-- 
				 <xsl:for-each select="key('prop_list_by_name','Subcategory')">
						<xsl:sort select="@ron" order="ascending" data-type="number"/> 
						<xsl:variable name="subcatpropval" select="value" />
						<tr>
							<td>
								Subcategory
							</td>
							<td >
								<select >
									<xsl:attribute name="name"><xsl:value-of select="@ffi" /></xsl:attribute>
									<xsl:attribute name="id"><xsl:value-of select="@ffi" /></xsl:attribute>
									<OPTION value="" selected="true">Select one</OPTION>
								<xsl:for-each select="/myedbroot/subcategories/subcategory[@cat_id = key('prop_list_by_name','Category')/value and @is_disabled != 1]" >
									<option >
										<xsl:attribute name="value">
										<xsl:value-of select="@subcat_id"/>
										</xsl:attribute>
										<xsl:if test="@subcat_id = $subcatpropval"> 
										<xsl:attribute name="SELECTED">true</xsl:attribute>
										</xsl:if>
										<xsl:value-of select="@subcat_name" />
									</option>
								</xsl:for-each>
								</select>
							</td>
						</tr>
						<tr>
							<td  colspan="2" >
								<xsl:if test="@epi &gt; 0">
									<input type="checkbox" name="props_to_delete[]" >
										<xsl:attribute name="value">pid<xsl:value-of select="@prop_id"/>rid<xsl:value-of select="@ron" />
										</xsl:attribute>
									</input> Delete? 
								</xsl:if>
							</td>
						</tr>
				 </xsl:for-each>
		-->
</xsl:template>
</xsl:stylesheet>