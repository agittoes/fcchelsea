class SessionsController < ApplicationController
  #after_action :redirect_back

  def auth

  end

  def create
    user = User.oauth env['omniauth.auth']
    sign_in user
    redirect_to request.referer || root_path
  end

  def destroy
    sign_out
    redirect_to request.referer || root_path
  end
end
