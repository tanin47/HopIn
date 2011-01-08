# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def successfully_pay_bus(bus)
    bus.status = Bus::STATUS_ACTIVE
    bus.save
  end
  
  def format_currency_by_code(currency_code,number)
   currency = Currency.first(:conditions=>{:paypal_currency_code=>currency_code})
   return number_to_currency(number, :unit => currency.sign, :separator => currency.separator, :delimiter => currency.delimiter, :format => currency.format)
  end
 
  def get_facebook_info(facebook_id)
    profile = FacebookCache.first(:conditions=>{:facebook_id=>facebook_id})

    if !profile

      profile = FacebookCache.new(:facebook_id=>facebook_id,:updated_date=>Time.now)
      
      data = ActiveSupport::JSON.decode get_data(facebook_id)
      
      profile.name = data['name']
      profile.gender = data['gender']
      profile.save
    end
    
    if (Time.now - profile.updated_date) > 60*60*24
      data = ActiveSupport::JSON.decode get_data(facebook_id)
      profile.name = data['name']
      profile.gender = data['gender']
      profile.updated_date = Time.now
      profile.save
    end
    
    return profile
  end
  
  private
    def get_data(facebook_id)
      print "YESh"
      require 'net/http'
      require 'net/https'
      require 'uri'
      
      Net::HTTP.version_1_2
      
      url = URI.parse("https://graph.facebook.com/"+facebook_id)
  
      http = Net::HTTP.new(url.host,url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      
      response = http.get(url.path)
      
      
      return response.body
  end
  
end
