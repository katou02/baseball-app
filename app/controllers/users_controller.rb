class UsersController < ApplicationController

  def index
    @users = User.all
  end
  
  def following
    @user  = User.find(params[:id])
    @users = @user.followings
    @mypage = Mypage.find_by(user_id: @user.id)
    render 'show_follow'
  end

  def followers
    @user  = User.find(params[:id])
    @users = @user.followers
    render 'show_follower'
  end
end
