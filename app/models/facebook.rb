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
      
      return response.body
    end
  
end