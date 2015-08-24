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
<xsl:include href="validation_script.xsl"/>
<xsl:include href="page_parts/pub_search_res_div.xsl" />
<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>

<xsl:template name="head_include_tags"><link href="/stylesheets/main_style.css" rel="stylesheet" type="text/css" ></link>
<script type="text/javascript">
function staticLoadScript(url)
{
   document.write('&lt;script src="', url, '" type="text/JavaScript"&gt;&lt;\/script&gt;');
}

//staticLoadScript("<xsl:value-of select='$app_root_client' />" + "/thirdparty/scriptaculous/lib/prototype.js");


function dhtmlLoadScriptTop(url)
{
   var e = document.createElement("script");
   e.src = url;
   e.type="text/javascript";
  // document.getElementsByTagName("head")[0].appendChild(e); 
   document.getElementsByTagName("head")[0].insertBefore(e,document.getElementsByTagName("head")[0].firstChild);
}

function dhtmlLoadScript(url)
{
   var e = document.createElement("script");
   e.src = url;
   e.type="text/javascript";
   document.getElementsByTagName("head")[0].appendChild(e); 
  // document.getElementsByTagName("head")[0].insertBefore(e,document.getElementsByTagName("head")[0].firstChild);
}

var scripts_to_load = new Array;
scripts_to_load.push( "/thirdparty/pure-pure-200e10d/libs/prototype.js");
//scripts_to_load.push( "/thirdparty/scriptaculous/lib/prototype.js");
//scripts_to_load.push( "/thirdparty/scriptaculous/src/scriptaculous.js");
scripts_to_load.push( "/thirdparty/scriptaculous-js-1.8.3/src/scriptaculous.js");
scripts_to_load.push( "/thirdparty/scriptaculous-js-1.8.3/src/effects.js");
scripts_to_load.push( "/thirdparty/madrobby-scriptaculous-299f8b9/src/controls.js");
scripts_to_load.push( "/thirdparty/pure-pure-200e10d/libs/pure.js"); //place under prototype.js but before jquery.js to ensure pure loads prototype
scripts_to_load.push( "/js/list_shift.js");
scripts_to_load.push( "/includes/js/page_functions.js");
scripts_to_load.push( "/includes/md5.js");
//scripts_to_load.push( "/thirdparty/jquery/jquery-latest.js");
scripts_to_load.push( "/thirdparty/pure-pure-200e10d/libs/jquery.js");
scripts_to_load.push( "/js/ajaxpost.js");
scripts_to_load.push( "/server.php?client=all");

//var scripts_to_load2 = new Array; //second batch of scripts to load that depend on the first


function load_include_scripts()
{ 
	//for (i=scripts_to_load.length-1; i &gt;= 0; i--)
	for (i=0; i &lt; scripts_to_load.length; i++)
	{
	//   dhtmlLoadScript("<xsl:value-of select='$app_root_client' />" + scripts_to_load[i]);
	   staticLoadScript("<xsl:value-of select='$app_root_client' />" + scripts_to_load[i]); //must use static or else order of files loaded is unpredictable and IE gives errors due to mismatched dependencies among the js files
	}
}

</script> 


<!--	<SCRIPT language="JavaScript" SRC="/myedb/thirdparty/scriptaculous/lib/prototype.js"></SCRIPT>
	<script language="Javascript" src="/thirdparty/scriptaculous/src/scriptaculous.js"> </script>
	<script language="Javascript" src="/thirdparty/scriptaculous/src/effects.js"> </script>
	<script language="Javascript" src="/thirdparty/madrobby-scriptaculous-299f8b9/src/controls.js"> </script> 
	<script language="javascript" src="/js/list_shift.js"  > </script>
	<script language="javascript" src="/includes/js/page_functions.js"  > </script>
	<script type="text/javascript" src="/includes/md5.js"></script>
	-->
	
	<!--<xsl:call-template name="horiz-menu-header-code"/>-->
	<xsl:call-template name="make-validation-script"/>
	<!--<script type="text/javascript" src="/myedb/thirdparty/jquery/jquery-latest.js"></script> -->
  <script>
   </script>
		<!--<script src="/thirdparty/pure/libs/pure2.js"></script>-->
	<script language="javascript">
		//per http://docs.jquery.com/Frequently_Asked_Questions#How_do_I_select_an_element_that_has_weird_characters_in_its_ID.3F
		 function jq(myid)
		  { return '#'+myid.replace(/:/g,"\\:").replace(/\./g,"\\.").replace(/\[/g,"\\[").replace(/\]/g,"\\]");}
	</script>
<script language="javascript">
	/*	String.prototype.trim = function () {
		return this.replace(/^\s*|\s*$/,"");
		}*/
String.prototype.trim = function() {
	return this.replace(/^\s+|\s+$/g,"");
}
</script>
<script>
function TextFieldIsEmpty(aTextField) {
   if ((aTextField.value.length==0) ||
   (aTextField.value==null)) {
      return true;
   }
   else if (aTextField.value.trim()=="")
   {
   		return true;
   }
   else { return false; }
}
// Radio Button Validation
// copyright Stephen Chapman, 15th Nov 2004,14th Sep 2005
// you may copy this function but please keep the copyright notice with it
function valButton(btn) {
    var cnt = -1;
    for (var i=btn.length-1; i > -1; i--) {
        if (btn[i].checked) {cnt = i; i = -1;}
    }
    if (cnt > -1) return btn[cnt].value;
    else return null;
}
             
</script>

	 <!-- <script type="text/javascript" src="/server.php?client=all"></script>-->
<script>

	load_include_scripts();
//     jQuery.noConflict();
window.onload = function()
{
     //jQuery.noConflict(); //NOTE!! doesn't work, must ...noConflict at bottom of referenced jquery.js

//foo(); //test printStackTrace();
}
function foo() {  

    var blah;  

    bar(&quot;blah&quot;);  

}  

   

function bar(blah) {  

    var stuff;  

    thing();  

}  

   

function thing() {  

    if (true) { //your error condition here  

        printStackTrace();  

    }  

}  

   



</script>

</xsl:template>

<xsl:template name="horiz-menu-header-code">
<!--<script type="text/javascript">
window.onload=montre;
function montre(id) {
var d = document.getElementById(id);
	for (var i = 1; i<=10; i++) {
		if (document.getElementById('smenu'+i)) {document.getElementById('smenu'+i).style.display='none';}
	}
if (d) {d.style.display='block';}
}
</script>
-->



</xsl:template>
</xsl:stylesheet>