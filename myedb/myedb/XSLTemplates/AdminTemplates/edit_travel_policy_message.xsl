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
<xsl:include href="../include/templates/generic/property.xsl"/>
<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>
<xsl:param name="btn_sub" />

<xsl:template match="/">
<xsl:apply-templates select="/myedbroot/record" />
</xsl:template>

<xsl:template match="record">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>Untitled Document</title>
	<SCRIPT language="JavaScript" >
		<xsl:attribute name="src"><xsl:value-of select='$app_root_client' />/thirdparty/scriptaculous/lib/prototype.js</xsl:attribute>
	</SCRIPT>
	<script  language="javascript">
		<xsl:attribute name="src"><xsl:value-of select='$app_root_client' />/js/ajaxpost.js</xsl:attribute>
	</script>
	<script language="javascript">
		function eto_get(textfield) {
		  var poststr = "target_component[]=RecordIniFacade&amp;target_function[]=update_record&amp;output_function=do_nothing&amp;"+
				 'rec_eid=<xsl:value-of select="@eid"/>&amp;rec_type_id=<xsl:value-of select="@type_id"/>&amp;'
		  				+textfield+"=" + encodeURIComponent(document.getElementById(textfield).value ) ;// alert(poststr);
		  makePOSTRequest('index.php', poststr);
	   }
	</script>
	<script type="text/javascript" >
		<xsl:attribute name="src"><xsl:value-of select='$app_root_client' />/thirdparty/fckeditor_dir/fckeditor/fckeditor.js</xsl:attribute>
	</script>
<script type="text/javascript">
window.onload = function()
{
var oFCKeditor = new FCKeditor( '<xsl:value-of select="property[@prop_id=2]/@ffi"/>' ) ;
oFCKeditor.BasePath = "<xsl:value-of select='$app_root_client' />/thirdparty/fckeditor_dir/fckeditor/" ;
oFCKeditor.Config["CustomConfigurationsPath"] = "<xsl:value-of select='$app_root_client' />/thirdparty/fckeditor_dir/myconfig.js?" + ( new Date() * 1 ) ;
oFCKeditor.Height	= 400 ;
oFCKeditor.ReplaceTextarea() ;
}
</script>

	<style>
	
	.example {	
	padding: 0 20px;
	float: left;		
	width: 230px;
}

.wrapper {
	width: 133px;
	/* Centering button will not work, so we need to use additional div */
	margin: 0 auto;
}

div.button {
	height: 29px;	
	width: 133px;
	background: url(button.png) 0 0;
	
	font-size: 14px;
	color: #C7D92C;
	text-align: center;
	padding-top: 15px;
}
/* 
We can't use ":hover" preudo-class because we have
invisible file input above, so we have to simulate
hover effect with javascript. 
 */
div.button.hover {
	background: url(button.png) 0 56px;
	color: #95A226;	
}
</style>
</head>

<body>
		      <div class="bodytext2">
			  <form  name="myform" id="myform">
			  		<xsl:attribute name="action">javascript:eto_get('<xsl:value-of select="property[@prop_id=2]/@ffi"/>');
					</xsl:attribute>
					 <xsl:apply-templates select="property[@prop_id=2]" mode="in_textarea_descrip_in_param"/><!--site message text-->
					 <input type="submit" name="button" value="Submit Text"/>

			  </form>
			  
				Server-Response:<br />
				<hr />
				<span name="myspan" id="myspan"></span>
				<hr />

		</div>

</body>
</html>

</xsl:template>
</xsl:stylesheet>