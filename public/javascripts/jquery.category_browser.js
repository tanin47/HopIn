(function($){
	
	function set_category_browser_content(id)
	{
		if ($.category_browser_loading) return;
		$.category_browser_loading = true;
		
		$('#more_category_'+id).html('');
		$('#more_category_'+id).addClass('more_category_loading');
		
		$.post('/category/browse',{parent_id:id},function (data) {

			$('#category_select_box .category_container').css({overflow:"hidden"});
			var panel = $('#category_select_box .category_container #category_list');
			
			var w = 392;
			
			var left = w;
			var scroll = w;
			var last_div = null;
			if ($('.category_block',panel).length > 0) 
			{
				last_div = $('.category_block',panel)[$('.category_block',panel).length-1];
				left = $(last_div).position().left + $(last_div).outerWidth();
				scroll = $(last_div).outerWidth();
			}
				
			var parent_label = "";
				
			var str = '<div class="category_block" style="position:absolute;left:'+left+'px;top:0px;width:'+w+'px;"><span class="category_navigator allaround_p-1 dark_gray">';
			str += "<a href='#' onclick='$.category_browser_back("+data.parents.length+");return false;'>Root</a> &gt; ";
			for (var i=0;i<data.parents.length;i++)
			{
				parent_label += data.parents[i].name + " &gt; ";
				str += "<a href='#' onclick='$.category_browser_back("+(data.parents.length-i-1)+");return false;'>" + data.parents[i].name + "</a> &gt; ";
			}					
			str += '</span><div class="category_list" style="height:180px;overflow:auto;"><ul>';
			for (var i=0;i<data.children.length;i++)
			{
				str += '<li onclick="$.category_browser_select(' + data.children[i].id + ',\''+parent_label+''+data.children[i].name+'\');">' + data.children[i].name;
				
				if (data.children[i].has_child) {
					str += ' <span id="more_category_' + data.children[i].id + '" class="more_category" onclick="$.category_browser_next(' + data.children[i].id + ');event.stopPropagation();">&gt;</span>';
				}
				str += '</li>';
			}
			str += '</ul></div></div>';
			
			$(panel).append(str);
			
			$('#category_select_box_loading').hide();
			$('#category_select_box .category_container  #category_list').show();

			$(panel).animate({
			    left: '-='+scroll
			  }, 500,'linear', function() {
			  	$('#more_category_'+id).removeClass('more_category_loading');
				$('#more_category_'+id).html('&gt;');
				$(last_div).hide();
			    $('#category_select_box .category_container').css({overflow:"auto"});
				
				$.category_browser_loading = false;
			  });

		},"json");
	}

 	$.fn.extend({ 
 		
 		category_browser: function(callBackfunction) {

    		return this.each(function() {
				var parent = $(this).parent();
				if ($('#category_select_box_overlay').length == 0) {
					$(parent).append('<div id="category_select_box_overlay" class="category_select_box_overlay_hide"></div>');
					$('#category_select_box_overlay').click(function() { $(document).trigger('close.category_browser') })
				}
				
				if ($('.category_select_box', parent).length == 0) {
					$(parent).css({position:"relative"});
					$(parent).append(' \
						<div id="category_select_box" class="category_select_box"  style="position:absoulte;left:0px;top:10px;display:none;"> \
							<div class="category_container">  \
						        <div id="category_select_box_loading" style="display:none;text-align:center;"> \
									<img src="/images/small-ajax-loader.gif"> \
								</div> \
								<div id="category_list" style="display:none;position:absolute;"> \
									\
								</div> \
						    </div> \
						</div> \
					');
				}
				
				$('#category_list').html('');
				$('#category_list').css({left:0});
				
				$('#category_select_box_overlay').addClass('category_select_box_overlay_show');
				
				$('#category_select_box_loading').show();
				$('#category_select_box .category_container #category_list').hide();
				
				$('#category_select_box').show();

				set_category_browser_content(0);
				
				$.extend({ 
					category_browser_select: function(category_id, category_label){
						
						if (callBackfunction == null
							|| callBackfunction == undefined)
						{
							alert("callBackfunction is not defined.\r\n category_id="+category_id+", label='"+category_label+"'");
							return;
						}
						
						callBackfunction(category_id, category_label);
						$(document).trigger('close.category_browser');
					}
				});

    		});
    	}
	});
	
	$.extend({ 
		category_browser_loading: false,
		category_browser_next: function(id) {
			set_category_browser_content(id);
		},
		
		category_browser_back: function(step) {
			$('#category_select_box .category_container').css({overflow:"hidden"});
			
			var scroll = 0;
			var panel = $('#category_select_box .category_container #category_list');
			var blocks = $('.category_block',panel);
			for (var i=0;i<step;i++)
			{
				scroll += $(blocks[blocks.length-i-2]).outerWidth();
				$(blocks[blocks.length-i-2]).show();
			}

			$(panel).animate({
			    left: '+='+scroll
			}, 500,'linear', function() {
				
			  	for (var i=0;i<step;i++)
				{
					$(blocks[blocks.length-i-1]).remove();
				}
				
				$('#category_select_box .category_container').css({overflow:"auto"});
			});
		}
	});
	
  	$(document).bind('close.category_browser', function() {
		$('#category_select_box').fadeOut('fast',function () {
			$('#category_select_box_overlay').removeClass('category_select_box_overlay_show');
		});
	  })
	
})(jQuery);