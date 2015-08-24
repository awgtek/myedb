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
		      <div id="public_center_content" >

		      <div class="bodytext2">

  <h2>Travel Item:</h2>
Tranvel confirmation:<br />
	<table border="1">
	<xsl:apply-templates select="/myedbroot/travel_res_info/travel_res_submitted_fields"/>
	</table>
	 <form method="get" action="index.php">
			 	<input type="hidden" name="target_component[]" value="RecordIniFacade" />
				<input type="hidden" name="target_function[]" value="initialize" />
				<input type="hidden" name="eid">
					<xsl:attribute name="value">
						<xsl:value-of select="$eiddst"/>
					</xsl:attribute>
				</input>
				<input type="hidden" name="type_id" >
					<xsl:attribute name="value">
						<xsl:value-of select="$type_id"/>
					</xsl:attribute>
				</input>
				<input type="hidden" name="OF_passthru" value="user_reservation_page" />
		<input type="submit"  value="Go back" />
	</form>
	<form action="index.php" method="post">
			 	<input type="hidden" name="target_component[]" value="TransMgmtFacade" />
				<input type="hidden" name="target_function[]" value="confirm_travel_order" />
				<input type="hidden" name="eiddst">
					<xsl:attribute name="value">
						<xsl:value-of select="$eiddst"/>
					</xsl:attribute>
				</input>
				<input type="hidden" name="type_id" >
					<xsl:attribute name="value">
						<xsl:value-of select="$type_id"/>
					</xsl:attribute>
				</input>
				<input type="hidden" name="OF_passthru" value="travel_reservation_confirmation_page" />
		<input type="submit" value="Confirm"/>
	</form>
		</div>
</div>
		<xsl:call-template name="pub_search_res_div" />
</xsl:template>
</xsl:stylesheet>