class Api::V1::TweetsController < ApiController
  # before_action :set_category, only: [:index]

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: 404
  end

  def index
    @tweets = Tweet.all.order(created_at: "DESC")
    render 'index', formats: 'json', handlers: 'jbuilder'
  end

  def set_category
    categories = Category.where(ancestry: nil)
    render json: categories
  end
end