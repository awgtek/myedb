<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
xmlns:exslt="http://exslt.org/common"
>
<xsl:include href="include/page_sections/page_includes.xsl"/>
<xsl:include href="include/head_includes.xsl"/>

<xsl:output method="html"/>


<xsl:template match="/">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/>
<title>Untitled Document</title>
<link href="/stylesheets/main_style.css" rel="stylesheet" type="text/css" />
<xsl:call-template name="horiz-menu-header-code"/>
		<xsl:call-template name="head_include_tags" />
</head>
<body>
<xsl:call-template name="horiz-menu" />

<div id="site">

<table border='1'>
	<tr>
		<td>
			<table>
	<xsl:apply-templates select="/myedbroot/transactions/transaction"/>
			</table>
		</td>
		<td>
		<xsl:variable name="tmpTotal">
				<xsl:for-each select="/myedbroot/transactions/transaction ">
					<xsl:variable name="var_ron" select="@ron"/>
					<xsl:variable name="var_prop_group_id" select="@prop_group_id"/>
					<xsl:variable name="var_rec_eid" select="@eiddst"/><!--for future possible compatibility if multiple records ever embedded into a transaction-->
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
            <xsl:value-of select="sum(exslt:node-set($tmpTotal)/*)" />
        
		</td>
	</tr>
</table>
<form action="" method="get">

	<input type="hidden" name="target_component[]" value="TransMgmtFacade"  />
	<input type="hidden" name="target_function[]" value="get_checkout_form_xml" />
	<!--<input type="hidden" name="type_id" value="3" />
	<input type="hidden" name="eid"  >
		<xsl:attribute name="value"><xsl:value-of select="$cur_user"/></xsl:attribute>
	</input>-->
	<input type="hidden" name="OF_passthru" value="checkout_cart" />
	<input type="submit" value="Checkout"  />
</form>
</div>
</body>
</html>

</xsl:template>

<xsl:template match="transaction">
	<xsl:variable name="var_prop_group_id" select="@prop_group_id" />
	<xsl:variable name="var_ron" select="@ron" />
	<xsl:variable name="var_eiddst" select="@eiddst" />
<tr>
	<td> <xsl:value-of select="record[@eid=$var_eiddst]/property[@prop_id=1]/value" /></td>
	
	<xsl:apply-templates select="record[@eid=$var_eiddst]/property[@prop_group_id = $var_prop_group_id and @ron = $var_ron]" />
	<td>
		<form action="" method="post" >
			<input type="hidden" name="rec_eid">
				<xsl:attribute name="value">
					<xsl:value-of select="@eiddst"/>
				</xsl:attribute>
			</input>
	 		<input type="hidden" name="target_component[]" value="TransMgmtFacade" />
			<input type="hidden" name="target_function[]" value="create_transaction" />
			<input type="hidden" name="target_component[]" value="TransMgmtFacade" />
			<input type="hidden" name="target_function[]" value="get_pending_transactions" />
			<input type="hidden" name="output_function" value="show_pending_transactions"  />
					<select name="groups_to_add_to_transactions[]" onchange="this.form.submit();">
						<option value="0">Select quantity</option>
					    <xsl:call-template name="qty-select">
        					<xsl:with-param name="counter" select="1"/>
							<xsl:with-param name="count_limit" select="record[@eid=$var_eiddst]/property[@prop_group_id = $var_prop_group_id and @ron = $var_ron and @prop_id = 15]/value"/>
							<xsl:with-param name="cart_qty" select="@qty"/>
							<xsl:with-param name="optvalprefix">pgid<xsl:value-of select="@prop_group_id"/>rid<xsl:value-of select="@ron" />qty</xsl:with-param>
    					</xsl:call-template>
					</select>
		</form>
		
	</td>
	<td>
		<form action="" method="post" >
		<input type="hidden" name="target_component[]" value="TransMgmtFacade" />
		<input type="hidden" name="target_function[]" value="delete_transaction" />
		<input type="hidden" name="target_component[]" value="TransMgmtFacade" />
		<input type="hidden" name="target_function[]" value="get_pending_transactions" />
		<input type="hidden" name="output_function" value="show_pending_transactions"  />
	
			<input type="hidden" name="transid"  >
			<xsl:attribute name="value">
				<xsl:value-of select="@transid" />
			</xsl:attribute>
			</input><input type="submit" value="delete"  />
		</form>
	</td>
</tr>
</xsl:template>

<xsl:template name="qty-select">
    <xsl:param name="counter"/>
	<xsl:param name="count_limit"/>
	<xsl:param name="cart_qty"/>
	<xsl:param name="optvalprefix"/>
	<option>
		<xsl:if test="$cart_qty = $counter">
			<xsl:attribute name="selected" >1</xsl:attribute>
		</xsl:if>
		<xsl:attribute name="value" ><xsl:value-of select="$optvalprefix"/><xsl:value-of select="$counter"/></xsl:attribute>
	    <xsl:value-of select="$counter"/>
	</option>
    <xsl:if test="$counter &lt; $count_limit">
        <xsl:call-template name="qty-select">
            <xsl:with-param name="counter" select="$counter + 1"/>
			<xsl:with-param name="count_limit" select="$count_limit"/>
			<xsl:with-param name="cart_qty" select="$cart_qty"/>
			<xsl:with-param name="optvalprefix" select="$optvalprefix"/>
        </xsl:call-template>
    </xsl:if>
</xsl:template>



<xsl:template match="property">
	<td><xsl:value-of select="@prop_name" />: <xsl:value-of select="value" /> </td>

</xsl:template>
</xsl:stylesheet>