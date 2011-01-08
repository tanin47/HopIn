class Facebook
  attr_accessor :user_id,:oauth_token,:expires,:profile_id,:country,:locale
  
  def initialize(hash_obj)
    @user_id = hash_obj['user_id']
    @oauth_token = hash_obj['oauth_token']
    @expires = hash_obj['expires']
    @profile_id = hash_obj['profile_id']
    @country = hash_obj['user']['country']
    @locale = hash_obj['user']['locale']
  end
  
  def all_friends
    return get_data("friends")
  end
  
  def generate_publish_bus_url(bus)
   
  end
  
  def publish_bus(bus)
    
    require 'cgi'
    
    data = {}
    data['message'] = ""
    
    if bus.thumbnail_path == ""
      data['picture'] = "http://"+DOMAIN_NAME+"/upload/bus/" + bus.thumbnail_path
    else
      data['picture'] = "http://"+DOMAIN_NAME+"/upload/bus/default_news_feed.jpg"
    end
    
    data['link'] = "http://apps.facebook.com/"+FACEBOOK_APP_NAME+"/bus/view?id="+bus.id.to_s
    data['name'] = "I want to donate to " + bus.name
    data['caption'] = ""
    data['description'] = bus.why
    data['privacy'] = "{'value':'EVERYONE'}"
    
    actions = [
                {"name" => "Hop", "link"=> "http://apps.facebook.com/"+FACEBOOK_APP_NAME+"/bus/hop?id="+bus.id.to_s}
               ]
    
    data['actions'] = ActiveSupport::JSON.encode(actions)
    
    response = post_data("feed",data)
    
    if response['error']
      if response['error']['type'] == "OAuthException"
        raise "No permission"
      end
    end
    
    
  end
  
  private
    def get_data(method)
      require 'net/http'
      require 'net/https'
      require 'uri'
      
      Net::HTTP.version_1_2
      
      url = URI.parse("https://graph.facebook.com/"+@user_id+"/"+method)
  
      http = Net::HTTP.new(url.host,url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      
      response = http.get(url.path+"?access_token="+@oauth_token)
      
      return @user_id + " "  + response.body
  end
  
  private
    def post_data(method,data)
      
      nvp = "access_token="+@oauth_token  
      data.each_pair { |key, value| 
        nvp += '&' + key + '=' + CGI.escape(value)
      }
      
      print nvp +"\n"

      require 'net/http'
      require 'net/https'
      require 'uri'
      
      Net::HTTP.version_1_2
      
      url = URI.parse("https://graph.facebook.com/"+@user_id+"/"+method)
  
      http = Net::HTTP.new(url.host,url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      
      response = http.post(url.path,nvp)
      
      return ActiveSupport::JSON.decode response.body
    end
  
end