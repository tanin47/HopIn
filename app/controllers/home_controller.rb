class HomeController < ApplicationController

  skip_before_filter :require_basic_information_permission, :only=>[:index]


  def index
<<<<<<< HEAD
    
=======
    $facebook.all_friends
  
  end
  
  def test
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
                  "client_id=" + APP_ID +
                  "&scope=publish_stream" +
                  "&redirect_uri=http://apps.facebook.com/wehopin/bus/test"
      render "redirect/index"
    end
>>>>>>> 29502e32b5b06d483aa0db17d45014505c582267
  end
end
