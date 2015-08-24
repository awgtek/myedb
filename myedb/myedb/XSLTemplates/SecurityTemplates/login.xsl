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
<xsl:output method="html" encoding="iso-8859-1" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>
<xsl:template match="/">
	<xsl:apply-templates />
</xsl:template>

<xsl:template match="login_form">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<script type="text/javascript" src="/myedb/includes/md5.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/>
<title>Login Page</title>

<script language="javascript">
	function register_user()
	{
			var passvalidre = /^.*(?=.{6,})(?=.*\d)(?=.*[A-Za-z]).*$/;
			var emailfilter = /^([a-zA-Z0-9_.-])+@(([a-zA-Z0-9-])+.)+([a-zA-Z0-9]{2,4})+$/;

		var noblank = new RegExp('\\S+');
		if (!noblank.exec(document.getElementById('pi7epi0ron0').value))
		{
			alert ("User ID cannot be blank");
			return false;
		}
		if (!emailfilter.test(document.getElementById('pi7epi0ron0').value)) {
			alert('Please provide a valid email address');
			document.getElementById('pi7epi0ron0').focus
			return false;
		}		
		if (!noblank.exec(document.getElementById('pi8epi0ron0').value))
		{
			alert ("Password cannot be blank");
			return false;
		}
		if (!passvalidre.exec(document.getElementById('pi8epi0ron0').value))
		{
			alert ("Password must have a letter, a number, and be greater than 6 characters");
			return false;
		}
		if ( document.getElementById('pi8epi0ron0').value != document.getElementById('pi8epi0ron0_chk').value )
		{
			alert("Passwords do not match!");
			return false;
		}
	
		//document.getElementById('pi8epi0ron0').value = hex_md5(document.getElementById('pi8epi0ron0').value);


		HTML_AJAX.replace('user_reg_msg', 'index.php?target_component[]=SecurityOperationsFacade&amp;target_function[]=register_user&amp;output_function=output_process_result&amp;acctno=' + 
		document.getElementById('acctno').value + '&amp;pi8epi0ron0=' + document.getElementById('pi8epi0ron0').value 
		+ '&amp;pi7epi0ron0=' + document.getElementById('pi7epi0ron0').value 
		+ '&amp;pi9epi0ron0=' + document.getElementById('pi9epi0ron0').value 
		+ '&amp;pi36epi0ron0=' + document.getElementById('pi36epi0ron0').value 
		+ '&amp;pi65epi0ron0=' + document.getElementById('pi65epi0ron0').value 
		+ '&amp;pi11epi0ron0=' + document.getElementById('pi11epi0ron0').value 
		+ '&amp;pi55epi0ron0=' + document.getElementById('pi7epi0ron0').value 
		
		);
		clear_password_fields();
		/*if (document.getElementById('user_reg_msg').innerText == "Registration Successful!")
		{
			alert("Thank you for registering. When you have received confirmation by email from New England Trade, you may then log in.");
		}
		alert(document.getElementById('user_reg_msg').innerText);*/
		//alert ('yo');
		//return false;
		//return true;
	}
	
	function clear_password_fields()
	{
		document.getElementById('pi8epi0ron0').value = "";
		document.getElementById('pi8epi0ron0_chk').value = "";
	}
</script>
</head>

<body>
  <script type="text/javascript" src="/server.php?client=all"></script>


<h2>Login:</h2>

<table border="1"><tr><td valign="top"><p>Please enter your login and password.</p>
<form name="form1" method="post" action='index.php'>
	<input type="hidden" name="target_component" value="SecurityOperationsFacade" /><!-- used only to indicate login page in SecurityOperationsMain. defaults to security check in Main-->
	<input type="hidden" name="target_function" value="process_login" />
  <label for="login">Login:</label>
  <input type="text" name="login" size="20" >
  	<xsl:attribute name="value">
		<xsl:value-of select="login"/>
	</xsl:attribute>
  </input>
  <br />
  <label for="password">Password:</label>
  <input type="password" name="password" size="8" >
  	<xsl:attribute name="value">
		<xsl:value-of select="password"/>
	</xsl:attribute>
  </input>
  <br />
  <label for="remember">Automatic login?</label>
  <input type="checkbox" name="remember" checked="checked" value="yes" />
  <br />
  <input type="submit" name="Submit" value="Login"/>
  <br />
  <a href="index.php?ntctf=1&amp;OF_passthru=request_new_password">Reset Password</a>
</form>
</td><td valign="top">Register:
<form method="post" action="index.php">

	First Name: <input type="text" id="pi9epi0ron0" name="pi9epi0ron0" value=""/><br />
	Last Name: <input type="text" id="pi36epi0ron0" name="pi36epi0ron0" value=""/><br />
	Business Name: <input type="text" id="pi65epi0ron0" name="pi65epi0ron0" value=""/><br />
	Phone Number: <input type="text" id="pi11epi0ron0" name="pi11epi0ron0" value=""/><br />
	Account Number: <input type="text" name="acctno" id="acctno" /><br />
	Email address (for login): <input type="text" id="pi7epi0ron0" name="pi7epi0ron0" value=""/><br />
	Password: <input type="password" id="pi8epi0ron0" name="pi8epi0ron0" value=""/><br />
	Retype Password: <input type="password" id="pi8epi0ron0_chk" name="pi8epi0ron0_chk" value=""/><br />
	<input type="submit" name="Submit"  value="Register" onclick="register_user(); return false; "/>

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
<xsl:template match="errormsg">
	<xsl:value-of select="."/>
</xsl:template>
</xsl:stylesheet>