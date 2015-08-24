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
<xsl:param name="travel_res__reservation_name" />
<xsl:param name="travel_res__total_no_adults" />
<xsl:param name="travel_res__total_no_children" />
<xsl:param name="travel_res__check_in_date" />
<xsl:param name="travel_res__check_out_date" />
<xsl:param name="travel_res__total_no_nights" />
<xsl:param name="travel_res__number_of_rooms" />
<xsl:param name="travel_res__smoking" />
<xsl:param name="travel_res__bed" />
<xsl:param name="travel_res__account_no" />
<xsl:param name="travel_res__business_name" />
<xsl:param name="travel_res__credit_card_no" />
<xsl:param name="travel_res__expiration_date" />
<xsl:param name="travel_res__card_holders_name" />
<xsl:param name="travel_res__phone_no" />
<xsl:param name="travel_res__special_requests" />

<xsl:template name="pagecontent">
		      <div id="public_center_content" >

		      <div class="bodytext2">

  <h2>Travel Item:</h2>
	 <form method="post" action="index.php">
			 	<input type="hidden" name="target_component[]" value="TransMgmtFacade" />
				<input type="hidden" name="target_function[]" value="initiate_travel_order" />
				<input type="hidden" name="eiddst">
					<xsl:attribute name="value">
						<xsl:value-of select="$eid"/>
					</xsl:attribute>
				</input>
				<input type="hidden" name="type_id" >
					<xsl:attribute name="value">
						<xsl:value-of select="$type_id"/>
					</xsl:attribute>
				</input>
				<input type="hidden" name="OF_passthru" value="confirm_travel_reservation_page" />
		<table width="60%" border="0">
	 <xsl:apply-templates select="/myedbroot/record"  mode="travel_item_display" />
	 	<tr>
			<td>
				Reservation Name
			</td>
			<td>
				<input type="hidden" name="trav_res_lab__reservation_name" value="Reservation Name" />
				<input type="text" name="travel_res__reservation_name" >
					<xsl:attribute name="value"><xsl:value-of select="$travel_res__reservation_name"/></xsl:attribute>
				</input>
			</td>
		</tr>
	 	<tr>
			<td>
				Total # Adults
			</td>
			<td>
				<input type="hidden" name="trav_res_lab__total_no_adults" value="Total # Adults" />
				<input type="text" name="travel_res__total_no_adults" >
					<xsl:attribute name="value"><xsl:value-of select="$travel_res__total_no_adults"/></xsl:attribute>
				</input>
			</td>
		</tr>
	 	<tr>
			<td>
				Total # Children
			</td>
			<td>
				<input type="hidden" name="trav_res_lab__total_no_children" value="Total # Children" />
				<input type="text" name="travel_res__total_no_children" >
					<xsl:attribute name="value"><xsl:value-of select="$travel_res__total_no_children"/></xsl:attribute>
				</input>
			</td>
		</tr>
	 	<tr>
			<td>
				Check in Date
			</td>
			<td>
				<input type="hidden" name="trav_res_lab__check_in_date" value="Check in Date" />
				<input type="text" name="travel_res__check_in_date" >
					<xsl:attribute name="value"><xsl:value-of select="$travel_res__check_in_date"/></xsl:attribute>
				</input>
			</td>
		</tr>
	 	<tr>
			<td>
				Check out Date
			</td>
			<td>
				<input type="hidden" name="trav_res_lab__check_out_date" value="Check out Date" />
				<input type="text" name="travel_res__check_out_date" >
					<xsl:attribute name="value"><xsl:value-of select="$travel_res__check_out_date"/></xsl:attribute>
				</input>
			</td>
		</tr>
	 	<tr>
			<td>
				Total # Nights
			</td>
			<td>
				<input type="hidden" name="trav_res_lab__total_no_nights" value="Total # Nights" />
				<input type="text" name="travel_res__total_no_nights" >
					<xsl:attribute name="value"><xsl:value-of select="$travel_res__total_no_nights"/></xsl:attribute>
				</input>
			</td>
		</tr>
	 	<tr>
			<td>
				Number of Rooms
			</td>
			<td>
				<input type="hidden" name="trav_res_lab__number_of_rooms" value="Number of Rooms" />
				<input type="text" name="travel_res__number_of_rooms" >
					<xsl:attribute name="value"><xsl:value-of select="$travel_res__number_of_rooms"/></xsl:attribute>
				</input>
			</td>
		</tr>
	 <!--	<tr>
			<td>
				Smoking 
			</td>
			<td>
				<input type="hidden" name="trav_res_lab__smoking" value="Smoking" />
				<input type="checkbox" name="travel_res__smoking" />
			</td>
		</tr>-->
	 	<tr>
			<td>
				Double or <br />Queen/King
			</td>
			<td>
				<input type="hidden" name="trav_res_lab__bed" value="Double (Queen/King)" />
				Double: <input type="radio" name="travel_res__bed" value="double" >
					<xsl:if test="$travel_res__bed = 'double'">
						<xsl:attribute name="checked">checked</xsl:attribute>
					</xsl:if>
				</input>
				 King/Queen: <input type="radio" name="travel_res__bed" value="king/queen"  >
					<xsl:if test="$travel_res__bed = 'king/queen'">
						<xsl:attribute name="checked">checked</xsl:attribute>
					</xsl:if>
				</input>
			</td>
		</tr>
	 	<tr>
			<td>
				Account #
			</td>
			<td>
				<input type="hidden" name="trav_res_lab__account_no" value="Account #"/>
				<input type="text" name="travel_res__account_no" >
					<xsl:attribute name="value"><xsl:value-of select="$travel_res__account_no"/></xsl:attribute>
				</input>
			</td>
		</tr>
	 	<tr>
			<td>
				Business Name
			</td>
			<td>
				<input type="hidden" name="trav_res_lab__business_name" value="Business Name" />
				<input type="text" name="travel_res__business_name" >
					<xsl:attribute name="value"><xsl:value-of select="$travel_res__business_name"/></xsl:attribute>
				</input>
			</td>
		</tr>
	 	<tr>
			<td>
				Credit Card #
			</td>
			<td>
				<input type="hidden" name="trav_res_lab__credit_card_no" value="Credit Card #" />
				<input type="text" name="travel_res__credit_card_no" >
					<xsl:attribute name="value"><xsl:value-of select="$travel_res__credit_card_no"/></xsl:attribute>
				</input>
			</td>
		</tr>
	 	<tr>
			<td>
				Expiration Date
			</td>
			<td>
				<input type="hidden" name="trav_res_lab__expiration_date" value="Expiration Date" />
				<input type="text" name="travel_res__expiration_date" >
					<xsl:attribute name="value"><xsl:value-of select="$travel_res__expiration_date"/></xsl:attribute>
				</input>
			</td>
		</tr>
	 	<tr>
			<td>
				Card Holders Name
			</td>
			<td>
				<input type="hidden" name="trav_res_lab__card_holders_name" value="Card Holders Name" />
				<input type="text" name="travel_res__card_holders_name" >
					<xsl:attribute name="value"><xsl:value-of select="$travel_res__card_holders_name"/></xsl:attribute>
				</input>
			</td>
		</tr>
	 	<tr>
			<td>
				Phone #
			</td>
			<td>
				<input type="hidden" name="trav_res_lab__phone_no" value="Phone #" />
				<input type="text" name="travel_res__phone_no" >
					<xsl:attribute name="value"><xsl:value-of select="$travel_res__phone_no"/></xsl:attribute>
				</input>
			</td>
		</tr>
	 	<tr>
			<td>
				Special Requests
			</td>
			<td>
				<input type="hidden" name="trav_res_lab__special_requests" value="Special Requests" />
				<textarea name="travel_res__special_requests">
					<xsl:value-of select="$travel_res__special_requests"/>
				
				</textarea>
			</td>
		</tr>
	 </table>
	 <input class="formbuttons" type="submit" id="btn_sub" name="btn_sub" value="Next" />
	<!--<input type="reset" id="btn_res" name="btn_res" value="Reset" />-->
	 </form>
		</div>
</div>
		<xsl:call-template name="pub_search_res_div" />
</xsl:template>
</xsl:stylesheet>