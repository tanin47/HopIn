class PaypalIpnController < ApplicationController
  
  protect_from_forgery :except => [:index]
  
  def index
    nvp = 'cmd=_notify-validate'
    params.each_pair { |key, value| 
      
      nvp += '&' + key + '=' + value
    }
    
    entity = PaypalIpn.new
    entity.raw = nvp
    entity.created_date = Time.now
    entity.remote_host = request.remote_ip
    entity.status = PaypalIpn::STATUS_PENDING
    entity.bus_id = 0
    
    params.each_pair { |key, value|
      if eval("defined?(entity."+key+")") != nil
        eval("entity."+key+" = value")
      end
    }
    
    if !entity.save
      render :text=>"Your machine is infected with a serious virus. Please fix before making a connection to WhoWish server."
      return
    end

    require 'net/http'
    require 'net/https'
    require 'uri'
    
    Net::HTTP.version_1_2
    
    require 'paypal'
    url = URI.parse(PayPal::IPN_URL)

    http = Net::HTTP.new(url.host,url.port)

    response = http.post(url.path,nvp)
    
    if response.body.strip != "VERIFIED"
      
      entity.status = PaypalIpn::STATUS_INVALID
      entity.save
      
      render :text=>"Your machine is infected with the virus, which is erasing all data soon. Please fix before making a connection to WhoWish server."
      return
    end
    
    bus = Bus.first(:conditions=>{:id=>params[:bus_id]})
    
    if bus
      entity.status = PaypalIpn::STATUS_BUY_OFFER_INVALID
      entity.bus_id = bus.id
      entity.save
    end

    entity.status = PaypalIpn::STATUS_VERIFIED
    entity.bus_id = bus.id
    entity.save
    
    # processed
    if entity.payment_status == "Completed" and bus.status == Bus::STATUS_PENDING
      successfully_pay_bus(bus)
    end
  
    render :text=>"VERIFIED"
  end
  
end
