class UsersController < ApplicationController
  before_action :admin_permissions_required

  def index
    @users = User.all
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end
end
