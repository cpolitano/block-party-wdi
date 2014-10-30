class WordsController < ApplicationController

  before_action :current_user, :initialize_twitter

  def index
    @words = Word.where(user: @current_user)
    @word = Word.new
  end

  def new
    @word = Word.new
  end

  def create
    @word = Word.new(word_params)
    @word.user_id = @current_user.id
    if @word.save
      redirect_to '/words'
    end
  end

  def destroy
    @word = Word.find(params[:id])
    @word.destroy
    redirect_to words_path
  end

  private

  def word_params
      params.require(:word).permit(:word)
  end

end