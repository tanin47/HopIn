(function($){

 	$.fn.extend({ 
 		
		// text : can be a string or an array of string.
		// If it is an array of string, it will be rendered with <ul>
 		ruby_error: function(text,isShown) {

    		return this.each(function() {
				
				if (text == "")
				{
					isShown = false;
				}
				
				if ($.isArray(text))
				{
					if (text.length == 0)
					{
						isShown = false;
					}
					else if (text.length > 1) {
						var str = "<ul>";
						
						for (var i = 0; i < text.length; i++) {
							str += "<li>" + text[i] + "</li>"
						}
						
						str += "</ul>"
						text = str;
					}
					else
					{
						text = text[0];
					}
				}
				
				if (isShown) {
					if ($("#" + this.id + "_warning").length > 0) {
						$("#" + this.id + "_warning").html(text);
						$("#" + this.id + "_warning").show();
					}
					else {
						var parent = $(this).parent();	
						
						var offset = $(this).relative_offset($(parent));
						var height = $(this).height();
						var width = $(this).width();
						
						var top = ((height-24)/2);
											
						$(this).after(' <br/>\
							<div id="' + this.id + '_warning" class="triangle-border top"> \
								'+text+' \
							</div>\
						');
					}
				}
				else
				{
					if ($("#" + this.id + "_warning").length > 0) {
						$("#" + this.id + "_warning").hide();
					}
				}
    		});
    	}
	});
	
})(jQuery);