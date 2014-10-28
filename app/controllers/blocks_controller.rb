class BlocksController < ApplicationController

  before_action :current_user, :initialize_twitter

  def index
    @users = User.all
    # @blocks = @current_user.show_blocks
    @blocks = @twitter.blocked
    @mentions = @twitter.mentions_timeline
    # render json: @mentions
    # byebug
  end

  def create
    @blocks["users"].each do |block|
      block = Block.new(block_params)
      block.user_id = @current_user.id
    end
  end

  def destroy
    @block = Block.find(params[:id])
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