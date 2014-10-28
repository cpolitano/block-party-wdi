class User < ActiveRecord::Base
  has_many :blocks

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.twitter_screen_name = auth["info"]["nickname"]
      user.twitter_display_name = auth["info"]["name"]
    end
  end

  # def show_blocks
  #   consumer_key = OAuth::Consumer.new(ENV["twitter_key"],ENV["twitter_secret"])
  #   access_token = OAuth::Token.new(ENV["block_party_token"],ENV["block_party_secret"])
  #   baseurl = "https://api.twitter.com"
  #   path = "/1.1/blocks/list.json?skip_status=true&cursor=-1"
  #   address = URI("#{baseurl}#{path}")
  #   http = Net::HTTP.new address.host, address.port
  #   http.use_ssl = true
  #   http.verify_mode = OpenSSL::SSL::VERIFY_PEER
  #   request = Net::HTTP::Get.new address.request_uri
  #   request.oauth! http, consumer_key, access_token
  #   http.start
  #   response = http.request request
  #   JSON.parse(response.body)
  # end

end

