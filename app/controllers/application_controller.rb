class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :signed_in_user

  helper_method :signed_in_user

  def sign_in(user)
    @user = user
    session[:signed_in_user] = user.id
  end

  def sign_out
    session.delete :signed_in_user
  end

  def signed_in_user
    @user ||= User.find(session[:signed_in_user]) rescue false
  end


  def redirect_back
    redirect_to request.referer || root_path
  end
end
