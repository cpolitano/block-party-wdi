class TweetsController < ApplicationController

  before_action :current_user

  def index
    @tweets = Tweet.where(user: @current_user)
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    redirect_to tweets_path
  end

end