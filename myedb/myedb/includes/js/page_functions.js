// JavaScript Document
String.prototype.trim = function() {
	return this.replace(/^\s+|\s+$/g,"");
}

function showlaptop(theTable)
{
     if (document.getElementById(theTable).style.display == 'none')
     {
          document.getElementById(theTable).style.display = 'block';
     } 
}

function hidelaptop(theTable)
{
     if (document.getElementById(theTable).style.display == 'none')
     {
          document.getElementById(theTable).style.display = 'none';
     }
     else
     {
          document.getElementById(theTable).style.display = 'none';
     }
}
//see http://beebole.com/pure/documentation/using-js-functions-with-directives/
myDirective =
	{
		//'ol.subcatsol li':
		'li':
		{
			'player<-':
			{
				  ".subcatahref": 'player.0',
				 // ".who@title": "See the tweets of #{player.0}",
				  ".subcatahref@href+": 
				  		function(a)
						{ 
					     return "("+a.pos+")"; 
						} 

			}
		}

	}
cat_directive = 
	{
		//	'.who':'who2.name',
			'.cat_ahref@title':'Search for #{cat_ahref}',
			'.cat_ahref@href+':'(#{cat_ahref2.cat_id_ah})'
		
	}
cat_directive_empty = 
	{
		//	'.who':'who2.name',
			'.cat_ahref@title':'#{empty_str}'
		//	'.cat_ahref@href':'empty_str'
		
	}
	cat_data={
	/*		friend:[
				{
					name:'Hughes', 
					twitter:'hugheswaroquier'
				},{
					name:'Yves', 
					twitter:'yveshiernaux'
				}
			], */
			//cat_ahref:'donor',
			lbl_cat_title: 'Category: ',
			lbl_subcat_title: 'Subcategories: ',
			cat_ahref2:{
				name:'Mic', 
				cat_id_ah:'tchvil'
			}
		};

	cat_data_empty={
			empty_str: '',
			cat_ahref: '',
			lbl_cat_title: 'Category: ',
			lbl_subcat_title: '',
			cat_ahref2:{
				name:'Mic', 
				cat_id_ah:'tchvil'
			}
	}
rendercnt = 0;
subcatsolhtml = "";
cat_ahref_restore= "";
		function myautorender(cat_id, cat_val)
		{
			//var template = jQuery('ol.subcatsol');
			var template = $$('ol.subcatsol')[0];
			//pure.libs["jquery"](); //jquery doesn't seem to work with pure in ie
	//		var template = jQuery('div.dir_search_div');
			//to prevent list stacking up html and data
			if (rendercnt == 0)
			{
				subcatsolhtml = jQuery('ol.subcatsol').html();
				cat_ahref_restore = jQuery('div.friends #cat_ahref_id').attr('href');
			}
			else
			{ //clear out list
				jQuery('ol.subcatsol').html(subcatsolhtml);
				jQuery('div.friends #cat_ahref_id').attr('href',cat_ahref_restore);
			}
			rendercnt++;

				var handlerURL = "/index.php?target_component[]=ClientServerDataOps&target_function[]=initialize_sub_lookup_table_json&table_name=subcategory&OF_passthru=echo_serialized_data&cat_id="+cat_id;
			var div = jQuery('#public_center_content');
			div.slideUp
			  ('slow', 
						function () 
						{ 
							//var resdiv = jQuery('#searchresultsdiv');
							//resdiv.html("");
							//jQuery('#target').html("");
							jQuery('#public_center_content').html("");
							jQuery.ajax( { 
								type: "GET", 
								url: handlerURL, 
								dataType: "json", 
								timeout: 7000,
								success: function(data){ //alert(data.length);
									//alert(" still in function");
										//var awho = jQuery('div.friends');
										var awho = $$('div.friends')[0]; //alert(awho.length);
										if (typeof(data) !== 'undefined' && data != null) 
										{
											if (data.length!=0)
											{
												cat_data.cat_ahref2.cat_id_ah = cat_id;
												cat_data.cat_ahref = cat_val;
												awho.autoRender(cat_data, cat_directive);
												
												template.autoRender( data , myDirective );
												jQuery('#pub_search_res_div_msg').html(" <br />");
											}
											else
											{
												jQuery('#pub_search_res_div_msg').html("No subcategories found");
												cat_data_empty.cat_ahref2.cat_id_ah = cat_id;
												cat_data_empty.cat_ahref = cat_val;
												awho.autoRender(cat_data_empty, cat_directive);
											}
										}
										else
										{
        										jQuery('#pub_search_res_div_msg').html("There was a connection error."); 
										}
									},
								error: function(XMLHttpRequest, textStatus, errorThrown){ 
        										jQuery('#pub_search_res_div_msg').html("There was an error; request timed out."); 
											}

										} ); 
							 div.slideDown('fast');
						} 
				); // you may want this to be fast
		
		}
		function getandputsubcats_public(cat_id, cat_val)
		{
			jQuery('#pub_search_res_div_msg').html("Searching...");
			//jQuery("#pub_search_res_div_msg").ajaxError(function(event, request, settings){   jQuery(this).append("<li>Error requesting page " + settings.url + "</li>");alert("yo error"); });
	//		jQuery(document).ajaxError(function(event, request, settings){ alert("Error"); });
			myautorender(cat_id, cat_val);
		}
		
		function getandputsubcats_publicOld2()
		{
			var div = jQuery('#public_center_content');
			div.slideUp
			  ('slow', 
						function () 
						{
										  
							div.html("<div id='images'>ioio</div><div class='wrapper'><ol id='listcols'   ></ol><br id='listcolsend' /></div><!-- .wrapper -->");
							jQuery.getJSON("/index.php?target_component[]=ClientServerDataOps&target_function[]=initialize_sub_lookup_table_json&table_name=subcategory&OF_passthru=echo_serialized_data&cat_id=13",
								function(data)
								{
						/*		  jQuery.each
								  (data.items, 
										function(i,item)
										{
											jQuery("<img/>").attr("src", item.media.m).appendTo("#images");   // div.html(i+"ha");
											if ( i == 3 ) return false;
										}
									);
							*/	  
									//var myArray = {abc: 200, "x y z": 300};
									
									//for(key in myArray)
									jQuery.each
									(data,
									 	function(key, data_keyitem)
										{
									   	//	document.write();
											var subcatidkey = "subcatid"+key;
											jQuery("<li />").attr("id",subcatidkey).appendTo("#listcols");   // div.html(i+"ha");
											jQuery("<a />").attr("href", "http://yahoo.com?"+key).appendTo("#"+subcatidkey).text(data_keyitem["0"]); 
									//		jQuery("<label>").html("key " + key
									//		 + " has value "
									//		 + data_keyitem["0"] + "<br>").appendTo("#images");   // div.html(i+"ha");
										}				
								  	);
								 }
							 );
							 div.slideDown('slow');
						} 
				); // you may want this to be fast
		}

		function getandputsubcats_publicOld()
		{ 
			var div = jQuery('#public_center_content');
			div.slideUp
			  ('slow', 
						function () {
										  
							div.html("<div id='images'>ioio</div>");
							jQuery.getJSON("http://api.flickr.com/services/feeds/photos_public.gne?tags=cat&tagmode=any&format=json&jsoncallback=?",
								function(data)
								{
								  jQuery.each
								  (data.items, 
										function(i,item)
										{
											jQuery("<img/>").attr("src", item.media.m).appendTo("#images");   // div.html(i+"ha");
											if ( i == 3 ) return false;
										}
									);
								 }
							 );
									  
							 div.slideDown('slow');
						} 
				); // you may want this to be fast
			
		//	
			
		}

function printStackTrace() {  
   var callstack = [];  
   var isCallstackPopulated = false;  
   try {  
     i.dont.exist+=0; //doesn't exist- that's the point  
   } catch(e) {  
     if (e.stack) { //Firefox  
       var lines = e.stack.split('\n');  
       for (var i=0, len=lines.length; i<len; i++) {  
         if (lines[i].match(/^\s*[A-Za-z0-9\-_\$]+\(/)) {  
           callstack.push(lines[i]);  
         }  
       }  
       //Remove call to printStackTrace()  
       callstack.shift();  
       isCallstackPopulated = true;  
     }  
     else if (window.opera && e.message) { //Opera  
       var lines = e.message.split('\n');  
       for (var i=0, len=lines.length; i<len; i++) {  
         if (lines[i].match(/^\s*[A-Za-z0-9\-_\$]+\(/)) {  
           var entry = lines[i];  
           //Append next line also since it has the file info  
           if (lines[i+1]) {  
             entry += " at " + lines[i+1];  
             i++;  
           }  
           callstack.push(entry);  
         }  
       }  
       //Remove call to printStackTrace()  
       callstack.shift();  
       isCallstackPopulated = true;  
     }  
   }  
   if (!isCallstackPopulated) { //IE and Safari  
     var currentFunction = arguments.callee.caller;  
     while (currentFunction) {  
       var fn = currentFunction.toString();  
       var fname = fn.substring(fn.indexOf("function") + 8, fn.indexOf('')) || 'anonymous';  
       callstack.push(fname);  
       currentFunction = currentFunction.caller;  
     }  
   }  
   output(callstack);  
 }  
    
 function output(arr) {  
   //Optput however you want  
   alert(arr.join('\n\n'));  
 } 
