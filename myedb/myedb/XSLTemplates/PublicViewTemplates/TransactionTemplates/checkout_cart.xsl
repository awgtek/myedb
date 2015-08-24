<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
xmlns:exslt="http://exslt.org/common"
>
<xsl:include href="../../include/head_includes.xsl"/>
<xsl:include href="../../include/form_validation/validate_complete.xsl"/>
<xsl:include href="../PageContents/checkout_cart_pgct.xsl" />
<xsl:include href="../pageframe.xsl" />

<xsl:output method="html"/>


<xsl:template match="/">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/>
<title>Check out cart</title>
<link href="/stylesheets/main_style.css" rel="stylesheet" type="text/css" />
<xsl:call-template name="horiz-menu-header-code"/>
		<xsl:call-template name="head_include_tags" />
		<xsl:call-template name="validate_complete_form" />
    <script language="javascript">
   
        function initValidation()
        { //these values are currently placed in html fields declaratively
/*            var objForm = document.forms["co_form"];

            objForm.co_account_number.required = 1;
            objForm.co_account_number.regexp = /^\w*$/;

            objForm.co_business_name.required = 1;
            objForm.co_business_name.regexp = /^\w*$/;

            objForm.co_name.required = 1;
            objForm.co_name.regexp = /^\w*$/;

            objForm.password.required = 1;
            objForm.password.minlength = 3;
            objForm.password.maxlength = 8;

            objForm.language.required = 1;
            objForm.language.exclude = '-1';
            objForm.language.err = 'Hey dude, please select a language';

            objForm.street.required = 0;

            objForm.email.required = 1;
            objForm.email.regexp = "JSVAL_RX_EMAIL";

            objForm.age.required = 1;
            objForm.age.minvalue = 10;
            objForm.age.maxvalue = 90; */
        }
   
    </script>
		
</head>
<body onLoad="initValidation()">
		<xsl:call-template name="pageframe">
		</xsl:call-template>
</body>
</html>

</xsl:template>


</xsl:stylesheet>