<?xml version="1.0" encoding="utf-8"?><!-- DWXMLSource="/public_html/travelxml.xml" --><!DOCTYPE xsl:stylesheet  [
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
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" />

<xsl:template match="/the_travel_rec_stub">
<travel_rec>
      <user_id_elem><xsl:value-of select="travel_res_info/buyer_info/record/@eid"/></user_id_elem>
      <user_full_name_elem><xsl:value-of select="travel_res_info/buyer_info/record/property[@prop_id=9]/value" />&nbsp;
	  <xsl:value-of select="travel_res_info/buyer_info/record/property[@prop_id=36]/value" /> </user_full_name_elem>
	  <check_in_date><xsl:value-of select="travel_res_info/travel_res_submitted_fields/travel_res_submit_field[@res_field_name='travel_res__check_in_date']/res_field_value"/></check_in_date>
	  <check_out_date><xsl:value-of select="travel_res_info/travel_res_submitted_fields/travel_res_submit_field[@res_field_name='travel_res__check_out_date']/res_field_value"/></check_out_date>
	  <account_no><xsl:value-of select="travel_res_info/travel_product/record/property[@prop_id='33']/value"/></account_no>
	  <business_name><xsl:value-of select="travel_res_info/travel_res_submitted_fields/travel_res_submit_field[@res_field_name='travel_res__business_name']/res_field_value"/></business_name>
      <product_name><xsl:value-of select="travel_res_info/travel_product/record/property[@prop_id='1']/value"/></product_name>
</travel_rec>
</xsl:template>
</xsl:stylesheet>