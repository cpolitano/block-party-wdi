class BlocksController < ApplicationController

  before_action :current_user, :initialize_twitter

  def index
    # Checking for abusive tweets, and identifying the users who sent them
    @new_mentions = @twitter.mentions_timeline
    @users_to_block = @current_user.determine_blocks(@twitter, @new_mentions)

    # Blocking all users identified in previous step
    @users_to_block.each do |user|
      @twitter.block(user)
    end

    # Ensuring all users blocked on Twitter are also persisted to DB
    @all_blocks = @twitter.blocked
    @all_blocks.each do |blocked_user|
      Block.create_block(blocked_user, @current_user)
    end

    # Collecting blocked users & mentions for current user to display in views
    @blocks = Block.where(user_id: @current_user.id)
    @mentions = @twitter.mentions_timeline
    # byebug
  end

  def create

  end

  def destroy
    @block = Block.find(params[:id])
    @twitter.unblock(@block.screen_name)
    @block.destroy   
    # render '/blocks'
    respond_to do |format|
      format.json { render json: @block, status: 200 }
    end
  end

  private

  def block_params
    params.require(:block).permit(:screen_name, :name, :created_at, :twitter_id)
  end

end