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

<xsl:template name="make-validation-script">
	<script>
	var regex_exceptions_hash = new Object();//when shown all shown ids added as regex key so that they are shown excepting the rule of not showing 'epi0ron'
	function validate_inputs()
	{	
		var retval = true;	
		var input_field = "";
		var alertmsg = "";
		<xsl:for-each select="myedbroot/record/property/validator/v_regex" >
		
			<xsl:variable name="input_field_regex" select="." /><!--add standin_ prefix if city or zip-->
			<xsl:variable name="input_field_id"><xsl:if test="ancestor::property/@prop_id='12'">standin_</xsl:if><xsl:if test="ancestor::property/@prop_id='13'">standin_</xsl:if><xsl:if test="ancestor::property/@prop_id='14'">standin_</xsl:if><xsl:value-of select="ancestor::property/@ffi" />
			</xsl:variable>
			 
			<xsl:variable name="input_field_name" select="ancestor::property/@prop_name" />
				var obj_id = '<xsl:value-of select="$input_field_id" />';
				var dovalidate = true;
			/*	var re = new RegExp('^pi1epi|^pi2epi|^pi29epi');
				if (re.exec(obj_id))
				{
					dovalidate = true; //override in case of inserting new record (for product name and description)
				} */
				//determine whether new option is hidden or shown
				for (key in regex_exceptions_hash) 
				{ 
					 var re = new RegExp(key);
					 if (re.exec(obj_id))
					 {
					 	if (regex_exceptions_hash[key] == 0)
						{
							dovalidate = false;
						}
					 }
				}
			//	if ('<xsl:value-of select="$input_field_regex" />'.empty) //must set category and subcategory to empty string to override validation because disabling category or subcategory will cause missing fields and cause javascript errors during validation (however this is not used since doesn't print validation for field when empty anyways
			//	{
			//		dovalidate = false;
			//	}
			//	var re = new RegExp('epi0ron');
			//	if (!re.exec(obj_id) || dovalidate)
				if ( dovalidate)
				{
					ctlInput = document.getElementById(obj_id);
					ctlInput.value = ctlInput.value.trim();
					//v_regex = '<xsl:value-of select="$input_field_regex" />';
					var re = /<xsl:value-of select="$input_field_regex" />/;
					input_field = '<xsl:value-of select="$input_field_name" />';
					//if (! testInfo(ctlInput, v_regex))
					if (! testInfo(ctlInput, re))
					{
						alertmsg += input_field + " is invalid!\n"; 
						retval = false;//alert("I'm here" + v_regex + ctlInput.value + retval);
					}
				}
		</xsl:for-each>

		if (!retval)
		{
          alert(alertmsg);
		}
		return retval;
	}
      function testInfo(phoneInput, re)
      {
	  	var retval = true;
        retval = re.exec(phoneInput.value);
		return retval;
      }
    //  var re = /\(?\d{3}\)?([-\/\.])\d{3}\1\d{4}/;
      function testInfoOld(ctlInput, v_regex)
      {
		var re = new RegExp(v_regex);
	  	var retval = true;
        retval = re.exec(ctlInput.value);//alert("I'm here" + v_regex + ctlInput.value + retval);
		return retval;
      }
</script>

</xsl:template>

</xsl:stylesheet>