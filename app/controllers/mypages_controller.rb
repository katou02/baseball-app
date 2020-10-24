class MypagesController < ApplicationController
  before_action :set_mypage,only:[:edit,:update]

  def show
    @nickname = current_user.nickname
    if Mypage.exists?(user_id: params[:id])
      @mypage = Mypage.find_by(user_id: params[:id])
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
  end
  
  def update
    @mypage.update(mypage_params) if @mypage.user_id == current_user.id || current_user.admin
    redirect_to "/mypages/#{current_user.id}"
  end

  def set_mypage
    @mypage = Mypage.find_by(user_id: params[:id])
  end
  
  private
  def mypage_params
    params.require(:mypage).permit(:text,:prefectures).merge(user_id: current_user.id)
  end
end
