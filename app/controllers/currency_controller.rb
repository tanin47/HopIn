class CurrencyController < ApplicationController
include CurrencyHelper
  layout "valhalla"
  
  before_filter :check_admin

 
  def index
    @currencies = Currency.all()
  end
  
  #
  # 
  # params[:name]
  # Well, save it
  # and return :json=>{:ok=>true or false, ,:new_row=>render_to_string(:partial=>"row",:locals=>{:location=>@location,:is_new=>false}),:error_message=>format_error(@location)}
  #
  def add
    @currency = Currency.new(params[:currency])
    if !@currency.save
      render :json => {:ok=>false, :error_message=>format_error(@currency.errors)}
      return
    end
    
    render :json=>{:ok=>true ,:new_row=>render_to_string(:partial=>"row",:locals=>{:currency=>@currency,:is_new=>false}), :entity=> @currency}
    
  end
  
  # params[:id]
  # delete it and return :json=>{:ok=>true or false,:error_message=>"..."}
  def delete

    if !Currency.delete(params[:id])
      render :json=>{:ok=>false,:error_message=>"error while delete currency"}
      return
    end
 
    render :json=>{:ok=>true}
  end
  
  # params[:id]
  # params[:name]
  # Save it and return :json=>{:ok=>true or false,:error_message=>format_error(@currency.errors)} 
  def edit
    @currency = Currency.first(:conditions=>{:id => params[:id]})
    @currency.update_attributes(params[:currency])
    if !@currency.save
      render :json => {:ok=>false, :error_message=>format_error(@currency.errors)}
      return
    end

    render :json=>{:ok=>true , :entity=> @currency}
  end

end

