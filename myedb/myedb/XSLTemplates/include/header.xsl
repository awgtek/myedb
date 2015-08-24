<?xml version="1.0" encoding="iso-8859-1"?>
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
<xsl:output method="html" encoding="iso-8859-1"/>

<xsl:template name="make-header">
  <xsl:param name="value"/>
  <table width="100%" bgcolor="#CC6666"><tr><td>
  
  <br />
      <!--<h1><xsl:value-of select="$value" /></h1>--> <a href="index.php">Home</a>&nbsp;&nbsp;
	  <a href="index.php?target_component%5B%5D=TransMgmtFacade&amp;target_function%5B%5D=get_pending_transactions&amp;output_function=show_pending_transactions">Cart</a>&nbsp;&nbsp;
	  	  <a href="index.php?target_component%5B%5D=RecordIniFacade&amp;target_function%5B%5D=initializeRecordSet&amp;eids[]=4&amp;type_id=1&amp;output_function=admin_paged_content">Editor</a>
    </td></tr></table>
</xsl:template>



<xsl:template name="horiz-menu">
<div id="menu"><i>Adam's work site</i>
	<dl>
		<dt onmouseover="javascript:montre();"><a href="index.php" title="Retour à l'accueil">Home</a></dt>
	</dl>
	
	<dl>			
		<dt onmouseover="javascript:montre('smenu1');" >Cart</dt>
			<dd onmouseover="javascript:montre('smenu1');" id="smenu1" onmouseout="javascript:montre('');">
				<ul>
					<li><a href="index.php?target_component%5B%5D=TransMgmtFacade&amp;target_function%5B%5D=get_pending_transactions&amp;output_function=show_pending_transactions">See Cart</a></li>
			<!--		<li><a href="#">Sous-Menu 1.2</a></li>
					<li><a href="#">Sous-Menu 1.3</a></li>
					<li><a href="#">Sous-Menu 1.4</a></li>
					<li><a href="#">Sous-Menu 1.5</a></li>
					<li><a href="#">Sous-Menu 1.6</a></li>-->
				</ul>
			</dd>
	</dl>
	
	
	<dl>	
		<dt onmouseover="javascript:montre('smenu2');">Edit</dt>
			<dd onmouseover="javascript:montre('smenu2');" id="smenu2" onmouseout="javascript:montre('');">
				<ul>
					<xsl:if test="$auth_level = 10">
						<li><a href="index.php?target_component%5B%5D=RecordIniFacade&amp;target_function%5B%5D=search_by_prop_val_contains&amp;spi=1&amp;spv=&amp;type_id=1&amp;output_function=admin_paged_content">Edit All Products</a></li>
						<li><a href="index.php?target_component%5B%5D=RecordIniFacade&amp;target_function%5B%5D=initialize&amp;eid=0&amp;type_id=1&amp;output_function=show_record_for_edit">Insert Product</a></li>
						<li><a href="index.php?target_component%5B%5D=RecordIniFacade&amp;target_function%5B%5D=initialize&amp;eid=0&amp;type_id=2&amp;output_function=show_record_for_edit">Insert Ticket Item</a></li>
						<li><a href="index.php?target_component%5B%5D=RecordIniFacade&amp;target_function%5B%5D=initialize&amp;eid=0&amp;type_id=5&amp;output_function=show_record_for_edit">Insert Informational Item</a></li>
						<li><a href="index.php?target_component%5B%5D=RecordIniFacade&amp;target_function%5B%5D=initialize&amp;eid=0&amp;type_id=4&amp;OF_passthru=edit_travel_type">Insert Travel Item</a></li>
						<li><a href="index.php?target_component%5B%5D=RecordIniFacade&amp;target_function%5B%5D=initialize&amp;eid=0&amp;type_id=3&amp;output_function=edit_person">Insert Person</a></li>
						<li><a href="index.php?target_component%5B%5D=RecordIniFacade&amp;target_function%5B%5D=search_by_prop_val_contains&amp;spi=8&amp;spv=&amp;type_id=3&amp;OF_passthru=showpersonrecs">List Users</a></li>
						<li><a href="index.php?target_component%5B%5D=ClientServerDataOps&amp;target_function%5B%5D=initialize_lookup_table&amp;table_name=category&amp;OF_passthru=lookuptable_editor">Edit Categories</a></li>
					</xsl:if>
					<li><a >
					<xsl:attribute name="href" >index.php?target_component%5B%5D=RecordIniFacade&amp;target_function%5B%5D=initialize&amp;eid=<xsl:value-of select="$cur_user"/>&amp;type_id=3&amp;output_function=edit_person</xsl:attribute>Edit Account
					</a></li>
				</ul>
			</dd>
	</dl>
	

	
</div>

</xsl:template>

</xsl:stylesheet>