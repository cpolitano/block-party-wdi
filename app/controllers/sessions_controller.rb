class SessionsController < ApplicationController
  def create     
    auth = request.env["omniauth.auth"]     
    @user = User.find_by_uid(auth["uid"]) || User.create_with_omniauth(auth)
    # byebug  
    session[:user_id] = @user.id     
    session[:token] = auth["credentials"]["token"]
    session[:token_secret] = auth["credentials"]["secret"]
    session[:twitter_screen_name] = @user.twitter_screen_name
    redirect_to '/blocks', :notice => "Signed in as @"+ @user.twitter_screen_name
  end
  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end
end


