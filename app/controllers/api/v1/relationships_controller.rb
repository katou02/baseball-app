class Api::V1::RelationshipsController < ApplicationController
  before_action :login
  protect_from_forgery

  def create
    @user = User.find(params[:relationship][:following_id])
    @login_user.follow!(@user)
    # @user.create_notification_follow!(current_user)
  end
  
  def destroy
    # @user = Relationship.find(params[:id]).following_id
    @user = User.find_by(id: params[:id])
    @login_user.unfollow!(@user)
  end

  private
  def login
    @login_user = User.find_by(id: current_user.id)
  end
end