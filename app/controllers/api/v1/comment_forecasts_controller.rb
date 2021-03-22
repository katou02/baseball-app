class Api::V1::CommentForecastsController < ApiController
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: 404
  end

  def index
    @comments = CommentForecast.where(forecast_id: params[:forecast_id])
    render 'index', formats: 'json', handlers: 'jbuilder'
  end
end