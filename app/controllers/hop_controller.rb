class HopController < ApplicationController
  def index
    @show_wait_message = false
    @wait_time = 0
    # Try to get last hop
    @new_hop = Hop.last(:conditions=>{:facebook_id=>$facebook.user_id,:bus_id=>params[:bus_id]})
    
    bus = Bus.first(:conditions=>{:id=>params[:bus_id]})

    if @new_hop.nil?
      interval_time = (3600) + 1 
    else
      interval_time = Time.now - @new_hop.created_date
    end
    
    if interval_time > 3600
      # Create new records in DB
      @new_hop = Hop.new
      @new_hop.facebook_id = $facebook.user_id
      @new_hop.bus_id = bus.id
      @new_hop.bus_owner_facebook_id = bus.facebook_id
      @new_hop.comment = ""
      @new_hop.created_date = Time.now
      @new_hop.amount = 1.23
      @new_hop.save
    else
      @show_wait_message = true
      @wait_time = ((@new_hop.created_date + 3601) - Time.now) / 60
    end
    
    begin
      $facebook.publish_hop(@new_hop)
    rescue
      @redirect_url = "http://www.facebook.com/dialog/oauth/?" +
                  "client_id=" + APP_ID +
                  "&scope=publish_stream" +
                  "&redirect_uri=http://apps.facebook.com/wehopin/hop/publish?hop_id="+@new_hop.id.to_s
      render "redirect/index"
    end
  end
  
  def publish
    @hop = Hop.first(:conditions=>{:id=>params[:hop_id]})
    $facebook.publish_hop(@hop)
  end
  
  def save
    @new_hop = Hop.first(:conditions=>{:id => params[:hop_id]})
    @new_hop.comment = params[:comment]
    if !@new_hop.save
      render :json => {:ok=>false,:error_message=>@new_hop.errors }
      return
    end
    render :json => {:ok=>true}
  end
end
