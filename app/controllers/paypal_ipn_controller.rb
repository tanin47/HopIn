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
    entity.buy_offer_id = 0
    
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
    
    buy_offer = BuyOffer.first(:conditions=>{:unique_key=>params[:key]})
    
    if !buy_offer
      entity.status = PaypalIpn::STATUS_BUY_OFFER_INVALID
      entity.buy_offer_id = buy_offer.id
      entity.save
    end

    entity.status = PaypalIpn::STATUS_VERIFIED
    entity.buy_offer_id = buy_offer.id
    entity.save
    
    offer = Offer.first(:conditions=>{:id=>buy_offer.offer_id})
    
    # processed
    if entity.payment_status == "Completed" and offer.status == Offer::STATUS_ACTIVE
      
      successfully_buy_offer(buy_offer)

    end
  
    render :text=>"VERIFIED"
  end
  
end
