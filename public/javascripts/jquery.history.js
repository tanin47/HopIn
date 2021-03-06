/**
 * @license 
 * jQuery Tools 1.2.5 History "Back button for AJAX apps"
 * 
 * NO COPYRIGHTS OR LICENSES. DO WHAT YOU LIKE.
 * 
 * http://flowplayer.org/tools/toolbox/history.html
 * 
 * Since: Mar 2010
 * Date:    Wed Sep 22 06:02:10 2010 +0000 
 */
(function($) {
		
	var hash="", iframe, links, inited;		
	
	$.tools = $.tools || {version: '1.2.5'};
	
	$.tools.history = {
	
		init: function(els) {
			
			if (inited) { return; }
			
			// IE
			if ($.browser.msie && $.browser.version < '8') {
				
				// create iframe that is constantly checked for hash changes
				if (!iframe) {
					iframe = $("<iframe/>").attr("src", "javascript:false;").hide().get(0);
					$("body").append(iframe);
									
					setInterval(function() {
						var idoc = iframe.contentWindow.document, 
							 h = idoc.location.hash;
					
						if (hash !== h) {						
							$.event.trigger("hash", h);
						}
					}, 100);
					
					setIframeLocation(location.hash || '#');
				}

				
			// other browsers scans for location.hash changes directly without iframe hack
			} else { 
				setInterval(function() {
					var h = location.hash;
					if (h !== hash) {
						$.event.trigger("hash", h);
					}						
				}, 100);
			}

			links = !links ? els : links.add(els);
			
			els.click(function(e) {
				var href = $(this).attr("href");
				if (iframe) { setIframeLocation(href); }
				
				// handle non-anchor links
				if (href.slice(0, 1) != "#") {
					location.href = "#" + href;
					return e.preventDefault();		
				}
				
			}); 
			
			inited = true;
		}	
	};  
	

	function setIframeLocation(h) {
		if (h) {
			var doc = iframe.contentWindow.document;
			doc.open().close();	
			doc.location.hash = h;
		}
	} 
		 
	// global histroy change listener
	$(window).bind("hash", function(e, h)  { 

		var url = h.replace("#", "");
		if (h) {
			var from_hash = $.url.parse(url);
			
			links.filter(function() {
			  var href = $(this).attr("href");
			  
			  var tab_link = $.url.parse(href);

				if (tab_link.path == from_hash.path)
				{
					if (tab_link.params.member_key == from_hash.params.member_key)
						return true;
					else
					{
						location.href = from_hash.path + "?member_key="+tab_link.params.member_key+"&time="+(new Date()).getTime();
					}
				}
				else
				{
					return false;
				}
			}).trigger("history", [url]);	
		} else {
			links.eq(0).trigger("history", [url]);	
		}

		hash = h;

	});
		
	
	// jQuery plugin implementation
	$.fn.history = function(fn) {
			
		$.tools.history.init(this);

		// return jQuery
		return this.bind("history", fn);		
	};	
		
})(jQuery); 

