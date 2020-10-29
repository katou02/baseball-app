class Admin::UsersController < ApplicationController
  before_action :admin_user

  def index
  end
  
  def users_show
    @users = User.all.order(created_at: :desc)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
  end

  private
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
