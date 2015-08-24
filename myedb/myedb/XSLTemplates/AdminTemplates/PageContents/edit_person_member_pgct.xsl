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

	 <form method="post" action=""><input type="hidden" name="target_component[]" value="RecordIniFacade" />
<input type="hidden" name="target_function[]" value="update_record" />
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
				<input type="hidden" name="output_function" value="edit_person_member" />
				<label style="font-size:14px; background-color:#66FF00">
					<xsl:if test="$btn_sub = 'Insert Record'">Record Inserted!</xsl:if>
					<xsl:if test="$btn_sub = 'Update Record'">Record Updated!</xsl:if>
				</label>

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
					<xsl:attribute name="value"><xsl:if test="$eid = 0">Insert Record</xsl:if><xsl:if test="$eid &gt; 0">Update Record</xsl:if>
					</xsl:attribute>
	 	<xsl:attribute name="onclick">
 	<xsl:variable name="pswd_id"><xsl:value-of select="$pswd_prefix"/><xsl:value-of select="/myedbroot/record/property[@prop_id=8]/@ffi"/></xsl:variable>
  	<xsl:variable name="pswd_chk_id"><xsl:value-of select="$pswd_chk_prefix"/><xsl:value-of select="/myedbroot/record/property[@prop_id=8]/@ffi"/></xsl:variable>
		if (!check_password_equality()) { alert("Passwords must match!"); return false;} 
		if (!check_password_validity()) { alert("Passwords must have at least one letter and one number and be at least six characters!"); return false;} 
		if ( (document.getElementById('<xsl:value-of select="$pswd_id" />').value.length!=0) &amp;&amp; (document.getElementById('<xsl:value-of select="$pswd_chk_id" />').value.length!=0) )
		{
			document.getElementById('<xsl:value-of select="$password_field_id" />').value = hex_md5(document.getElementById('<xsl:value-of select="$pswd_chk_id" />').value);
//			alert('pass ' + document.getElementById('<xsl:value-of select="$password_field_id" />').value);
	//		alert('hex ' + hex_md5(document.getElementById('<xsl:value-of select="$pswd_chk_id" />').value));
	
			
		};
			document.getElementById('<xsl:value-of select="$email_field_id" />').value = document.getElementById('<xsl:value-of select="$userid_field_id" />').value;
		//	alert(document.getElementById('<xsl:value-of select="$userid_field_id" />').value);
		return validate_inputs();
		</xsl:attribute>
	</input>
	<!--<input type="reset" id="btn_res" name="btn_res" value="Reset" />-->
	 </form>
	 
	 </div>
</xsl:template>
</xsl:stylesheet>