class Api::V1::CommentForecastsController < ApiController
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: 404
  end

  def index
    @comments = CommentForecast.where(forecast_id: params[:forecast_id])
    render 'index', formats: 'json', handlers: 'jbuilder'
  end

  def create
    comment = CommentForecast.new(comment_params)
    if comment.save
      render json: comment,status: :created
    else
      render json: { errors: comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @comment = CommentForecast.find(params[:id])
    if @comment.destroy
      head :no_content
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  private
  def comment_params
    params.require(:comment_forecast).permit(:text).merge(user_id: current_user.id,forecast_id: params[:forecast_id])
  end
end