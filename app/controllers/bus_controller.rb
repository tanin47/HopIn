class BusController < ApplicationController
  include PaypalHelper
  
  skip_before_filter :decode_signed_request, :only=>[:cancel_payment]
  skip_before_filter :require_basic_information_permission, :only=>[:paid]
 
  def index
    @currencies = Currency.all()
  end
  
  
  def add
    @bus = Bus.new()
    @bus.name = params[:name]
   
    
    
    
    @bus.why = params[:why]
    @bus.amount = params[:amount]
    @bus.capacity = params[:capacity]
    
    @bus.facebook_id = $facebook.user_id
    
    if params[:mode] == Bus::MODE_OFFICIAL
      @bus.mode = Bus::MODE_OFFICIAL
      @bus.charity_id = params[:charity_id]
    else
      @bus.mode = Bus::MODE_AMATEUR
    end
    
    @bus.deadline = params[:deadline]
    @bus.currency_code = Currency::USD
    @bus.hops = 0
    @bus.status = Bus::STATUS_ACTIVE
    @bus.created_date = Time.now
    
    
    if !@bus.save
      render :json => {:ok=>false, :error_message=>format_error(@bus.errors)}
      return
    end
   
    if params[:thumbnail_path] != ""
      print params[:thumbnail_path]
      image_name = params[:thumbnail_path]
      ext = File.extname( image_name ).sub( /^\./, "" ).downcase
      
      new_img_name = "thumb_bus_" + @bus.id.to_s + "." + ext
      
      require 'ftools'
      
      begin
        File.copy("public/uploads/temp/"+image_name,"public/uploads/bus/" + new_img_name)  
      rescue
      end
    
      @bus.thumbnail_path = new_img_name
      @bus.save
    end
    
    begin
      File.delete("public/uploads/temp/"+image_name)
    rescue
    end
  
    begin
      $facebook.publish_bus(@bus)
      render :json=>{:ok=>true, :html=>(render_to_string :action=>:save_success),:return_view=>"save_success"}
    
    rescue
      @redirect_url = "http://www.facebook.com/dialog/oauth/?" +
                  "client_id=" + APP_ID +
                  "&scope=publish_stream" +
                  "&redirect_uri=http://apps.facebook.com/wehopin/bus/save_success_with_publish?bus_id=" + @bus.id.to_s

      render :json=>{:ok=>true, :html=>(render_to_string "redirect/index")}
    
    end
    
    
  end
  
  def save_success_with_publish
    @bus = Bus.first(:conditions=>{:id => params[:bus_id]})
    $facebook.publish_bus(@bus)
  end
  
  def save_success
    
    

  end
   
  def cancel_payment
     bus = Bus.first(:conditions=>{:id=>params[:bus_id]})
     
     if bus.status == Bus::STATUS_PENDING
       if confirm_preapproval(bus)
         
         successfully_pay_bus(bus)
         
         render :save_success
         return
         
       end
     end
     
     render :cancel_payment
    
  end
 
  def paid
     bus = Bus.first(:conditions=>{:id=>params[:bus_id]})
     
     if bus.status == Bus::STATUS_PENDING
       if confirm_preapproval(bus)

         successfully_pay_bus(bus)
         
       end
     end
     
     render :save_success
  end

  def view
    @bus = Bus.first(:conditions=>{:id => params[:bus_id]})
    
    render :json=>{:ok=>true, :html=>(render_to_string :action=>:view),:return_view=>"view"}
  
  end
end
