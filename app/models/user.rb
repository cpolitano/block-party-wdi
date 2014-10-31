class User < ActiveRecord::Base
  has_many :blocks
  has_many :words
  has_many :tweets

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.twitter_screen_name = auth["info"]["nickname"]
      user.twitter_display_name = auth["info"]["name"]
    end
  end

  # Gathering all trigger words
  def get_my_words
    # Words associated with online harassment
    trigger_words = ["rape","murder","nigger","slut","whore","bitch","cunt","kill","die","testword"]
    my_words = Word.where(user_id: self.id)
    my_words.each do |word|
      trigger_words << word.word
    end
    return trigger_words
  end

  # Compare text of a mention to trigger words array. Returns a username if user's tweet text includes a trigger word.
  def determine_blocks(twitter, mentions)
    
    words_to_check = get_my_words
    users_to_block = []

    mentions.each do |mention|
      mention.text.split(" ").each do |word|
        if words_to_check.include?(word) && twitter.friendship?(self, mention.user.screen_name) == false
            users_to_block << mention.user.screen_name
        end
      end
    end
    return users_to_block
  end


  # Compares text of a mention to trigger words array. Returns a new tweet object for any tweet containing a trigger word.
  def determine_triggers(twitter, mentions)
    
    words_to_check = get_my_words
    trigger_tweets = []

    mentions.each do |mention|
      mention.text.split(" ").each do |word|
        if words_to_check.include?(word) && twitter.friendship?(self, mention.user.screen_name) == false
            trigger_tweets << mention
        end
      end
    end
    return trigger_tweets
  end

end

