class Api::V1::RelationshipsController < ApiController
  protect_from_forgery
  before_action :login

  def create
    @user = User.find(params[:relationship][:following_id])
    @login_user.follow!(@user)
    @user.create_notification_follow!(@login_user)
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