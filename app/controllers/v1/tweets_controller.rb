class Api::V1::TweetsController < ApiController
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: 404
  end

  def index
    tweets = Tweet.includes(:user).page(params[:page]).per(5).order("created_at DESC")
    render json: tweets
  end
end