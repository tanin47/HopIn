class BusController < ApplicationController
  #skip_before_filter :decode_signed_request, :only=>[:add]
  #skip_before_filter :require_basic_information_permission, :only=>[:add]
 def test
   end
 
  def index
    @currencies = Currency.all()
  end
  
  
  def add
    @bus = Bus.new()
    @bus.name = params[:name]
    @bus.thumbnail_path = params[:thumbnail_path]
    @bus.why = params[:why]
    @bus.amount = params[:amount]
    @bus.capacity = params[:capacity]
    print $facebook.user_id
    @bus.facebook_id = $facebook.user_id
    @bus.deadline = params[:deadline]
    @bus.currency_code = params[:currency_code]
    @bus.hops = 0
    @bus.status = Bus::STATUS_ACTIVE
    @bus.created_date = Time.now
    
    
    if !@bus.save
      render :json => {:ok=>false, :error_message=>format_error(@bus.errors)}
      return
    end
    
    render :json=>{:ok=>true, :html=>(render_to_string :action=>:save_success),:return_view=>"save_success"}
    
  end
  
  def save_success
   
  end

end