(function($){

 	$.fn.extend({ 
 		
		//pass the options variable to the function
 		loading_button: function(enabled,options) {


			//Set the default values, use comma to separate the settings, example:
			var defaults = {
				image : '<img src="/images/button_loader.gif">',
				word: 'Loading'
			}
				
			var options =  $.extend(defaults, options);

    		return this.each(function() {
				
				if (enabled == true)
				{
					var inside_content = $(this).html();
					
					$(this).html(options.image + " " + options.word);
					$(this).append('<span class="loading_button_hidden_div" style="display: none;">'+inside_content+'</span>');
				}
				else
				{
					var hidden_div = $('.loading_button_hidden_div',this);
					
					if (hidden_div.length == 0) return;
					
					$(this).html($(hidden_div).html());
				}
			
    		});
    	}
	});
	
})(jQuery);

