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
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:pl="urn:myedb:propertylist" xmlns:exslt="http://exslt.org/common">
<xsl:include href="../include/page_sections/leftnavdiv.xsl"/>
<xsl:include href="../include/page_sections/topstripdiv.xsl"/>
<xsl:include href="pageframe2.xsl" />
<xsl:include href="PageContents/show_order_details_pgct.xsl" />
<xsl:include href="../include/head_includes.xsl"/>
<xsl:include href="OutputParts/details_xml_one_time_user_address.xsl"/>
<!--<xsl:include href="order_history_table.xsl" />-->
<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>
<!--<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>-->
<xsl:template match="/">
<html >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>Edit Order Details</title>
<style type="text/css" media="screen">
  .inplaceeditor-saving { background: url(/images/_radr.gif) bottom right no-repeat; }
</style>


<script type="text/javascript">
	// initialize XMLHttpRequest object
	var xmlobj=null;
	var data=new Array();
	var ctlobj;
	// send http request
		function handle_order_approved_change(selectobj, order_id)
		{
			//alert('ischecked? ' + obj.checked + ' value: ' + obj.value);
			var apprv_stat = selectobj.value;
			ctlobj = selectobj;
			var target_function;
			var url;
			target_function = "set_approval_status";
			
			url = '?target_component[]=TransMgmtFacade&amp;target_function[]=' + target_function + '&amp;OF_passthru=no_xslt_processing&amp;order_id='+order_id+'&amp;status_value='+apprv_stat;
			
			// check for existing requests
			if(xmlobj!=null &amp;&amp; xmlobj.readyState!=0&amp;&amp;xmlobj.readyState!=4){
				xmlobj.abort();
			}
			try{
				// instantiate object for Mozilla, Nestcape, etc.
				xmlobj=new XMLHttpRequest();
			}
			catch(e){
				try{
					// instantiate object for Internet Explorer
					xmlobj=new ActiveXObject('Microsoft.XMLHTTP');
				}
				catch(e){
					// Ajax is not supported by the browser
					xmlobj=null;
  					alert("Your browser does not support XMLHTTP.");
					return false;
				}
			}
			//disable temporarily, will be reenabled by onreadystatechange event handler
			selectobj.disabled = true;
			// assign state handler
			xmlobj.onreadystatechange=stateChecker;
			// open socket connection
			xmlobj.open('GET',url,true);
			// send GET request
			xmlobj.send(null);
		}
		// check request status
		function stateChecker(){
			// if request is completed
			if(xmlobj.readyState==4){
				// if status == 200 display text file
				if(xmlobj.status==200){
					// create data container
					//createDataContainer();
					// read XML data
					//data=xmlobj.responseXML.getElementsByTagName('message');
		 // display XML data
					displayData();
					ctlobj.disabled = false;
					//alert("hello");
				}
				else{
					alert('Failed to get response :'+ xmlobj.statusText);
				}
			}
		}
		function displayData(){ //alert(xmlobj.responseText);
			data=xmlobj.responseXML.getElementsByTagName('medborder_sas');

			// reset data container
			document.getElementById('status_change_message').innerHTML='';
			if (data[0].firstChild.nodeValue == 1)
			{
				document.getElementById('status_change_message').appendChild(document.createTextNode("status change complete"));
			}
		}
		function grabCallback_FixFeaturedCheckboxes(result)
		{
			if (result==1)//max_featured_reached
			{
				alert("Maximum featured items reached. Uncheck featured items before adding new featured items.");
				disableCheckbox(document.getElementsByName("featured_entity"),true);//name of checkboxes on search_records.xsl
			}
			else
			{
				disableCheckbox(document.getElementsByName("featured_entity"),false);//name of checkboxes on search_records.xsl
			}
		}
		function disableCheckbox(checkbox, disable) {
		  var max = checkbox.length;
		  for (var i=0; i &lt; max; i++) {
		  	if (!checkbox[i].checked)
			{
				checkbox[i].disabled = disable;
			}
		  }
		}

	</script>
		<xsl:call-template name="head_include_tags" />
</head>
<body>
		<xsl:call-template name="pageframe">
		</xsl:call-template>
</body>
</html>

</xsl:template>
	  <xsl:template name="page_frame_2_title">
		Order Details
		</xsl:template>

</xsl:stylesheet>