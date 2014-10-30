class TweetsController < ApplicationController

  before_action :current_user, :initialize_twitter

  def index
    @trigger_tweets = @current_user.determine_triggers(@twitter, @twitter.mentions_timeline)
    @trigger_tweets.each do |tweet|
      Tweet.create(screenname: tweet.user.screen_name, name: tweet.user.name, text: tweet.text, date: tweet.created_at, tweetid: tweet.id.to_s, user_id: @current_user.id)
    end
    @tweets = Tweet.where(user: @current_user)
  end

  def create
    @tweet = Tweet.new(tweet_params)
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    redirect_to tweets_path
  end

  private

  def tweet_params
      params.permit(:screenname, :name, :text, :date, :tweetid)
  end

end