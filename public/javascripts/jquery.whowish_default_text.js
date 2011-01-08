(function($){

 	$.fn.extend({ 
 		
		//pass the options variable to the function
 		whowish_default_text: function(options) {


			//Set the default values, use comma to separate the settings, example:
			var defaults = {
				inactive_class : "",
				inactive_text : ""
			}
				
			var options =  $.extend(defaults, options);

    		return this.each(function() {
				var o = options;
				
				$(this).focus(function(srcc)
			    {
			        if ($(this).val() == o.inactive_text)
			        {
			            $(this).removeClass(o.inactive_class);
			            $(this).val("");
			        }
			    });
			    
			    $(this).blur(function()
			    {
			        if ($(this).val() == ""
						|| $(this).val() == o.inactive_text)
			        {
			            $(this).addClass(o.inactive_class);
			            $(this).val(o.inactive_text);
			        }
			    });
			    
			    $(this).blur();  
			
    		});
    	}
	});
	
})(jQuery);

