// JavaScript Document


	//requires searchrestbl_url is set
    function revealDiv(n)
    { //alert ("yoooho"); return;
		cur_page_no = n;
		var d = new Date();
		var loc_search_url;
    //    for (var count = 1; count &lt;= n_pages; count++) { //alert(document.getElementById("page"+count).innerHTML);
    //      document.getElementById("page"+count).style.display = 'none';
    //    }
    //    document.getElementById("page"+n).style.display = 'block';
		//$("target").innerHTML = "<center>Getting Search results...</center>";
		jQuery("#target").html("<center>Getting Search results...</center>");
		//alert("starting ajax get!");
	//	HTML_AJAX.replace("searchresultsdiv", '?target_component[]=RecordIniFacade&amp;target_function[]=filtered_search_by_mixed_criteria&amp;pgn='+n+'&amp;OF_passthru=admin_product_search_results');
		loc_search_url = searchrestbl_url+'&pgn='+n+'&nocache=' + d.getMilliseconds();
		HTML_AJAX.grab(loc_search_url, grabCallback_handleResultsTable);
		//document.getElementById("hidethisdiv").style.display = 'none';
    //HTML_AJAX.replace('target', '?target_component[]=RecordIniFacade&amp;target_function[]=donothing&amp;output_function=output_html&amp;pageID='+n);

/*<!--    HTML_AJAX.replace('target', '?target_component[]=RecordIniFacade&amp;target_function[]=initializeRecordSet<xsl:for-each 
	select="//records/record">&amp;eids[]=<xsl:value-of select="@eid" /></xsl:for-each>&amp;type_id=<xsl:for-each 
	select="//records/record[position() = 1]"><xsl:value-of select="@type_id" /></xsl:for-each>&amp;output_function=output_html&amp;pageID='+n);
-->*/

    }
	function grabCallback_handleResultsTable(result)
	{
		var d = new Date();
		//alert ("nav"+result);
		$("searchresultsdiv").innerHTML = result;
		HTML_AJAX.grab('?target_component[]=RecordIniFacade&target_function[]=donothing&output_function=output_html&pageID='+cur_page_no+'&nocache='+d.getMilliseconds(),		grabCallback_handle2);
	
		if ($("target").innerHTML.trim() !== "")
		{ 
		//	$("target").style.display = "block";
		//	$("target").style.backgroundColor = "1133CC";
		//	$("target").style.textAlign = "center";
		}
		//this needs to be fixed. Theoretically, with multiple (same brand) browsers open, if user exports, they will export the session search results of another browser
		jQuery("#launch_searchres_csv").html('<a  target="_blank" href="index.php?target_component[]=RecordIniFacade&target_function[]=filtered_search_by_mixed_criteria_csv&OF_passthru=hash_to_csv">Export CSV</a>');
	}

	function grabCallback_handle2(result)
	{
		//alert ("nav"+result);
		$("target").innerHTML = result;
	}
