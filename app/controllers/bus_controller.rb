class BusController < ApplicationController
 
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
    @bus.facebook_id = params[:facebook_id]
    @bus.deadline = params[:deadline]
    @bus.currency_code = params[:currency_code]
    @bus.hops = 0
    @bus.status = Bus::STATUS_ACTIVE
    @bus.created_date = Time.now
    
    
    if !@bus.save
      render :json => {:ok=>false, :error_message=>format_error(@bus.errors)}
      return
    end
    
    render :json=>{:ok=>true ,:new_row=>render_to_string(:partial=>"row",:locals=>{:bus=>@bus})}
    
  end
  


end
