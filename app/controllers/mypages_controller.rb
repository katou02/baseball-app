class MypagesController < ApplicationController
  def show
    @nickname = current_user.nickname
    if Mypage.exists?(user_id: current_user.id)
      @my = Mypage.find_by(user_id: current_user.id)
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
    @mypage = Mypage.find(params[:id])
  end

  def update
    @mypage.update(mypage_params) if @mypage.user_id == current_user.id || current_user.admin
    redirect_to action: :show
  end

  private
    def mypage_params
      params.require(:mypage).permit(:text).merge(user_id: current_user.id)
    end
end
