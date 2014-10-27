class BlocksController < ApplicationController

  before_action :authenticate_user!, :except =>[:index]

  def index
    @blocks = Block.all
    # @blocks = Block.where(user: current_user)
  end

  def destroy
    @block = Block.find(params[:id])
    @block.destroy
    redirect_to blocks_path
  end

end