class SessionsController < ApplicationController
  def auth

  end

  def auth_success
    user = User.oauth env['omniauth.auth']
    sign_in user
    redirect_to request.referer || root_path
  end

  def auth_failure
    redirect_to root_path
  end

  def create

  end

  def destroy
    sign_out
    redirect_to request.referer || root_path
  end
end
