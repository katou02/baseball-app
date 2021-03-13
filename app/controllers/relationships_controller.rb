class RelationshipsController < ApplicationController
  def create
    @user = User.find(params[:relationship][:following_id])
    @a = User.find_by(id: @user)
    current_user.follow!(@user)
    redirect_to "/users/#{@user.id}"
    @user.create_notification_follow!(current_user)
  end
  
  def destroy
    @user = Relationship.find(params[:id]).following_id
    @a = User.find_by(id: @user)
    current_user.unfollow!(@user)
    redirect_to "/users/#{@user}"
  end
end
