module PaypalHelper

  def request_preapproval_key(bus)
    
    headers = {
       "X-PAYPAL-SECURITY-USERID" => "tanin4_1266099950_biz_api1.gmail.com",
       "X-PAYPAL-SECURITY-PASSWORD" => "1266099956",
       "X-PAYPAL-SECURITY-SIGNATURE" => "AOGp908MTPfZOTwx64dvpnJhmHGhASV4kUXUqrq-blZfWda8hUPUaa4p",
       #"X-PAYPAL-SECURITY-SUBJECT" => "",
       "X-PAYPAL-REQUEST-DATA-FORMAT" => "JSON",
       "X-PAYPAL-RESPONSE-DATA-FORMAT" => "JSON",
       "X-PAYPAL-APPLICATION-ID" => "APP-80W284485P519543T"
       #"X-PAYPAL-DEVICE-ID" => "",
       #"X-PAYPAL-DEVICE-IPADDRESS" => "",
       #"X-PAYPAL-SERVICE-VERSION" => "1.3.0"
    }

    starting_date = Time.now + 60*5
 
    data = {
      "endingDate" => bus.deadline.strftime("%Y-%m-%d")+"T"+bus.deadline.strftime("%H:%M:00.000Z"),
      "startingDate" => starting_date.strftime("%Y-%m-%d")+"T"+starting_date.strftime("%H:%M:00.000Z"),
      "maxTotalAmountOfAllPayments"=>bus.amount.to_s,
      "currencyCode"=>bus.currency_code,
      "cancelUrl"=>"http://"+DOMAIN_NAME+"/bus/cancel_payment?bus_id="+bus.id.to_s,
      "returnUrl"=>"http://"+DOMAIN_NAME+"/bus/paid?bus_id="+bus.id.to_s,
      "requestEnvelope" => {"errorLanguage"=>"en_US"},
      "ipnNotificationUrl" => "http://"+DOMAIN_NAME+"/paypal_ipn?bus_id="+bus.id.to_s
    }

    require 'net/http'
    require 'net/https'
    require 'uri'
    
    Net::HTTP.version_1_2

    url = URI.parse('https://svcs.sandbox.paypal.com/AdaptivePayments/Preapproval')

    http = Net::HTTP.new(url.host,url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    response = http.post(url.path,ActiveSupport::JSON.encode(data),headers)
    print response.body
    result = ActiveSupport::JSON.decode(response.body)

    if result["responseEnvelope"]["ack"] == "Success"
      return result["preapprovalKey"];
    else
      return nil
    end 
    
  end
end