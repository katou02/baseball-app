class Api::V1::TweetsController < ApiController
  # before_action :set_category, only: [:index]

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: 404
  end

  def index
    # @tweets = Tweet.includes(:user).page(params[:page]).per(5).order("created_at DESC")
    page = params[:page] || 1
    per = params[:per] || 5
    @tweets = Tweet.page(page).per(per).order(created_at: "DESC")
    @total_pages = @tweets.total_pages
    render 'index', formats: 'json', handlers: 'jbuilder'
  end

  def set_category
    categories = Category.where(ancestry: nil)
    render json: categories
  end
end