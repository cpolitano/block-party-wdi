class BlocksController < ApplicationController

  before_action :current_user

  def index
    @blocks = Block.all
    @users = User.all
    # @blocks = Block.where(user: @current_user)
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

end