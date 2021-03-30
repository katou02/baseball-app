class CommentForecastsController < ApplicationController
  def create
    # comment = CommentForecast.create(comment_params)
    # redirect_to "/forecasts/#{comment.forecast.id}"
    # @forecast = comment.forecast
    # @forecast.create_notification_comment_forecast!(current_user, comment.id)
    @forecast = Forecast.find(params[:forecast_id])
    @num = 1
    @comment = @forecast.comment_forecasts.build(comment_params)
    @comment.save
    render :comment
  end

  def destroy
    @comment = CommentForecast.find(params[:id])
    if @comment.user_id = current_user.id
      @comment.destroy
      render :comment
    end
  end

  private
  def comment_params
    params.require(:comment_forecast).permit(:text).merge(user_id: current_user.id,forecast_id: params[:forecast_id])
  end
end
