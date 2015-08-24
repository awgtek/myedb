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
<xsl:include href="misc/string_formatting.xsl" />

<xsl:output method="html" encoding="utf-8"/>
 <xsl:template match="property" mode="notablecells">
		 <xsl:value-of select="@prop_name"/>: &nbsp;
		 <input type="text"   >
		 <xsl:attribute name="id" >
			<xsl:value-of select="@ffi"/>
		 </xsl:attribute>
		 <xsl:attribute name="name" >
			<xsl:value-of select="@ffi"/>
		 </xsl:attribute>
		 <xsl:attribute name="value">
			<xsl:value-of select="value"/>
		 </xsl:attribute>
		 </input>

 </xsl:template>
 
  <xsl:template match="property" mode="in_textarea_descrip_in_param">
  		<xsl:param name="param_descrip" />
 		 <tr>
		 <td>
		 	<xsl:value-of select="$param_descrip" />
		 </td>
		 <td><textarea rows="18" cols="40">
		 <xsl:attribute name="id" >
			<xsl:value-of select="@ffi"/>
		 </xsl:attribute>
		 <xsl:attribute name="name" >
			<xsl:value-of select="@ffi"/>
		 </xsl:attribute>
			<xsl:value-of select="value"/>
		 </textarea>
		 </td>
		 </tr>

 </xsl:template>
 
  <xsl:template match="property" mode="in_textarea">
 		 <tr>
		 <td>
		 <xsl:value-of select="@prop_name"/> 
		 	<xsl:if test="@prop_id = 54"> (separate keywords with commas)</xsl:if>
		 </td>
		 <td><textarea rows="8" cols="40">
		 <xsl:attribute name="id" >
			<xsl:value-of select="@ffi"/>
		 </xsl:attribute>
		 <xsl:attribute name="name" >
			<xsl:value-of select="@ffi"/>
		 </xsl:attribute>
			<xsl:value-of select="value"/>
		 </textarea>
		 </td>
		 </tr>

 </xsl:template>
 
 <xsl:template match="property" mode="hidden_input_field">
 		<xsl:param name="field_title" />
		 <input type="hidden"   >
		 <xsl:attribute name="id" >
			<xsl:value-of select="@ffi"/>
		 </xsl:attribute>
		 <xsl:attribute name="name" >
			<xsl:value-of select="@ffi"/>
		 </xsl:attribute>
		 <xsl:attribute name="value">
			<xsl:value-of select="value"/>
		 </xsl:attribute>
		 </input>

 </xsl:template>

 <xsl:template  match="property" mode="hidden_input_field_with_passed_value">
 		<xsl:param name="passed_value" />
		 <input type="hidden"   >
		 <xsl:attribute name="id" >
			<xsl:value-of select="@ffi"/>
		 </xsl:attribute>
		 <xsl:attribute name="name" >
			<xsl:value-of select="@ffi"/>
		 </xsl:attribute>
		 <xsl:attribute name="value">
			<xsl:value-of select="$passed_value"/>
		 </xsl:attribute>
		 </input>

 </xsl:template>


 <xsl:template name="inputrow" match="property">
 		<xsl:param name="field_title" />
 		 <tr>
		 <td> 
        <xsl:choose>
            <xsl:when test="string-length(normalize-space($field_title)) = 0">
				 <xsl:value-of select="@prop_name"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$field_title"/>
            </xsl:otherwise>
        </xsl:choose>

		 </td>
		 <td>
		 <input type="text"  class="input_text"  >
		 	<xsl:choose>
				<xsl:when test="$auth_level = 1">
					 <xsl:attribute name="readonly">
					 </xsl:attribute>
				</xsl:when>
				<xsl:otherwise>
				</xsl:otherwise>
			</xsl:choose>
		 <xsl:attribute name="id" >
			<xsl:value-of select="@ffi"/>
		 </xsl:attribute>
		 <xsl:attribute name="name" >
			<xsl:value-of select="@ffi"/>
		 </xsl:attribute>
		 <xsl:attribute name="value">
			<xsl:value-of select="value"/>
		 </xsl:attribute>
		 </input>
		 </td>
		 </tr>

 </xsl:template>

  <xsl:template match="property" mode="print_delete_checkbox">
 		 <tr>
		 <td>
		 <xsl:value-of select="@prop_name"/>
		 </td>
		 <td>
		 <input type="text"   >
		 <xsl:attribute name="id" >
			<xsl:value-of select="@ffi"/>
		 </xsl:attribute>
		 <xsl:attribute name="name" >
			<xsl:value-of select="@ffi"/>
		 </xsl:attribute>
		 <xsl:attribute name="value">
			<xsl:value-of select="value"/>
		 </xsl:attribute>
		 </input>
		 <br />
		<xsl:if test="@epi &gt; 0">
			<input type="checkbox" name="props_to_delete[]" >
				<xsl:attribute name="value">pid<xsl:value-of select="@prop_id"/>rid<xsl:value-of select="@ron" />
				</xsl:attribute>
			</input> Delete? 
		</xsl:if>

		 </td>
		 </tr>

 </xsl:template>

 <xsl:template match="property" mode="print_text_with_field_name2">
 		<xsl:param name="field_title" />
		<xsl:param name="label_class" />
		<xsl:param name="value_class" />
		<!--<xsl:if test="@epi &gt; 0">-->
 		 <tr>
		 <td width="150" valign="top" >
		 	<xsl:attribute name="class">
				<xsl:choose>
					<xsl:when test="string-length(normalize-space($label_class)) = 0">
						 product-tan
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$label_class"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
        <xsl:choose>
            <xsl:when test="string-length(normalize-space($field_title)) = 0">
				 <xsl:value-of select="@prop_name"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$field_title"/>
            </xsl:otherwise>
        </xsl:choose>
		 </td>
		 <td valign="top" class="product-tan product-description"  ><!--style="white-space: pre;" doesn't work, makes long lines.-->
		 	<xsl:attribute name="class">
				<xsl:choose>
					<xsl:when test="string-length(normalize-space($value_class)) = 0">
						 product-tan product-description
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$value_class"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
		 	<xsl:call-template name="add-line-breaks">
				<xsl:with-param name="string">
					<xsl:value-of select="value"/>
				</xsl:with-param>
			</xsl:call-template>
		 </td>
		 </tr>
		<!--</xsl:if>-->
 </xsl:template>
 <xsl:template match="property" mode="print_text_with_field_name1">
		<!--<xsl:if test="@epi &gt; 0">-->
 		 <tr>
		 <td width="150" valign="top" class="product-green">
		 <xsl:value-of select="@prop_name"/>
		 </td>
		 <td valign="top" class="product-green product-description">
			<xsl:value-of select="value"/>
		 </td>
		 </tr>
		<!--</xsl:if>-->
 </xsl:template>
 <xsl:template match="property" mode="print_text_with_mailto_hyperlink">
		<!--<xsl:if test="@epi &gt; 0">-->
 		 <tr>
		 <td width="150" valign="top" class="product-green">
		 <xsl:value-of select="@prop_name"/>
		 </td>
		 <td valign="top" class="product-green product-description">
		 	<a>
				<xsl:attribute name="href">mailto:<xsl:value-of select="value"/></xsl:attribute>
				<xsl:attribute name="target">_blank</xsl:attribute>
				<xsl:value-of select="value"/>
			</a>
		 </td>
		 </tr>
		<!--</xsl:if>-->
 </xsl:template>
 <xsl:template match="property" mode="print_text_with_field_name_hyperlink">
		<!--<xsl:if test="@epi &gt; 0">-->
 		 <tr>
		 <td width="150" valign="top" class="product-green">
		 <xsl:value-of select="@prop_name"/>
		 </td>
		 <td valign="top" class="product-green product-description">
		 	<a>
				<xsl:attribute name="href">http://<xsl:value-of select="value"/></xsl:attribute>
				<xsl:attribute name="target">_blank</xsl:attribute>
				<xsl:value-of select="value"/>
			</a>
		 </td>
		 </tr>
		<!--</xsl:if>-->
 </xsl:template>
 <xsl:template match="property" mode="print_text_with_field_name">
		<xsl:if test="@epi &gt; 0">
 		 <tr>
		 <td width="150">
		 <xsl:value-of select="@prop_name"/>
		 </td>
		 <td bgcolor="#99CCFF">
			<xsl:value-of select="value"/>
		 </td>
		 </tr>
		</xsl:if>
 </xsl:template>
  <xsl:template match="property" mode="print_labeled_field_text">
 		 <tr>
		 <td>
		 <xsl:value-of select="@prop_name"/>
		 </td>
		 <td>
			<xsl:value-of select="value"/>
		 </td>
		 </tr>

 </xsl:template>
 <xsl:template match="property" mode="print_field_text">
			<xsl:value-of select="value"/>
 </xsl:template>


 <xsl:template match="property" mode="checkbox">
 		 <tr>
		 <td>
		 <xsl:value-of select="@prop_name"/>
		 </td>
		 <td>
		 <input type="checkbox" value="1" >
			 <xsl:attribute name="id" >
				<xsl:value-of select="@ffi"/>_on</xsl:attribute>
			 <xsl:attribute name="name" >
				<xsl:value-of select="@ffi"/>
			 </xsl:attribute>
			 <xsl:if test="value = 1">
				<xsl:attribute name="checked">true
				</xsl:attribute>
			 </xsl:if>
			 <xsl:attribute name="onClick">document.getElementById('<xsl:value-of select="@ffi"/>_off').checked = !(this.checked); </xsl:attribute>
		 </input>
		 <input type="checkbox" value="0" style="visibility:hidden" >
			 <xsl:attribute name="id" >
				<xsl:value-of select="@ffi"/>_off</xsl:attribute>
			 <xsl:attribute name="name" >
				<xsl:value-of select="@ffi"/>
			 </xsl:attribute>
		 </input>
		 </td>
		 </tr>

 </xsl:template>
 
 <xsl:template match="property" mode="image_link">
 	<tr>
		 <td>
		 <a target="_blank" >
		 	<xsl:attribute name="href">
				<xsl:value-of select='$app_root_client' />/client_uploaded_images/<xsl:value-of select="value"/>
			</xsl:attribute>
		 	<xsl:value-of select="@prop_name"/>
		 </a>
		 </td>
		<td>
			 <input type="file"  >
				 <xsl:attribute name="id" >
					<xsl:value-of select="@ffi"/>
				 </xsl:attribute>
				 <xsl:attribute name="name" >
					<xsl:value-of select="@ffi"/>
				 </xsl:attribute>
				 <xsl:attribute name="value">
					<xsl:value-of select="value"/>
				 </xsl:attribute>
			 </input>
		</td>
	</tr>
	
 </xsl:template>
</xsl:stylesheet>