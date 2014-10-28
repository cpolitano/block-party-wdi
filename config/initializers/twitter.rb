twitter = Twitter::REST::Client.new do |config|
  config.consumer_key = ENV["twitter_key"]
  config.consumer_secret = ENV["twitter_secret"]
  config.access_token = ENV["block_party_token"]
  config.access_token_secret = ENV["block_party_secret"]
end