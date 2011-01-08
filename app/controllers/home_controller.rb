class HomeController < ApplicationController
  skip_before_filter :decode_signed_request, :only=>[:permission_dialog]
  
  def index
    bus = Bus.create(
                    :name=>"Red Cross",
                    :thumbnail_path=>"bus_1.jpg",
                    :why=>"I just want to...",
                    :amount=>1234,
                    :capacity=>100,
                    :parent_bus_id=>0,
                    :facebook_id=>$facebook.user_id,
                    :deadline=>nil,
                    :currency_code=>"USD",
                    :hops=>0,
                    :status=>"ACTIVE",
                    :created_date=>Time.now
                    )
                    
    begin
      $facebook.publish_bus(bus)
    rescue
      @redirect_url = "http://www.facebook.com/dialog/oauth/?" +
                  "client_id=154941261222060" +
                  "&scope=publish_stream,user_photos" +
                  "&redirect_uri=http://apps.facebook.com/wehopin/"
      redirect_to :controller=>:redirect,:action=>:index
    end
  end
end
