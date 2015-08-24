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
<!--place in head tag-->
<xsl:template name="validate_complete_form">

  <style rel="stylesheet" type="text/css">
body, p, td, li, h1, h2, h3 { font-family: "Lucida Grande", Verdana, Arial, Helvetica, Geneva, sans-serif; }
body, p, td, li, h2, h3     { font-size: 12px; }
h2, h3    { font-weight: bold; color:#323777; margin-bottom: 11px; }
h1          { font-size:16px; font-weight: bold; color:#DB3259; margin-bottom: 3px; }
h2, h3      { margin-top: 17px;  }

.header     { font-weight: bold; color:#323777; margin-bottom: 11px; }
.headline  { font-weight: bold; color:#323777; }

p           { margin-top: 14px; }

a           { text-decoration: none; color:#323788; }
a:hover     { text-decoration: underline;           }
a.nav       { text-decoration: none; color:#000000; }
a.nav:hover { text-decoration: underline;           }

pre         { font-family:Courier New, Courier, monospace; font-size:12px; }
ul          { list-style-type: square; margin-top: 2px;        }

td.header   { color: #FFFFFF; background-color:#323777; }
td.cell     { background-color:#FFFFFF; }

input, select    { border: 1px solid silver; }
input.error, select.error {padding-right: 16px; border: 1px solid red; background-color: #FFFCE2; background-image: url(validateimages/warning_obj.gif); background-position: right; background-repeat: no-repeat;}
input:focus, select:focus {border: 1px solid red; background-color:#EFEFEF;}
.mandatory  { font-weight: bold; }
.comment    { color: #BBBBBB; }

  </style>
    <script language="javascript" >
		<xsl:attribute name="src"><xsl:value-of select='$app_root_client' />/includes/js/form_validation/validate_complete.js</xsl:attribute>
    </script>


</xsl:template>
</xsl:stylesheet>