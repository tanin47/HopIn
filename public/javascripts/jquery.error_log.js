/**
 * @author Tanin
 */
(function($){

 	$.extend({ 
 		
		//pass the options variable to the function
 		error_log: function(identifier, description) {
			try {
				$.post('/error', {
					"identifier": identifier,
					"description": description
				}, function(data){
				
				}, "json");
			} catch (e)
			{
				
			}
		}
		
	});
	
})(jQuery);


$(document).ajaxError(function(e, xhr, settings, exception) {
	if (settings.url == "/error") return;
  	$.error_log(settings.url,"Data sent: " + settings.data + "\r\n\r\n Response text:\r\n " + xhr.responseText);
  	alert('Cannot connect to whoWish server. Please try again in a moment.');
});