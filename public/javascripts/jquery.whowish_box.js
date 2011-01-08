(function($){

 	$.extend({ 
 		
		//pass the options variable to the function
 		whowish_box: function(options){
			
			if ($('#whowish_box').length == 0) {
				
				$("body").append(' \
					<div class="whowish_box" id="whowish_box"> \
						<div class="whowish_box_container"> \
							<div class="whowish_box_headline whowish_green_bg"> \
								<span class="whowish_box_name">Unknown</span> \
								<span class="whowish_box_close_button light_gray_bg"></span> \
							</div> \
							<div class="whowish_box_content"> \
								\
							</div> \
							<div id="whowish_box_loading" style="display:block;text-align:center;"> \
								<img src="/images/ajax-loader.gif"> \
							</div> \
						</div> \
					</div> \
				');
				
//				if ($('#whowish_box_overlay').length == 0) {
//					$("body").append('<div id="whowish_box_overlay" class="whowish_box_overlay_hide"></div>')
//				}
				
				$('#whowish_box .whowish_box_close_button').click(function() { $(document).trigger('close.whowish_box') })
				//$('#whowish_box_overlay').click(function() { $(document).trigger('close.whowish_box') })

			}
			
			$('#whowish_box .whowish_box_name').html(options.title);
			
			$.whowish_box_load();
			
			var scrolls = $.get_page_scroll();
			$('#whowish_box').css({
				"top":(scrolls[1]+10)+"px",
				"left":(($(window).width()-$('#whowish_box').width())/2)+"px"
			});
			
			$('#whowish_box').fadeIn('fast',function() {
				//$('#whowish_box_overlay').addClass('whowish_box_overlay_show');
			});
			

			$.get(options.url,{is_whowish_box:"true"}, function(data) {
			  $('#whowish_box .whowish_box_content').html(data +
			  	'	<script language="javascript"> \
						$("#whowish_box .whowish_box_content").show(); \
						$("#whowish_box #whowish_box_loading").hide();\
					</script>\
				');	
			  
			  	var scrolls = $.get_page_scroll();
				$('#whowish_box').css({
					"top":(scrolls[1]+10)+"px",
					"left":(($(window).width()-$('#whowish_box').width())/2)+"px"
				});
			});

		},
		
		whowish_box_load: function() {
			$('#whowish_box .whowish_box_content').hide();
			$('#whowish_box #whowish_box_loading').show();
		},
		
		get_page_scroll: function() {
		    var xScroll, yScroll;
		    if (self.pageYOffset) {
		      yScroll = self.pageYOffset;
		      xScroll = self.pageXOffset;
		    } else if (document.documentElement && document.documentElement.scrollTop) {	 // Explorer 6 Strict
		      yScroll = document.documentElement.scrollTop;
		      xScroll = document.documentElement.scrollLeft;
		    } else if (document.body) {// all other Explorers
		      yScroll = document.body.scrollTop;
		      xScroll = document.body.scrollLeft;
		    }
		    return new Array(xScroll,yScroll)
		}
	});
	
	  $(document).bind('close.whowish_box', function() {
		$('#whowish_box').fadeOut('fast',function () {
			$('#whowish_box .whowish_box_content').html('');
			//$('#whowish_box_overlay').removeClass('whowish_box_overlay_show');
		});
	  })
	
})(jQuery);
