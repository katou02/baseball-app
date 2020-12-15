class MypagesController < ApplicationController
  before_action :authenticate_user!
  layout 'vue'
  
  def show
    @user = User.find(params[:id])
    @mypage = Mypage.find_by(user_id: @user.id)
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
  end

  def new
    @mypage = Mypage.new
  end

  def create
    @mypage = Mypage.create(mypage_params)
    if @mypage.save
      redirect_to "/mypages/#{current_user.id}"
    else
      render "new"
    end
  end

  def edit
    @mypage = Mypage.find_by(user_id: params[:id])
  end
  
  def update
    @mypage = Mypage.find_by(id: params[:id])
    @mypage.update(update_params) if @mypage.user_id == current_user.id || current_user.admin
    redirect_to "/mypages/#{@mypage.user.id}"
  end

  private
  def mypage_params
    params.require(:mypage).permit(:text,:prefectures).merge(user_id: current_user.id)
  end

  def update_params
    params.require(:mypage).permit(:text,:prefectures)
  end
end
