<?xml version="1.0" encoding="iso-8859-1"?><!DOCTYPE xsl:stylesheet  [
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
<xsl:include href="../include/output_templates.xsl"/>
<xsl:include href="../include/page_parts/output_msg.xsl"/>
<xsl:include href="../include/head_includes.xsl"/>
<xsl:include href="../include/templates/generic/property.xsl"/>
<xsl:include href="../include/templates/PersonEditor/property.xsl"/>

<xsl:output method="html" encoding="iso-8859-1" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>
<xsl:param name="btn_sub" />
<xsl:template match="/">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<script type="text/javascript" src="/myedb/includes/md5.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/>
<title>Login Page</title>

		<xsl:call-template name="head_include_tags" />

</head>

<body>
  <script type="text/javascript" src="/server.php?client=all"></script>


<h2>Reset Password:</h2>

<table border="1"><tr><td valign="top">
<form method="post" action="index.php">
<input type="hidden" name="target_component[]" value="SecurityOperationsFacade"/>
<input type="hidden" name="target_function[]" value="check_activation_password"/>
<input type="hidden" name="target_component[]" value="RecordIniFacade" />
<input type="hidden" name="target_function[]" value="update_record" />
<input type="hidden" name="activate" >
	<xsl:attribute name="value" ><xsl:value-of select="$activate" /></xsl:attribute>
</input>
<input type="hidden" name="id" >
	<xsl:attribute name="value" ><xsl:value-of select="$id" /></xsl:attribute>
</input>	<!--		 	<input type="hidden" name="target_component[]" value="RecordIniFacade" />
				<input type="hidden" name="target_function[]" value="initialize" />-->
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
				<!--<input type="hidden" name="output_function" value="edit_person_member" />-->
				<label style="font-size:14px; background-color:#FF9999">
					<xsl:if test="$btn_sub = 'Insert Record'">Record Inserted!</xsl:if>
					<xsl:if test="$btn_sub = 'Submit'">Record Updated!<br /></xsl:if>
				</label>
	Email address (for login): <xsl:value-of select="/myedbroot/record/property[@prop_id=7]/value" /><br />
<table>
				 <xsl:apply-templates select="/myedbroot/record/property[@prop_id=8]" mode="hidden_input_field" /><!--password-->
				<xsl:apply-templates select="/myedbroot/record/property[@prop_id=8]" mode="password_check_and_append" /><!--password -->
			</table>
	 <xsl:variable name="password_field_id" select="/myedbroot/record/property[@prop_id=8]/@ffi" />
	 <xsl:variable name="email_field_id" select="/myedbroot/record/property[@prop_id=55]/@ffi" />
	 <xsl:variable name="userid_field_id" select="/myedbroot/record/property[@prop_id=7]/@ffi" />
	 <input class="formbuttons" type="submit" id="btn_sub" name="btn_sub" >
					<xsl:attribute name="value">Submit</xsl:attribute>
	 	<xsl:attribute name="onclick">
 	<xsl:variable name="pswd_id"><xsl:value-of select="$pswd_prefix"/><xsl:value-of select="/myedbroot/record/property[@prop_id=8]/@ffi"/></xsl:variable>
  	<xsl:variable name="pswd_chk_id"><xsl:value-of select="$pswd_chk_prefix"/><xsl:value-of select="/myedbroot/record/property[@prop_id=8]/@ffi"/></xsl:variable>
		var noblank = new RegExp('\\S+');
		if (!noblank.exec(document.getElementById('<xsl:value-of select="$pswd_id" />').value))
		{
			alert ("password cannot be blank");
			return false;
		}

		if (!check_password_equality()) { alert("Passwords must match!"); return false;} 
		if (!check_password_validity()) { alert("Passwords must have at least one letter and one number and be at least six characters!"); return false;} 
		if ( (document.getElementById('<xsl:value-of select="$pswd_id" />').value.length!=0) &amp;&amp; (document.getElementById('<xsl:value-of select="$pswd_chk_id" />').value.length!=0) )
		{
			document.getElementById('<xsl:value-of select="$password_field_id" />').value = hex_md5(document.getElementById('<xsl:value-of select="$pswd_chk_id" />').value);
	//		alert('pass ' + document.getElementById('<xsl:value-of select="$password_field_id" />').value);
	//		alert('hex ' + hex_md5(document.getElementById('<xsl:value-of select="$pswd_chk_id" />').value));
	
			alert("Password is reset!"); return true;
		};
		//	alert(document.getElementById('<xsl:value-of select="$userid_field_id" />').value);
	//	return validate_inputs();
		</xsl:attribute>
	</input>

</form>
<div id="user_reg_msg"></div>
</td>
</tr>
</table>
<p><b>
<xsl:apply-templates select="errormsg"/>
</b></p>
<p>&nbsp;</p>

</body>
</html>
</xsl:template>

</xsl:stylesheet>