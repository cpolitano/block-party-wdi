class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

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

end