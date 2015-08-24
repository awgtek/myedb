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
<xsl:include href="location_group.xsl"/>
<xsl:include href="category_group.xsl"/>
<xsl:include href="status_set.xsl"/>
<xsl:include href="image_upload_group.xsl"/>
<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>

<xsl:template match="record">
 	<tr>
		<td valign="top" width="34%" style="background-image:url(/images/green.jpg);">
			<table border="0" >
				<input type="hidden" name="output_function" value="show_record_for_edit" />
				 <input type="hidden" name="rec_eid">
					<xsl:attribute name="value">
						<xsl:value-of select="@eid"/>
					</xsl:attribute>
				 </input>
				 <input type="hidden" name="rec_type_id">
					<xsl:attribute name="value">
						<xsl:value-of select="@type_id"/>
					</xsl:attribute>
				 </input>
				 <xsl:apply-templates select="property[@prop_name='Product Name']"/>
 				<tr>
					<td colspan="2">
				<xsl:call-template name="location_group" />
					</td>
				</tr>

				 <xsl:apply-templates select="property[@prop_id=52]"/><!--Main contact-->

				 <xsl:for-each select="key('prop_list_by_name','Website')">
						<xsl:sort select="@ron" order="ascending" data-type="number"/> 
						<xsl:apply-templates select="." /><!--mode="print_delete_checkbox"-->
				 </xsl:for-each>
				 <xsl:apply-templates select="property[@prop_id=55]"/><!--Email Address-->
 			</table>
		</td>
		
		<td valign="top" width="33%">
			<table border="0">
				 <xsl:apply-templates select="property[@prop_name='Description']"/>
				<xsl:apply-templates select="property[@prop_name='Notes / Restrictions']"/>
				 <xsl:apply-templates select="property[@prop_id=51]"/><!--Broker Notes-->
			 </table>
		</td>
		<td valign="top" style="background-image:url(/images/green.jpg);" width="33%">
		<table border="0" >
				<xsl:apply-templates select="property[@prop_id=33]"/><!--Account no-->
				<xsl:apply-templates select="property[@prop_id=57]"/><!--Reference no-->
				<xsl:call-template name="status_set" />
				<xsl:call-template name="category_group" />

				<tr><td colspan="2"><xsl:call-template name="image_upload_group"/></td></tr>
				<xsl:apply-templates select="property[@prop_id=35]/validator/select"/>
				<!--<xsl:apply-templates select="property[@prop_id=29]"/>
 				<xsl:apply-templates select="property[@prop_id=30]" mode="checkbox"/>-->
				
				<xsl:if test="@type_id = 2">
				</xsl:if>
					 <xsl:apply-templates select="property[@prop_id=56]"/><!--Limit Per Order-->
				<xsl:apply-templates select="property[@prop_id=54]" mode="in_textarea"/><!--Keywords-->
					 <xsl:apply-templates select="property[@prop_id=58]"/><!--User defined 1-->
					 <xsl:apply-templates select="property[@prop_id=59]"/><!--User defined 2-->
			</table>
		</td>
		
	</tr>
	
	<tr>
		<td colspan="3">
			<table width='100%'  style="padding-left:10px; padding-bottom:10px; background-image:url(/images/darkgreen.gif)">
				<tr class="sechead">
					<td colspan="2" > Product Detail Line </td>
				</tr>
  				<xsl:for-each select="property[generate-id()=generate-id(key('product_detail_line',@ron)) ][1]">
					<tr>
						<td>
							<table>
								<tr>
									<xsl:for-each select="key('product_detail_line',@ron)">
										<td width="175">
											<xsl:value-of select="@prop_name"/>
										</td>
									</xsl:for-each>
								</tr>
							</table>
						</td>
					</tr>
				</xsl:for-each>
			  <xsl:for-each select="property[generate-id(.)=generate-id(key('product_detail_line',@ron)) ]">
				<!--  Sort Primary key by name in ascending order 
				  --> 
					<xsl:sort select="@ron" order="ascending" /> 
					<xsl:if test="@epi = 0">
						<script>//new record set to not do validation until group shown
								var regexstr = "";
								<xsl:for-each select="key('product_detail_line',@ron)">
									regexstr += '<xsl:value-of select="@ffi" />\|';
								</xsl:for-each>
								regexstr = regexstr.substr(0,regexstr.length - 2);
								regex_exceptions_hash[regexstr] = 0;
						</script>
						  <tr>
						  	<td>
								<table width="206" border="0" cellpadding="0" cellspacing="0" style="width: 30%; border: 0;">
									<tr >
										<td><span class="linkswhite">
											<a href="#" >
												<xsl:attribute name="onclick" >
													var regexstr = "";
													<xsl:for-each select="key('product_detail_line',@ron)">
														regexstr += '<xsl:value-of select="@ffi" />\|';
													</xsl:for-each>
													regexstr = regexstr.substr(0,regexstr.length - 2);
													regex_exceptions_hash[regexstr] = 0;
												
													hidelaptop('detaildiv_<xsl:value-of select="@ron" />');return false;
												</xsl:attribute>Don't add
											</a>
											</span>
										<!--	<input type="radio" name="pctype" value="laptop" > 
											</input>--> | 
											<a href="#" >
												<xsl:attribute name="onclick"> 
													var regexstr = "";
													<xsl:for-each select="key('product_detail_line',@ron)">
														regexstr += '<xsl:value-of select="@ffi" />\|';
													</xsl:for-each>
													regexstr = regexstr.substr(0,regexstr.length - 2);
													regex_exceptions_hash[regexstr] = 1;
													showlaptop('detaildiv_<xsl:value-of select="@ron" />');return false;
												</xsl:attribute>
											<span class="linkswhite">Add New Detail Line?
											</span>
											</a>
											</td>
										</tr>
									</table>
								</td>
							</tr>
					</xsl:if>
					<tr>
						<td>
						  <div >
							<xsl:if test="@epi = 0">
								<xsl:attribute name="style" >background-image:url(/images/darkgreen.jpg);display: none;</xsl:attribute>
								<xsl:attribute name="id" >detaildiv_<xsl:value-of select="@ron" /></xsl:attribute>
								<xsl:attribute name="class" >options</xsl:attribute>
							</xsl:if>
							<table>
								 <tr>
									<xsl:for-each select="key('product_detail_line',@ron)">
										 <td width='175'>
										 <input type="text"   >
										 	<xsl:if test="$auth_level &lt; 3 and (@prop_id = 15 or @prop_id = 16)">
												<xsl:attribute name="readonly" />
											</xsl:if>
										 	<xsl:if test="$auth_level = 3 and @prop_id = 15 and /myedbroot/record/@type_id = 1">
												<xsl:attribute name="readonly" />
											</xsl:if>
										 <xsl:attribute name="id" >
											<xsl:value-of select="@ffi"/>
										 </xsl:attribute>
										 <xsl:attribute name="name" >
											<xsl:value-of select="@ffi"/>
										 </xsl:attribute>
										 <xsl:attribute name="value">
											<xsl:value-of select="value"/>
										 </xsl:attribute>
										 </input>
										 </td>
									 </xsl:for-each>
										 <td>
										 <xsl:if test="@epi &gt; 0">
											<input type="checkbox" name="groups_to_delete[]" >
												<xsl:attribute name="value">pgid<xsl:value-of select="@prop_group_id"/>rid<xsl:value-of select="@ron" />
												</xsl:attribute>
											</input> Delete? 
										</xsl:if>
										</td>
									</tr>
							 </table>
							 </div>
						 </td>
					</tr>
				</xsl:for-each>
	</table>
</td></tr>

</xsl:template>
</xsl:stylesheet>