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
<xsl:include href="order_history_records_travel.xsl" />
<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>
<xsl:param name="title">Order History</xsl:param>

<xsl:template match="/" name="order_history_table_template">
      <div class="center">
        <table border="0" width="100%">
          <caption>
            <xsl:value-of select="$title"/>
            </caption>
          <thead>
            <tr>
					  <th>Order #</th>
					  <th>Order Date/Time</th>
					  <th>Customer Name</th>
					  <th>Business Name</th>
					  <th>Property Name</th>
					  <th>Acct. No</th>
					  <th>Check-in Date</th>
					  <th>Check-out Date</th>
					  <th>Order Status</th>
					  <th>Delete</th>
            </tr>
          </thead>
		              <xsl:apply-templates select="(//medb_order_elem_record)" />
        </table>
        <!-- insert the page navigation links 
  <xsl:call-template name="pagination" />-->
        <!-- create standard action buttons 
  <xsl:call-template name="actbar"/>-->
      </div>



</xsl:template>
</xsl:stylesheet>