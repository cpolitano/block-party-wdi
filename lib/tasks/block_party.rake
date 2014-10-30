namespace :block_party do
  desc "CHECK"
  task check_mentions: :environment do
    User.determine_blocks(@twitter, @twitter.mentions_timeline)
    trigger_tweets = User.determine_triggers(@twitter, @twitter.mentions_timeline)
    trigger_tweets.each do |tweet|
      Tweet.create(screenname: tweet.user.screen_name, name: tweet.user.name, text: tweet.text, date: tweet.created_at, tweetid: tweet.id.to_s, user_id: User.id)
    end
  end

end
