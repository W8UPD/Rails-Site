class SessionsController < ApplicationController
  def create
    auth = request.env['omniauth.auth']
    unless @auth = Authentication.find_from_hash(auth)
      @auth = Authentication.create_from_hash(auth, current_user)
    end
    self.current_user = @auth.user

    render :text => "Welcome! You have authenticated!"
  end

  def destroy
    session[:user_id] = nil
    render :text => "Bye! You have logged out!"
  end

  def status
    render :text => "Session: #{session[:user_id]}"
  end
end
