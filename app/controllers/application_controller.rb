class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :signed_in_user

  helper_method :signed_in_user, :user_signed_in?, :signed_in_user_has_admin_permissions?

  def sign_in(user)
    @signed_in_user = user
    session[:signed_in_user] = user.id
  end

  def sign_out
    session.delete :signed_in_user
    @signed_in_user = nil
  end

  def signed_in_user
    if false && Rails.env.development?
      @signed_in_user ||= User.first
    else
      @signed_in_user ||= User.find(session[:signed_in_user]) rescue false
    end
  end

  def user_signed_in?
    !!signed_in_user
  end

  def signed_in_user_has_admin_permissions?
    !!signed_in_user && signed_in_user.admin?
  end

  protected

  def signed_in_user_required
    raise 'Signed in user required!' unless signed_in_user
  end

  def admin_permissions_required
    raise 'Administrator permissions required' unless signed_in_user
  end


  def redirect_back
    redirect_to request.referer || root_path
  end
end
