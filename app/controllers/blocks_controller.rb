class BlocksController < ApplicationController

  before_action :current_user, :initialize_twitter

  def index
    # Checking for abusive tweets, and identifying the users who sent them
    @users_to_block = @current_user.determine_blocks(@twitter, @twitter.mentions_timeline)

    # Blocking all users identified in previous step
    @users_to_block.each do |user|
      @twitter.block(user)
    end

    # Collecting all blocked users and recent mentions for display in view
    @blocks = @twitter.blocked
    @mentions = @twitter.mentions_timeline
    # render json: @blocks
    # byebug
  end

  def create
    @blocks.each do |block|
      block = Block.new(screen_name: block["screen_name"], name: block["name"], created_at: block["created_at"], twitter_id: block["id_str"])
      block.user_id = @current_user.id
    end
  end

  def destroy
    @block = Block.find(params[:id])
    @twitter.unblock(@block.screen_name)
    @block.destroy
    redirect_to blocks_path
  end

  private

  def current_user
    if session[:user_id]
      @current_user = User.find(session[:user_id])
    else
      redirect_to '/'
    end 
  end

  def initialize_twitter
    @twitter = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV["twitter_key"]
      config.consumer_secret = ENV["twitter_secret"]
      config.access_token = session[:token]
      config.access_token_secret = session[:token_secret]
    end
  end

  def block_params
    params.require(:block).permit(:screen_name, :name, :created_at, :twitter_id)
  end

end