<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet  [
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
<xsl:output method="html" encoding="utf-8"/>
<xsl:template  name="pub_search_res_div">
	<div id="pub_search_res_div"> 
			<script>
				function submit_subcat_search(subcatid)
				{
							jQuery('#subcatspv').val(subcatid); 
							jQuery("#searchform").submit();
							return false;
				}
				function submit_cat_search(catid)
				{
							jQuery(jq("spv[]") +" option[value="+catid+"]").attr("selected",true); 
							jQuery("#searchform").submit();
							return false;
				}
			</script>
<div class="friends">
<br />	<label class="lbl_cat_title" /> <a href="javascript:submit_cat_search" id="cat_ahref_id" class="cat_ahref"></a> 
<br /><br /><label class="lbl_subcat_title" />  	
</div>
		<div id="pub_search_res_div_msg"></div>

	<div class="dir_search_div">
			<ol id="listcols" class="subcatsol">
				<li>	  <A class="subcatahref" href="javascript:submit_subcat_search"  	>
						</A> 
				</li>
			</ol>
		</div>
	</div>
</xsl:template>
</xsl:stylesheet>