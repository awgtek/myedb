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
  <!--<script type="text/javascript" src="/server.php?client=all"></script>-->

		      <div id="public_center_content" class="bodytext2">


<table width="100%" border="0">
  <tr>
    <td width="21%"></td>
    <td width="79%"></td>
  </tr>
  <tr>
    <td valign="top">
	<center>        
		<div id="target">Searching</div>
		</center>
<!--			<xsl:call-template name="show_search_results" />-->
		<div id="searchresultsdiv" ></div>
<!--				jQuery.getJSON("http://api.flickr.com/services/feeds/photos_public.gne?tags=cat&amp;tagmode=any&amp;format=json&amp;jsoncallback=?",
        function(data){
          jQuery.each(data.items, function(i,item){
            jQuery("<img/>").attr("src", item.media.m).appendTo("#images");    div.html(i+"ha");
            if ( i == 3 ) return false;
          });
        });
-->

    </td>
  </tr>
  <tr>
    <td></td>
    <td></td>
  </tr>
</table>
		</div>
		<xsl:call-template name="pub_search_res_div" />
		
</xsl:template>
</xsl:stylesheet>