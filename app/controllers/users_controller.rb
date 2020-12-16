class UsersController < ApplicationController
  before_action :authenticate_user!,only: [:show]

  def index
    @users = User.all
  end
  
  def following
    @user  = User.find(params[:id])
    @users = @user.followings
    render 'show_follow'
  end

  def followers
    @user  = User.find(params[:id])
    @users = @user.followers
    render 'show_follower'
  end

  def show
    @user = User.find(params[:id])
    @tweets = Tweet.where(user_id: params[:id])
    @analyses = Analysis.where(user_id: params[:id])
    @forecasts = Forecast.where(user_id: params[:id])
    @likes = Like.where(user_id: @user.id)
    @myEntry=Entry.where(user_id: current_user.id)
    @userEntry=Entry.where(user_id: @user.id)
    @my_tweet = @user.tweets.page(params[:tweet_page]).per(5).order("created_at DESC")
    @my_analysis = @user.analyses.page(params[:analysis_page]).per(5).order("created_at DESC")
    @my_forecasts = @user.forecasts.page(params[:forecast_page]).per(5).order("created_at DESC")
    @likes = @user.likes.page(params[:page]).per(5).order("created_at DESC")

    if @user.id == current_user.id
    else
      @myEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end

      if @isRoom != true
        @room = Room.new
        @entry = Entry.new
      end
    end
    render layout: 'vue'
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params) if @user.id == current_user.id || current_user.admin
    redirect_to "/users/#{@user.id}"
  end

  private
  def user_params
    params.require(:user).permit(:text,:prefecture)
  end
end
