class Api::V1::TweetsController < ApiController
  before_action :search_tweet,only:[:show,:destroy]


  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: 404
  end

  def index
    @tweets = Tweet.all.order(created_at: "DESC")
    render 'index', formats: 'json', handlers: 'jbuilder'
  end
  
  def show
    @current_user = current_user
    @user = User.find_by(id: @tweet.user.id)
    @nickname = current_user.nickname
    @comments = @tweet.comments.includes(:user)
    @comment = current_user.comments.new 
    render 'show',formats: 'json',handlers: 'jbuilder'
    # @like = Like.new
    # @like = Like.find_by(tweet_id: params[:tweet_id], user_id: current_user.id)
  end
  
  def destroy
    if @tweet.user_id == current_user.id
      if @tweet.destroy
        head :no_content
      else
        render json: @tweet.errors, status: :unprocessable_entity
      end
    end
  end
  
  def category
    @category = Category.where(ancestry: nil)
    render 'category',formats: 'json',handlers: 'jbuilder'
  end


  def search_tweet
    @tweet = Tweet.find(params[:id])
  end

  def set_category
    categories = Category.where(ancestry: nil)
    render json: categories
  end
end