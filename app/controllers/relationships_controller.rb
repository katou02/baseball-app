class RelationshipsController < ApplicationController
  def create
    @user = User.find(params[:relationship][:following_id])
    current_user.follow!(@user)
    redirect_to "/mypages/#{@user.id}"
  end

  def destroy
    @user = Relationship.find(params[:id]).following_id
    current_user.unfollow!(@user)
    redirect_to "/mypages/#{@user}"
  end
end
