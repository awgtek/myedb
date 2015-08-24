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
<xsl:param name="btn_sub" />
<xsl:template name="pagecontent">
		      <div class="bodytext2">

				<label style="font-size:14px; background-color:#FF9999">
					<xsl:if test="$btn_sub = 'Delete Member'">Member Deleted!</xsl:if>
					<xsl:if test="$btn_sub = 'Approve Member'">Member is now active</xsl:if>
				</label>
<xsl:if test="string-length(normalize-space(/myedbroot/record/property[@prop_id='7']/value)) != 0">
	 <form method="post" action="">
	 			<input type="hidden" name="target_component[]" value="RecordIniFacade" />
				<input type="hidden" name="target_function[]" value="update_record" />
	 			<input type="hidden" name="target_component[]" value="SecurityOperationsFacade" />
				<input type="hidden" name="target_function[]" value="send_user_activation_email" />
			 	<input type="hidden" name="target_component[]" value="RecordIniFacade" />
				<input type="hidden" name="target_function[]" value="initialize" />
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
			<!--	<input type="hidden" name="output_function" value="edit_person" />-->
	 <table border="0" width="100%">
	 	<tr><td> </td>
			<td rowspan="10">    
			  </td>
		</tr>
	 <xsl:apply-templates select="/myedbroot/record" /><!--note: password template in /include/output_templates.xsl (see /include/templates/PersonEditor/record_admin-->
	 </table>
	 
	 <xsl:variable name="password_field_id" select="/myedbroot/record/property[@prop_id=8]/@ffi" />
	 <xsl:variable name="email_field_id" select="/myedbroot/record/property[@prop_id=55]/@ffi" />
	 <xsl:variable name="userid_field_id" select="/myedbroot/record/property[@prop_id=7]/@ffi" />
	 <input class="formbuttons" type="submit" id="btn_sub" name="btn_sub" >
					<xsl:attribute name="value">Approve Member</xsl:attribute>
	</input>

	<!--<input type="reset" id="btn_res" name="btn_res" value="Reset" />-->
	 </form><br />
		<form method="post" action="">
			<input type="hidden" name="target_component[]" value="RecordIniFacade" />
			<input type="hidden" name="target_function[]" value="delete_record" />
			 	<input type="hidden" name="target_component[]" value="RecordIniFacade" />
				<input type="hidden" name="target_function[]" value="initialize" />
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
			
			<input class="formbuttons" type="submit" name="btn_sub" value="Delete Member"  onclick="return confirm('Are you sure you want to delete?')" />
					
		
		</form>
</xsl:if>	 
	 </div>
</xsl:template>
</xsl:stylesheet>