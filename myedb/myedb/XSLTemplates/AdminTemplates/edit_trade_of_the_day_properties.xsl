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
		  				+textfield+"=" + encodeURI( document.getElementById(textfield).value ) ; //alert(poststr);
		  makePOSTRequest('index.php', poststr);
	   }
	</script>
<script language="javascript">
function init() {// alert('hello');
	document.getElementById('file_upload_form').onsubmit=function() {
		document.getElementById('file_upload_form').target = 'upload_target'; //'upload_target' is the name of the iframe
	}
}
window.onload=init;
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
			  		<xsl:attribute name="action">javascript:eto_get('<xsl:value-of select="property[@prop_id=60]/@ffi"/>');
					</xsl:attribute>
					 <xsl:apply-templates select="property[@prop_id=60]" mode="in_textarea"/><!--Trade of the day text-->
					 <input type="submit" name="button" value="Submit Text"/>

			  </form>
			  
			 <form method="post" action="index.php" enctype="multipart/form-data" id="file_upload_form">
			 	<input type="hidden" name="target_component[]" value="RecordIniFacade" />
				<input type="hidden" name="target_function[]" value="update_record" />
			 	<input type="hidden" name="target_component[]" value="RecordIniFacade" />
				<input type="hidden" name="target_function[]" value="initialize" />
				<input type="hidden" name="height" value="400" />
				<input type="hidden" name="width" value="600" />
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
				<input type="hidden" name="output_function" value="do_nothing" />
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
				<label style="font-size:14px; background-color:#FF9999">
					<xsl:if test="$btn_sub = 'Insert Record'">Record Inserted!</xsl:if>
					<xsl:if test="$btn_sub = 'Update Record'">Record Updated!</xsl:if>
				</label>

		 
		  <table border="0"  cellpadding="0" cellspacing="0" width="100%">
		  	<tr>
			<!--    <td width="7" rowspan="31" style="background-image:url(images/green.jpg)">&#160;</td>-->

				<td align="left">
				<table>
				<xsl:apply-templates select="property[@prop_id=61]" mode="image_link" /><!--trade of the day image-->
			<!--		<tr>
						<td>
				<xsl:apply-templates select="property[@prop_id=61]"/>
						</td>
					</tr>-->
					<tr>
						<td>
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
				</input>
						</td>
					</tr>
				</table>
			 	</td>
			</tr>
		</table>
<iframe id="upload_target" name="upload_target" src="" style="width:20;height:20;border:0px solid #fff;"></iframe>
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