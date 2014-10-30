class User < ActiveRecord::Base
  has_many :blocks
  has_many :words
  has_many :tweets

  # Words associated with online harassment
  @trigger_words = ["rape","murder","nigger","slut","whore","bitch","cunt","kill","die","testword"]

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.twitter_screen_name = auth["info"]["nickname"]
      user.twitter_display_name = auth["info"]["name"]
    end
  end

  # Add additional words to trigger words array
  def get_my_words
    my_words = Word.where(user_id: self.id)

    my_words.each do |word|
      @trigger_words << my_words
    end
    return @trigger_words
  end

  # Compare text of a mention to trigger words array. Returns a username if user's tweet text includes a trigger word.
  def determine_blocks(twitter, mentions)
    
    @trigger_words = get_my_words
    users_to_block = []

    mentions.each do |mention|
      mention.text.split(" ").each do |word|
        if @trigger_words.include?(word) && twitter.friendship?(self, mention.user.screen_name) == false
            users_to_block << mention.user.screen_name
        end
      end
    end
    return users_to_block
  end


  # Compares text of a mention to trigger words array. Returns a new tweet object for any tweet containing a trigger word.
  def determine_triggers(twitter, mentions)
    
    @trigger_words = get_my_words
    trigger_tweets = []
    
    mentions.each do |mention|
      mention.text.split(" ").each do |word|
        if trigger_words.include?(word) && twitter.friendship?(self, mention.user.screen_name) == false
            trigger_tweets << mention
        end
      end
    end
    return trigger_tweets
  end

end

