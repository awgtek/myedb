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
<xsl:include href="../include/page_parts/output_msg.xsl"/>
<xsl:output method="html" encoding="iso-8859-1" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>
<xsl:template match="/">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<script type="text/javascript" src="/myedb/includes/md5.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/>
<title>Login Page</title>

<script>
	function request_js_password_reset()
	{
			var emailfilter = /^([a-zA-Z0-9_.-])+@(([a-zA-Z0-9-])+.)+([a-zA-Z0-9]{2,4})+$/;
		var noblank = new RegExp('\\S+');
		if (!noblank.exec(document.getElementById('pi7epi0ron0').value))
		{
			alert ("User ID (Email address) cannot be blank");
			return false;
		}
		if (!emailfilter.test(document.getElementById('pi7epi0ron0').value)) {
			alert('Please provide a valid email address');
			document.getElementById('pi7epi0ron0').focus
			return false;
		}		
	
		//document.getElementById('pi8epi0ron0').value = hex_md5(document.getElementById('pi8epi0ron0').value);


		HTML_AJAX.replace('user_reg_msg', 'index.php?target_component[]=SecurityOperationsFacade&amp;target_function[]=forgot_password&amp;OF_passthru=output_msg&amp;pi7epi0ron0=' + document.getElementById('pi7epi0ron0').value 
		
		);
		/*if (document.getElementById('user_reg_msg').innerText == "Registration Successful!")
		{
			alert("Thank you for registering. When you have received confirmation by email from New England Trade, you may then log in.");
		}
		alert(document.getElementById('user_reg_msg').innerText);*/
		//alert ('yo');
		//return false;
		//return true;
	}
	
</script>
</head>

<body>
  <script type="text/javascript" src="/server.php?client=all"></script>


<h2>Request Password Reset:</h2>

<table border="1"><tr><td valign="top"><p>Please enter your login id (your email address).</p>
<form method="post" action="">

	Email address: <input type="text" id="pi7epi0ron0" name="pi7epi0ron0" value=""/><br />
	<input type="submit" name="Submit"  value="Submit" onclick="request_js_password_reset(); return false; "/>

</form>
<div id="user_reg_msg"></div>
</td>
</tr>
</table>
<p><b>
<!--<xsl:apply-templates select="/myedb_user_access/errormsg"/>-->
</b></p>
<p>&nbsp;</p>

</body>
</html>
</xsl:template>

</xsl:stylesheet>