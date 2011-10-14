class SessionsController < ApplicationController
  def create
    auth = request.env['omniauth.auth']
    unless @auth = Authentication.find_from_hash(auth)
      @auth = Authentication.create_from_hash(auth, current_user)
    end
    self.current_user = @auth.user

    redirect_to(request.env['omniauth.origin'] || '/') and return
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/' and return
  end

  def me
    render :text => "Session: #{session[:user_id]}" and return
  end
end
