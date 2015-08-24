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
<xsl:include href="subcat_hidden_fields.xsl" />

<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>

<xsl:template name="category_group">
	<tr>

	<script>
//--------------------------------------
//       categories:
		var cat_subcat_ins = new Array();
		var cat_subcat_dels = new Array();
		var cat_subcats = new Hash(); //for holding subcat to category mappings
		var cats_clicked = new Array();
		
		var cats_selected = new Hash();
		var cats_unselected = new Hash();
			
			cat_subcats[0] = new Array(); //for invalid subcategory ids
			
		<xsl:for-each select="key('prop_list_by_id','6')">
			<xsl:sort select="@ron" order="ascending" data-type="number"/> 
			<xsl:variable name="stored_cat_nodes" select="../property[@prop_id = 6 and @epi != 0]" /> 
			<xsl:variable name="stored_cat_count" select="count(../property[@prop_id = 6 and @epi != 0])" />
			<xsl:variable name="curpos" select="position()" />
			//var _catval = "<xsl:value-of select="catval" />";


			<xsl:variable name="curcatid">
				<xsl:if test="@epi = 0">
					<xsl:value-of select="/myedbroot/categories/category[not(@cat_id = $stored_cat_nodes/value)][$curpos - $stored_cat_count]/@cat_id" />
				</xsl:if>
				<xsl:if test="@epi != 0">
					<xsl:value-of select="value" />
				</xsl:if>
			</xsl:variable>
			
			//setup cat_subcats
			cat_subcats[<xsl:value-of select="$curcatid" />] = new Array();
			
			<!--<xsl:apply-templates select="./validator/select"/>-->
			<xsl:if test="/myedbroot/categories/category[@cat_id = $curcatid]/@is_disabled != 1" >
				cur_cat_val = "<xsl:value-of select="/myedbroot/categories/category[@cat_id = $curcatid]/catval" />";
				<xsl:if test="@epi = 0">
					cats_unselected.set('<xsl:value-of select="@ffi" />', cur_cat_val);
				</xsl:if>
				<xsl:if test="@epi != 0">
					cats_selected.set('<xsl:value-of select="@ffi" />', cur_cat_val);
				</xsl:if>
			</xsl:if>
		</xsl:for-each>
//--------------------------------------
//       subcategories:

		var subcats_selected = new Hash();
		var subcats_unselected = new Hash();
		<xsl:for-each select="key('prop_list_by_id','50')">
			<xsl:sort select="@ron" order="ascending" data-type="number"/> 
			<xsl:variable name="stored_subcat_nodes" select="../property[@prop_id = 50 and @epi != 0]" /> 
			<xsl:variable name="stored_subcat_count" select="count(../property[@prop_id = 50 and @epi != 0])" />
			<xsl:variable name="curpos" select="position()" />
			//var _catval = "<xsl:value-of select="catval" />";


			<xsl:variable name="cursubcatid">
				<xsl:if test="@epi = 0">
					<xsl:value-of select="/myedbroot/subcategories/subcategory[not(@subcat_id = $stored_subcat_nodes/value)][$curpos - $stored_subcat_count]/@subcat_id" />
				</xsl:if>
				<xsl:if test="@epi != 0">
					<xsl:value-of select="value" />
				</xsl:if>
			</xsl:variable>
			
			//add subcats to cats hash
			var subcats_cat_id = '<xsl:value-of select="/myedbroot/subcategories/subcategory[@subcat_id=$cursubcatid]/@cat_id" />'*1;
		/*	if (!(subcats_cat_id in cat_subcats))
			{
				cat_subcats[subcats_cat_id] = new Array();
				var arr = new Array();
				alert ('hello' + cat_subcats[subcats_cat_id].length);
			} */
			cat_subcats[subcats_cat_id].push(<xsl:value-of select="$cursubcatid" />);
			
			<!--<xsl:apply-templates select="./validator/select"/>-->
			<xsl:if test="/myedbroot/subcategories/subcategory[@subcat_id = $cursubcatid]/@is_disabled != 1" >
				cur_subcat_val = "<xsl:value-of select="/myedbroot/subcategories/subcategory[@subcat_id = $cursubcatid]/@subcat_name" />";
				<xsl:if test="@epi = 0">
					subcats_unselected.set('<xsl:value-of select="@ffi" />', cur_subcat_val);
				</xsl:if>
				<xsl:if test="@epi != 0">
					subcats_selected.set('<xsl:value-of select="@ffi" />', cur_subcat_val);
				</xsl:if>
			</xsl:if>
		</xsl:for-each>
//------------------------------------------------
		
		function move_to_sel_cats(unsel_cats)
		{
			var selLength = unsel_cats.length;
			var selectedCount = 0;
			
			var i;
			for(i=selLength-1; i>=0; i--)
			{
				if(unsel_cats.options[i].selected)
				{
					$(unsel_cats.options[i].value + '_del').checked = false; 
					$(unsel_cats.options[i].value).checked = true;
					//selectedCount++;
					//update subcat arrays
					var re = /sel_subcats/;
					if (re.exec(unsel_cats.name))
					{
						var option_text = subcats_unselected.unset(unsel_cats.options[i].value);
						subcats_selected.set(unsel_cats.options[i].value, option_text);
					}
				}
			}
		}

		function move_to_unsel_cats(sel_cats)
		{
			var selLength = sel_cats.length;
			
			var i;
			for(i=selLength-1; i>=0; i--)
			{
				if(sel_cats.options[i].selected)
				{
					var re = /epi0ron/;
					if (!re.exec(sel_cats.options[i].value)) //if not new unsaved property, don't set it to delete
					{
						$(sel_cats.options[i].value + '_del').checked = true; 
					}
					$(sel_cats.options[i].value).checked = false;
					//selectedCount++;
					//update subcat arrays
					var re = /sel_subcats/;
					if (re.exec(sel_cats.name))
					{
						var option_text = subcats_selected.unset(sel_cats.options[i].value);
						subcats_unselected.set(sel_cats.options[i].value, option_text);
					}
				}
			}
		}
	</script>
	<script>
		//for algorithm, see plan 20090417 - Adam George adamwg@hotmail.com
		function add_cats_clicked()
		{
			cats_clicked = new Array();
			for (var cnt = $("unsel_cats").options.length -1; cnt >= 0; cnt--)
			{
				if ($("unsel_cats")[cnt].selected)
				{
					//alert(sel[cnt].value);
					cats_clicked.push($($("unsel_cats")[cnt].value).value);
				}
			}
			for (var cnt = $("sel_cats").options.length -1; cnt >= 0; cnt--)
			{
				if ($("sel_cats")[cnt].selected)
				{
					//alert(sel[cnt].value);
					cats_clicked.push($($("sel_cats")[cnt].value).value);
				}
			}
			$("unsel_subcats").options.length=0;
			$("sel_subcats").options.length=0;
			
			if (cats_clicked.length == 0)
			{
				subcat_sel_options_setup(); //reset subcategory select boxes to included all, i.e. unfiltered subcategories
			}
			else
			{
				subcats_selected.each(function(pair) {   
						var subcatid = $(pair.key).value;
						for (var i=0; i &lt; cats_clicked.length; i++)
						{
	//						if (cat_subcats.indexOf(cats_clicked[i]) !== -1)
							if (cats_clicked[i] in cat_subcats)
							{//alert("here" + cat_subcats[cats_clicked[i]] + " -- " + subcatid + " -- " + cat_subcats[cats_clicked[i]].indexOf(subcatid*1) + " - length: " + cat_subcats[cats_clicked[i]].length);
								if (cat_subcats[cats_clicked[i]].indexOf(subcatid*1) !== -1)
								{ 
									addOption($("sel_subcats"),pair.value,pair.key);
								}
							}
						//alert(pair.key + ' = "' + pair.value + '"'); 
						}
					}
				); 
				//var h = $H(subcats_unselected);
				subcats_unselected.each(function(pair) {   
						var subcatid = $(pair.key).value;
						for (var i=0; i &lt; cats_clicked.length; i++)
						{
							//alert(cats_clicked + " -- " + cats_clicked[0]);
							if (cats_clicked[i] in cat_subcats)
							{//alert("here" + cat_subcats[cats_clicked[i]] + " -- " + subcatid + " -- " + cat_subcats[cats_clicked[i]].indexOf(subcatid*1) + " - length: " + cat_subcats[cats_clicked[i]].length);
								if (cat_subcats[cats_clicked[i]].indexOf(subcatid*1) !== -1) // *1 is to convert the input field value to numeric
								{
									addOption($("unsel_subcats"),pair.value,pair.key);
								}
							}
						//alert(pair.key + ' = "' + pair.value + '"'); 
						}
					}
				); 
			}
		}
	</script>
<!-- Categories  -->
		<td>
			Categories
		</td>
		<td>
		<table border="0">
			<tr>
				<td colspan="3">Use arrows to move item from left to right to assign to this product</td>
			</tr>
			<tr>
				<td>
					<select name="unsel_cats" id="unsel_cats" size="6" multiple="multiple" onchange="add_cats_clicked(this);">
					</select>
				</td>
				<td align="center" valign="middle">
					<input type="button" value="--&gt;"
					 onclick="move_to_sel_cats(this.form.unsel_cats); moveOptions(this.form.unsel_cats, this.form.sel_cats);" /><br />
					<input type="button" value="&lt;--"
					 onclick="move_to_unsel_cats(this.form.sel_cats); moveOptions(this.form.sel_cats, this.form.unsel_cats);" />
				</td>
				<td>
					<select name="sel_cats" id="sel_cats" size="6" multiple="multiple" onchange="add_cats_clicked(this);">
					</select>
				</td>	</tr>
		</table>
<script>
	cats_selected.each(function(pair) {   
		addOption($("sel_cats"),pair.value,pair.key);
		//alert(pair.key + ' = "' + pair.value + '"'); 
		}
	); 
	//var h = $H(cats_unselected);
	cats_unselected.each(function(pair) {   
		addOption($("unsel_cats"),pair.value,pair.key);
		//alert(pair.key + ' = "' + pair.value + '"'); 
		}
	); 

</script>
		</td>
	</tr>
<!--  -->
<!-- Subcategories -->
	<tr>
		<td> Subcategories
		</td>
		<td>
		
		<table border="0">
			<tr>
				<td colspan="3">Use arrows to move item from left to right to assign to this product</td>
			</tr>
			<tr>
				<td>
					<select name="unsel_subcats" id="unsel_subcats" style="width:50" size="6" multiple="multiple">
					</select>
				</td>
				<td align="center" valign="middle">
					<input type="button" value="--&gt;"
					 onclick="move_to_sel_cats(this.form.unsel_subcats); moveOptions(this.form.unsel_subcats, this.form.sel_subcats);" /><br />
					<input type="button" value="&lt;--"
					 onclick="move_to_unsel_cats(this.form.sel_subcats); moveOptions(this.form.sel_subcats, this.form.unsel_subcats);" />
				</td>
				<td>
					<select name="sel_subcats" id="sel_subcats" size="6" style="width:150" multiple="multiple">
					</select>
				</td>	</tr>
		</table>
<script>
	function subcat_sel_options_setup()
	{
		subcats_selected.each(function(pair) {   
			addOption($("sel_subcats"),pair.value,pair.key);
			//alert(pair.key + ' = "' + pair.value + '"'); 
			}
		); 
		//var h = $H(subcats_unselected);
		subcats_unselected.each(function(pair) {   
			addOption($("unsel_subcats"),pair.value,pair.key);
			//alert(pair.key + ' = "' + pair.value + '"'); 
			}
		); 
	}
	subcat_sel_options_setup();
</script>
<!--  -->


		<!-- setup hidden fields for client side javascript activity, moving values left/right, etc. -->
					<xsl:variable name="selected_categories" select="/myedbroot/record/property[@prop_id=6 and @epi != 0]/value" />
						<xsl:variable name="stored_cat_count" select="count(/myedbroot/record/property[@prop_id = 6 and @epi != 0])" />
						<xsl:variable name="stored_cat_nodes" select="/myedbroot/record/property[@prop_id = 6 and @epi != 0]" /> 
									<xsl:variable name="stored_subcat_count" select="count(/myedbroot/record/property[@prop_id = 50 and @epi != 0])" />
									<xsl:variable name="stored_subcat_nodes" select="/myedbroot/record/property[@prop_id = 50 and @epi != 0]" /> 
									<xsl:variable name="unstored_subcats" select="/myedbroot/subcategories/subcategory[not(@subcat_id = $stored_subcat_nodes/value)]"/>

		 <xsl:for-each select="key('prop_list_by_name','Category')">
						<xsl:sort select="@ron" order="ascending" data-type="number"/> 
						<xsl:variable name="catpropval" select="value" />
						<xsl:variable name="curpos" select="position()" />
						<xsl:variable name="curcatval">
							<xsl:if test="@epi = 0">
								<xsl:value-of select="/myedbroot/categories/category[not(@cat_id = $stored_cat_nodes/value)][$curpos - $stored_cat_count]/catval" />
							</xsl:if>
							<xsl:if test="@epi != 0">
								<xsl:value-of select="/myedbroot/categories/category[ @cat_id = $catpropval]/catval" />
							</xsl:if>
						</xsl:variable>
						<xsl:variable name="curcatid">
							<xsl:if test="@epi = 0">
								<xsl:value-of select="/myedbroot/categories/category[not(@cat_id = $stored_cat_nodes/value)][$curpos - $stored_cat_count]/@cat_id" />
							</xsl:if>
							<xsl:if test="@epi != 0">
								<xsl:value-of select="/myedbroot/categories/category[ @cat_id = $catpropval]/@cat_id" />
								<!-- or could just do <xsl:value-of select="$catpropval" /> -->
							</xsl:if>
						</xsl:variable>
						<!--<xsl:apply-templates select="./validator/select"/>-->
						<xsl:if test="/myedbroot/categories/category[@cat_id = $curcatid]/@is_disabled != 1" >
									<input type="hidden"   style="display:none">
										<xsl:attribute name="id"><xsl:value-of select="@ffi" />_stored</xsl:attribute>
										<xsl:attribute name="value"><xsl:value-of select="value" /></xsl:attribute>
									</input>
									<input type="checkbox"   style="display:none">
										<xsl:attribute name="name"><xsl:value-of select="@ffi" /></xsl:attribute>
										<xsl:attribute name="id"><xsl:value-of select="@ffi" /></xsl:attribute>
										<xsl:attribute name="value"><xsl:value-of select="$curcatid" /></xsl:attribute>
										<xsl:if test="@epi != 0">
											<xsl:attribute name="checked"></xsl:attribute>
										</xsl:if>
									</input>
				
									<input type="checkbox" name="props_to_delete[]"  style="display:none">
										<xsl:attribute name="value">pid<xsl:value-of select="@prop_id"/>rid<xsl:value-of select="@ron" />
										</xsl:attribute>
										<xsl:attribute name="id"><xsl:value-of select="@ffi" />_del</xsl:attribute>
									</input>


							<!-- not used	<script>
									cat_subcat_ins[<xsl:value-of select="$curcatid" />] = new Array();
									cat_subcat_dels[<xsl:value-of select="$curcatid" />] = new Array();
								</script>-->
							
							<!--	 <xsl:for-each select="key('prop_list_by_name','Subcategory')">
										<xsl:sort select="@ron" order="ascending" data-type="number"/> needs to be sorted by ron so that $subcat_curpos never is less than $stored_subcat_count. see below-->
									<!--	<xsl:variable name="subcatpropval" select="value" />
										<xsl:variable name="subcat_curpos" select="position()" />-->
										<!-- below variables takes 10 seconds -->
									<!--	<xsl:variable name="cursubcatval">
											<xsl:if test="@epi = 0">
												<xsl:value-of select="$unstored_subcats[$subcat_curpos - $stored_subcat_count]/@subcat_name" />
											</xsl:if>
											<xsl:if test="@epi != 0">
												<xsl:value-of select="key('subcategory_by_id', $subcatpropval)/@subcat_name" />
											</xsl:if>
										</xsl:variable>
										<xsl:variable name="cursubcatid">
											<xsl:if test="@epi = 0">--><!--$subcat_curpos will never be less than $stored_subcat_count because epi==0 nodes always come first-->
											<!--	<xsl:value-of select="$unstored_subcats[$subcat_curpos - $stored_subcat_count]/@subcat_id" />
											</xsl:if>
											<xsl:if test="@epi != 0">
												<xsl:value-of select="key('subcategory_by_id', $subcatpropval)/@subcat_id" />
											</xsl:if>
										</xsl:variable>-->
										<!-- below if statement takes 3-5 seconds -->
									<!--	<xsl:if test="($curcatid = key('subcategory_by_id', $cursubcatid)/@cat_id) 
												and key('subcategory_by_id', $cursubcatid)/@is_disabled != 1">-->
										<!--<xsl:if test="($curcatid = /myedbroot/subcategories/subcategory[@subcat_id = $cursubcatid]/@cat_id) 
												and /myedbroot/subcategories/subcategory[@subcat_id = $cursubcatid]/@is_disabled != 1">-->
										
										<!-- I think this part is not needed?? 	
											<input type="hidden"   style="display:none">
												<xsl:attribute name="id"><xsl:value-of select="@ffi" />_stored</xsl:attribute>
												<xsl:attribute name="value"><xsl:value-of select="value" /></xsl:attribute>
											</input>
												<script>
													cat_subcat_ins[<xsl:value-of select="$curcatid" />].push( '<xsl:value-of select="@ffi" />');
												</script>
												<xsl:if test="number(value) &gt; 0">
												<script>
													cat_subcat_dels[<xsl:value-of select="$curcatid" />].push( '<xsl:value-of select="@ffi" />_del');
												</script>
												</xsl:if>
											-->
											<!--<input type="checkbox"  style="display:none" >
												<xsl:attribute name="name"><xsl:value-of select="@ffi" /></xsl:attribute>
												<xsl:attribute name="id"><xsl:value-of select="@ffi" /></xsl:attribute>
												<xsl:attribute name="value"><xsl:value-of select="$cursubcatid" /></xsl:attribute>
												<xsl:if test="@epi != 0">
													<xsl:attribute name="checked"></xsl:attribute>
												</xsl:if>
											</input>
						
											<input type="checkbox" name="props_to_delete[]"  style="display:none" >
												<xsl:attribute name="value">pid<xsl:value-of select="@prop_id"/>rid<xsl:value-of select="@ron" />
												</xsl:attribute>
												<xsl:attribute name="id"><xsl:value-of select="@ffi" />_del</xsl:attribute>
											</input>
											
										</xsl:if>
								</xsl:for-each>-->
						</xsl:if>
		 </xsl:for-each>
		 <xsl:apply-templates select="/myedbroot/record/property[@prop_id=50]" mode="subcat_hidden_fields">
		 	<xsl:with-param name="unstored_subcats" select="$unstored_subcats" />
		 	<xsl:with-param name="stored_subcat_count" select="$stored_subcat_count" />
		 	<xsl:sort select="@ron" order="ascending" data-type="number" />
		 </xsl:apply-templates>
				</td>
</tr>

</xsl:template>
</xsl:stylesheet>