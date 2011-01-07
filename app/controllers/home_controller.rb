class HomeController < ApplicationController
  skip_before_filter :decode_signed_request, :only=>[:permission_dialog]
  
  def index
    

  end
end
