class UsersController < ApplicationController
  def following
    @user  = User.find(params[:id])
    @users = @user.followings
    render 'show_follow'
    @user.create_notification_follow!(current_user)
  end

  def followers
    @user  = User.find(params[:id])
    @users = @user.followers
    render 'show_follower'
  end
end
