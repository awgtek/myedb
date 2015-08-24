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
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exslt="http://exslt.org/common">
<xsl:include href="../TransactionTemplates/CheckoutPageTemplates/record.xsl" />

<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>
 <xsl:key name="record" match="/myedbroot/checkout_form/record/property[@prop_group_id='1']" use="@ron" />
  <xsl:key name="product_detail_line" match="property[@prop_group_id='2']" use="@ron" />
	<xsl:key name="prop_list_by_name" match="property" use="@prop_name" />

<xsl:param name="btn_sub" />

<xsl:template name="pagecontent">
		      <div id="public_center_content" >

		      <div class="bodytext2">

  <h2>Check out:</h2>
  <script>
  	function do_validation_co_form()
	{
		var error_msg = "";
		if (TextFieldIsEmpty(document.co_form.co_account_number))
		{
			document.co_form.co_account_number.focus();
			error_msg += "\nAccount Number";
		}
		if (TextFieldIsEmpty(document.co_form.co_business_name))
		{
			document.co_form.co_business_name.focus();
			error_msg += "\nBusiness Name";
		}
		if (TextFieldIsEmpty(document.co_form.co_name))
		{
			document.co_form.co_name.focus();
			error_msg += "\nName";
		}
		if (valButton(document.co_form.order_ship_addr)==null)
		{
			document.co_form.order_ship_addr.focus();
			error_msg += "\nWill pick up";
		}
		if (error_msg.trim() != "")
		{
			alert("Please fill out the following fields: " + error_msg);
			return false;
		}
		return false;
			
	}
  </script>
	 <form method="post" action="index.php" name="co_form">
<!--<input type="hidden" name="target_component[]" value="RecordIniFacade" />
<input type="hidden" name="target_function[]" value="update_record" />-->
<input type="hidden" name="target_component[]" value="TransMgmtFacade" />
<input type="hidden" name="target_function[]" value="finalize_order" />
<input type="hidden" name="OF_passthru" value="order_confirmation_page" />
	 <xsl:apply-templates select="/myedbroot/checkout_form/record" />
	 <table border="0">
	 	<tr>
			<td>
				<table>
				<!--THIS PLACE WAS USED FOR CREATING AND STORING SHIPPING ADDRESS. CHANGED from record template to "record_with_ship_info." MAY USE AGAIN-->
	 			</table>
			</td>
			<td>
				<table>
					<tr>
						<td>
							<xsl:variable name="tmpTotal">
									<xsl:for-each select="/myedbroot/checkout_form/transactions/transaction ">
										<xsl:variable name="var_ron" select="@ron"/>
										<xsl:variable name="var_prop_group_id" select="@prop_group_id"/>
										<xsl:variable name="var_rec_eid" select="@eiddst"/>
										<item>
											<xsl:value-of select="@qty * record[@eid = $var_rec_eid]/property[@prop_group_id = $var_prop_group_id and @prop_id=16 and @ron = $var_ron]/value"/>
										</item>
										<item>
											0<xsl:choose>
												<xsl:when test="record[@eid = $var_rec_eid]/property[@prop_id=30]/value = 1">
													<xsl:value-of select="@qty * record[@eid = $var_rec_eid]/property[@prop_id=29]/value"/>
												</xsl:when>
												<xsl:otherwise>
													<xsl:value-of select="record[@eid = $var_rec_eid]/property[@prop_id=29]/value"/>
												</xsl:otherwise>
											</xsl:choose>
										</item>
									</xsl:for-each>
							</xsl:variable>
							Total order cost: 
								<xsl:value-of select="format-number(sum(exslt:node-set($tmpTotal)/*), '$###,###,##0.00')" />
						</td>
					</tr>
				<!--	<tr>
						<td>Credit Card: <input type="text" name="cc_info" />
						</td>
					</tr>
					<tr>
						<td>Expiration Date: <input type="text" name="CCexpdate" />
						</td>
					</tr>
					<tr>
						<td>Card Holder's name: <input type="text" name="CChldrname" />
						</td>
					</tr>-->
					<tr>
						<td>Account Number: <input type="text" name="co_account_number"/>
						</td>
					</tr>
					<tr>
						<td>Business Name: <input type="text" name="co_business_name"/>
						</td>
					</tr>
					<tr>
						<td>Name: <input type="text" name="co_name"/>
						</td>
					</tr>
					<tr class="sechead">
						<td colspan="2" >
							Will pick up: <label for="will_pick_up_yes">Yes <input type="radio" name="order_ship_addr" value="will_pick_up" id="will_pick_up_yes"  /></label>
							 <label for="will_pick_up_no">No <input type="radio" name="order_ship_addr" value="will_ship" id="will_pick_up_no"  /></label> 
							 Mailing Charges May Apply (<a href="http://www.newenglandtrade.com/join-now/statement-of-fees.aspx">charges</a>)

						</td>
					</tr>
					<tr>
						<td>Shipping Address:
						</td>
					</tr>
					<DIV id="div_ship_to">
					<tr>
						<td>Address line 1: <input type="text" name="shipaddr_addr1" />
						</td>
					</tr>
					<tr>
						<td>Address line 2: <input type="text" name="shipaddr_addr2" />
						</td>
					</tr>
					<tr>
						<td>City: <input type="text" name="shipaddr_city" />
						</td>
					</tr>
					<tr>
						<td>State: <input type="text" name="shipaddr_state" />
						</td>
					</tr>
					<tr>
						<td>Zip: <input type="text" name="shipaddr_zip" />
						</td>
					</tr>
					<tr>
						<td>Phone #: <input type="text" name="chkout_order_phone" />
						</td>
					</tr>
					</DIV>
				</table>
			</td>
		</tr>
	 </table>
	 <input class="formbuttons" type="submit" id="btn_sub" name="btn_sub" onclick="do_validation_co_form(); return false;" value="Finalize Order" >
	</input>
	<!--<input type="reset" id="btn_res" name="btn_res" value="Reset" />-->
	 </form>
		</div>
</div>
		<xsl:call-template name="pub_search_res_div" />
</xsl:template>
</xsl:stylesheet>