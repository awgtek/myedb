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
<xsl:template name="pagecontent">
		      <div class="bodytext2">

  <script type="text/javascript" src="/server.php?client=all"></script>
		<center>  
		<table width="100%" cellpadding="0"       cellspacing="0"><tr><td>
		<div id="target">Searching</div>
		</td><td>
		sort by: 
		<xsl:if test="$type_id = 4" >
			<a href="javascript:revealDiv_online('date_added');">Date Added</a> <xsl:text> </xsl:text> 
			<a href="javascript:revealDiv_online('approved');">Order Status</a> <xsl:text> </xsl:text> 
			<a href="javascript:revealDiv_online('acct_no');">Account #</a> <xsl:text> </xsl:text> 
		</xsl:if>
		<xsl:if test="$type_id != 4" >
			<a href="javascript:revealDiv_online('date_added');">Date Added</a> <xsl:text> </xsl:text> 
			<a href="javascript:revealDiv_online('hc_status');">Order Status</a> <xsl:text> </xsl:text> 
			<a href="javascript:revealDiv_online('n_order_id');">Order Number</a> <xsl:text> </xsl:text> 
			<a href="javascript:revealDiv_online('n_co_acctno');">Account #</a> <xsl:text> </xsl:text> 
			<a href="javascript:revealDiv_online('n_prod_name');">Product Name</a> <xsl:text> </xsl:text> 
			<a href="javascript:revealDiv_online('n_co_name');">Customer Name</a> <xsl:text> </xsl:text> 
			<a href="javascript:revealDiv_online('prodrefno');">Ref#</a> <xsl:text> </xsl:text> 
		</xsl:if>	
			Ascending? <input type="checkbox" onclick="javascript:set_sort_order()" id="chk_sort_order_change"/>
		</td></tr></table>
				  

		
		</center>
			
			<div id="order_history_page_div">
			</div>

</div>
</xsl:template>
</xsl:stylesheet>