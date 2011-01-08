(function($){

 	$.fn.extend({ 
 		
		//pass the options variable to the function
 		relative_offset: function(parent) {

			if (parent == null)
			{
				return $(this).offset();
			}
			else
			{
				var parentOffset = jQuery(parent).offset();
				
				var offset = jQuery(this).offset();
				
				return {left : offset.left - parentOffset.left, top: offset.top - parentOffset.top};
			}
    	}
	});
	
})(jQuery);