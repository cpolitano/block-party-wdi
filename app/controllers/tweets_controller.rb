class TweetsController < ApplicationController

  before_action :current_user

  def index
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