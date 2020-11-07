class MypagesController < ApplicationController
  # before_action :search_mypage,except:[:new,:create,:update]
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @mypages = @user.mypages

    @myEntry=Entry.where(user_id: current_user.id)
    @userEntry=Entry.where(user_id: @user.id)
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
    @mypage.update(mypage_params) if @mypage.user_id == current_user.id || current_user.admin
    redirect_to "/mypages/#{current_user.id}"
  end

  def my_tweets
    @tweets = Tweet.where(user_id: params[:id])
  end

  def my_analyses
    @analyses = Analysis.where(user_id: params[:id])
  end

  def my_forecasts
    @forecasts = Forecast.where(user_id: params[:id])
  end

  # def search_mypage
  #   @mypage = Mypage.find_by(user_id: params[:id])
  # end
  
  private
  def mypage_params
    params.require(:mypage).permit(:text,:prefectures).merge(user_id: current_user.id)
  end
end
