# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  #protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  before_filter :decode_signed_request, :require_basic_information_permission
  
  def decode_signed_request
    
    require "base64"
    
    tokens = params[:signed_request].split('.')
    #print "token[0]="+tokens[0] + "--\n"
    #print "token[1]="+tokens[1] + "--\n"
    
    sig = base64_urlsafe_decode(tokens[0])
    
    #print "decode64(token[1])="+base64_urlsafe_decode(tokens[1]) + "--\n"
    
    data = ActiveSupport::JSON.decode(base64_urlsafe_decode(tokens[1]))
    
    if data['algorithm'].to_s.upcase != 'HMAC-SHA256'
      redirect_to :controller=>:error,:action=>:index
      return
    end
    
    #require 'hmac-sha2'
    require 'openssl'
    
    expected_sig = OpenSSL::HMAC.digest(OpenSSL::Digest::Digest.new('sha256'), '1693f44ea59bb10a896a543611ddbf24', tokens[1]).to_s
    
    #print "sig="+sig +"--\n"
    #print "expected_sig="+expected_sig+"--\n"

    if sig == expected_sig
      $facebook = Facebook.new(data)
    else
      $facebook = nil
      redirect_to :controller=>:error,:action=>:index
      return
    end
    
    print ActiveSupport::JSON.encode($facebook)
    

    
  end
  
  def require_basic_information_permission
    if $facebook.user_id == nil
      @redirect_url = "http://www.facebook.com/dialog/oauth/?" +
                  "client_id=" + APP_ID +
                  "&redirect_uri=http://apps.facebook.com/wehopin/"
      render "redirect/index"
      return
    end
  end
  
  private 
  
    def base64_urlsafe_decode(str)
      
      encoded_str = str.gsub('-','+').gsub('_','/')
      encoded_str += '=' while !(encoded_str.size % 4).zero?
      return Base64.decode64(encoded_str)

    end
end
