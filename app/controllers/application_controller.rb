class ApplicationController < ActionController::Base
  helper_method :current_user
  protect_from_forgery

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def current_user=(user)
    @current_user = user
    session[:user_id] = user.id
  end

  def require_login!
    # TODO: Make this go to a page with login options.
    # TODO: session[:return_to] or similar, to get back to this page.
    if !current_user
      flash[:error] = 'You must be logged in to access this page.'
      redirect_to '/'
    end
  end
end
