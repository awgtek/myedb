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
<xsl:include href="../../include/templates/RecordEditor/record_editor_top.xsl" />
<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>

<xsl:param name="btn_sub" />

<xsl:template name="pagecontent">

		      <div class="bodytext2">
			 <form method="post" action="index.php" enctype="multipart/form-data">
			 	<input type="hidden" name="target_component[]" value="RecordIniFacade" />
				<input type="hidden" name="target_function[]" value="update_record" />
			 	<input type="hidden" name="target_component[]" value="RecordIniFacade" />
				<input type="hidden" name="target_function[]" value="initialize" />
				<!--NOTE! output function is in template record-->
				<input type="hidden" name="eid">
					<xsl:attribute name="value">
						<xsl:value-of select="$eid"/>
					</xsl:attribute>
				</input>
				<input type="hidden" name="type_id" >
					<xsl:attribute name="value">
						<xsl:value-of select="$type_id"/>
					</xsl:attribute>
				</input>
				<label style="font-size:14px; background-color:#FF9999">
					<xsl:if test="$btn_sub = 'Insert Record'">Record Inserted!</xsl:if>
					<xsl:if test="$btn_sub = 'Update Record'">Record Updated!</xsl:if>
				</label>

		 <table width="100%" border="1" bordercolor="#999999" cellspacing="0"  cellpadding="0">
		 <tr style="background-image:url(/images/green.jpg);">
		 <td>
		 <table width="100%"><tr><td width="70%">
			 <div align="left" style="padding-left:8px;"><strong>Edit Product:</strong></div>
		 
		 </td><td nowrap="nowrap">
		 				&nbsp;Date Last Modified/User (No.): <xsl:value-of select="$date_last_modified" /> / <xsl:value-of select="$user_last_modified" /><br />
				&nbsp;Date Added/User (No.): <xsl:value-of select="$date_added" /> / <xsl:value-of select="$user_added" />

		 </td></tr></table>
		 
		 <xsl:call-template name="record_editor_top" />
		 
		 </td>
	<!--	 <td class="background"><a >
		  	<xsl:attribute name="href">index.php?target_component%5B%5D=RecordIniFacade&amp;target_function%5B%5D=get_record_history_page_xml&amp;eid=<xsl:value-of select="$eid"/>&amp;type_id=<xsl:value-of select="$type_id"/>&amp;OF_passthru=show_record_history</xsl:attribute>Product history</a> 
			| 
			<a>
				<xsl:attribute name="href">index.php?target_component%5B%5D=TransMgmtFacade&amp;target_function%5B%5D=get_product_order_history_page_xml&amp;eid=<xsl:value-of select="$eid"/>&amp;OF_passthru=show_order_history</xsl:attribute>
				Order History
			</a>
		</td>
		<td class="background">
			Quick Link: /index.php?pl=<xsl:value-of select="$eid"/>

		</td>-->
		 </tr>
		 </table>
		  <table border="0"  cellpadding="0" cellspacing="0" width="100%">
		  	<tr>
			<!--    <td width="7" rowspan="31" style="background-image:url(images/green.jpg)">&#160;</td>-->

				<td align="left">

			 	<table border="0" cellpadding="0" cellspacing="0" width="100%">
			 		<xsl:apply-templates select="myedbroot/record" />
			 	</table>
				<!--<input type="reset" id="btn_res" name="btn_res" value="Reset" />-->
				<input class="formbuttons" type="submit" id="btn_sub" name="btn_sub" >
					<xsl:choose>
						<xsl:when test="$auth_level = 1">
							 <xsl:attribute name="disabled">
							 </xsl:attribute>
						</xsl:when>
						<xsl:otherwise>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:attribute name="value"><xsl:if test="$eid = 0">Insert Record</xsl:if><xsl:if test="$eid &gt; 0">Update Record</xsl:if>
					</xsl:attribute>
					<xsl:attribute name="onclick">
					return validate_inputs();
					</xsl:attribute>
				</input>
			 	</td>
			</tr>
		</table>
			 </form>
		</div>
</xsl:template>
</xsl:stylesheet>