class Api::V1::ForecastsController < ApiController
  before_action :search_forecast,only:[:show]

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: 404
  end

  def index
    @forecasts = Forecast.all.order(created_at: "DESC")
    render 'index', formats: 'json', handlers: 'jbuilder'
  end

  def show
    @current_user = current_user
    @user = User.find_by(id: @forecast.user.id)
    @nickname = current_user.nickname
    render 'show',formats: 'json',handlers: 'jbuilder'
  end

  def search_forecast
    @forecast = Forecast.find(params[:id])
  end
end