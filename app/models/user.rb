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

  # Compares text of a mention to trigger words array. Returns a username if user's tweet text includes a trigger word.
  def determine_blocks(twitter, mentions)
    # Words associated with online harassment
    trigger_words = ["rape","murder","nigger","slut","whore","bitch","cunt","kill","die","testword"]
    users_to_block = []
    mentions.each do |mention|
      mention.text.split(" ").each do |word|
        if trigger_words.include?(word) && twitter.friendship?(self, mention.user.screen_name) == false
            users_to_block << mention.user.screen_name
            Tweet.new(screenname: mention.user.screen_name, name: mention.user.name, text: mention.text, date: mention.created_at, tweetid: mention.id.to_s, user_id: self.id)
        end
      end
    end
    return users_to_block
  end

end

