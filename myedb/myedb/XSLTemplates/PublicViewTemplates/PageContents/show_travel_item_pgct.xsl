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
	 <form method="get" action="index.php">
			 	<input type="hidden" name="target_component[]" value="RecordIniFacade" />
				<input type="hidden" name="target_function[]" value="initializeRecordSet" />
				 <input type="hidden" name="eid">
					<xsl:attribute name="value">
						<xsl:value-of select="$eid"/>
					</xsl:attribute>
				 </input>
				 <input type="hidden" name="type_id">
					<xsl:attribute name="value">
						<xsl:value-of select="$type_id"/>
					</xsl:attribute>
				 </input>
				<input type="hidden" name="eids[]">
					<xsl:attribute name="value">
						<xsl:value-of select="$eid"/>
					</xsl:attribute>
				</input>
				<input type="hidden" name="eids[]" ><!--get policy agreement record-->
					<xsl:attribute name="value">
						<xsl:value-of select="10"/>
					</xsl:attribute>
				</input>
				<input type="hidden" name="OF_passthru" value="user_reservation_travel_policy" />
		<table width="100%"  border="0" cellspacing="0" cellpadding="0">
	 <xsl:apply-templates select="/myedbroot/record"  mode="travel_item_display"/>
	 </table>
	 <input class="formbuttons" type="submit" id="btn_sub" name="btn_sub" value="Make Reservation" />
	<!--<input type="reset" id="btn_res" name="btn_res" value="Reset" />-->
	 </form>
		</div>
</div>
		<xsl:call-template name="pub_search_res_div" />
</xsl:template>
</xsl:stylesheet>