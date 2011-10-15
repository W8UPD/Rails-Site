class SessionsController < ApplicationController
  def create
    omniauth = request.env['omniauth.auth']
    if omniauth
      # Register
      @auth_info = { :provider => params[:provider] }
      @auth_info[:realname] = omniauth['user_info']['name'] ? omniauth['user_info']['name'] : ''
      @auth_info[:email] = omniauth['user_info']['email'] ? omniauth['user_info']['email'] : ''
      @auth_info[:uid] = omniauth['uid'] ? omniauth['uid'] : ''
      case params[:provider]
      when 'some_special_case'
        # Handle any special cases here.
      end
      # render :text => @auth_info.to_yaml and return
      session[:auth_info] = @auth_info

      if @auth = Authentication.find_from_hash(@auth_info)
        # Log in
        self.current_user = @auth.user
        session[:user_id] = @auth.user.id
        redirect_to(request.env['omniauth.origin'] || '/') and return
      else
        render signup_sessions_path and return
      end

    else
      flash[:error] = 'An error has occurred and has been logged.'
      redirect_to root_url
    end
  end

  def newaccount
    auth = session[:auth_info]
    if params[:commit] == 'Cancel'
      session[:auth_info] = nil
      redirect_to root_url and return
    end
    @auth = Authentication.create_from_hash(auth, current_user)
    session[:user_id] = @auth.user.id
    flash[:success] = 'Hey! You have made a new account! Thanks!'
    redirect_to root_url and return
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url and return
  end

  def me
    render :text => "Session: #{session[:user_id]}" and return
  end
end
