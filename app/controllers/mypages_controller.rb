class MypagesController < ApplicationController
  before_action :search_mypage,except:[:new,:create,:update]

  def show
    @user = User.find(params[:id])
    @mypages = @user.mypages
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
  end
  
  def update
    @mypage = Mypage.find_by(user_id: current_user.id)
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

  def search_mypage
    @mypage = Mypage.find_by(user_id: params[:id])
  end
  
  private
  def mypage_params
    params.require(:mypage).permit(:text,:prefectures).merge(user_id: current_user.id)
  end
end
