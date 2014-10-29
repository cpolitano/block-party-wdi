class BlocksController < ApplicationController

  before_action :current_user, :initialize_twitter

  def index
    # Checking for abusive tweets, and identifying the users who sent them
    @users_to_block = @current_user.determine_blocks(@twitter, @twitter.mentions_timeline)

    # Blocking all users identified in previous step
    @users_to_block.each do |user|
      @twitter.block(user)
    end

    # Ensuring all blocked users are persisted to DB
    @all_blocks = @twitter.blocked
    @all_blocks.each do |user|
      Block.create_block(user, @current_user)
    end

    # Collecting blocked users & mentions for current user to display in views
    @blocks = Block.where(user_id: @current_user.id)
    @mentions = @twitter.mentions_timeline
    # byebug
  end

  def create
    # @blocks = @twitter.blocked
    # Block.create_blocks(@blocks, @current_user)
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