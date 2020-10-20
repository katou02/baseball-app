class ForecastsController < ApplicationController
  before_action :set_category, only: [:index,:new,:create]
  before_action :search_forecast,only:[:destroy]

  def index
    @forecasts = Forecast.includes(:user).page(params[:page]).per(5).order("created_at DESC")
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

  def destroy
    @forecast.delete if @forecast.user_id == current_user.id
    redirect_to action: :index if @forecast.destroy
  end

  def search_forecast
    @forecast = Forecast.find(params[:id])
  end

  private
  def set_category
    @category_parent_array = Category.where(ancestry: nil)
  end

  def forecast_params
    params.require(:forecast).permit(:text,:win_school_id,:lose_school_id,:tournament_id).merge(user_id: current_user.id)
  end
end
