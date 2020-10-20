class ForecastsController < ApplicationController
  before_action :set_category, only: [:new,:create]

  def index
    @tweets = Forecast.includes(:user).page(params[:page]).per(5).order("created_at DESC")
  end

  def new
    @forecast = Forecast.new
    respond_to do |format|
      format.html
      format.json do
        @category_children = Category.find(params[:tournament_id]).children
      end
    end
  end

  def create
    @forecast = Forecast.create(forecast_params)
    render "new" unless @forecast.save
  end

  private
  def set_category
    @category_parent_array = Category.where(ancestry: nil)
  end

  def forecast_params
    params.require(:forecast).permit(:text,:win_school_id,:lose_school_id,:tournament_id).merge(user_id: current_user.id)
  end
end
