class Api::V1::TweetsController < ApiController
  skip_before_action :verify_authenticity_token
  before_action :search_tweet,only:[:show,:destroy,:edit,:update]
  
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: 404
  end

  def index
    @tweets = Tweet.all.order(created_at: "DESC").includes(:user)
    render 'index', formats: 'json', handlers: 'jbuilder'
  end

  def new
    @roots = Category.roots
    root_id = params[:root_id]
    child_id = params[:child_id]
    @children = root_id ? @roots.find(root_id).children : []
    @grand_children = child_id ? @children.find(child_id).children : []
    render 'new', formats: 'json', handlers: 'jbuilder'
  end

  def create
    tweet = Tweet.create(tweet_params)
    if tweet.save
      render json: tweet, status: :created
    else
      render json: { errors: tweet.errors.keys.map { |key| [key, tweet.errors.full_messages_for(key)]}.to_h, render: 'show.json.jbuilder' }, status: :unprocessable_entity
    end
  end
  
  def show
    @user = User.find_by(id: @tweet.user.id)
    @comments = @tweet.comments.includes(:user)
    @likes = Like.where(tweet_id: params[:id])
    if current_user.present?
      @nickname = current_user.nickname
      @comment = current_user.comments.new
      @like = Like.find_by(tweet_id: params[:id], user_id: current_user.id)
    end
    render 'show',formats: 'json',handlers: 'jbuilder'
  end

  def edit
    @schools = Category.where(ancestry: @tweet.tournament_id)
    render 'edit',formats: 'json',handlers: 'jbuilder'
  end
  
  def update
    if (@tweet.user_id == current_user.id || current_user.admin) && @tweet.update(update_params) 
      head :no_content
    else
      render json: { errors: @tweet.errors.keys.map { |key| [key, @tweet.errors.full_messages_for(key)]}.to_h, render: 'show.json.jbuilder' }, status: :unprocessable_entity
    end
  end
  
  def destroy
    if (@tweet.user_id == current_user.id || current_user.admin) && @tweet.destroy
      head :no_content
    else
      render json: @tweet.errors, status: :unprocessable_entity
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

  private
  
  def tweet_params
    params.permit(:image,:text,:title,:school_a_score,:school_b_score,:school_a_id,:school_b_id,:tournament_id,:round).merge(user_id: current_user.id)
  end

  def update_params
    params.permit(:image,:text,:title,:school_a_score,:school_b_score,:school_a_id,:school_b_id,:round)
  end
end