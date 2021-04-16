class Api::V1::TweetsController < ApiController
  before_action :search_tweet,only:[:show,:destroy,:edit,:update]


  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: 404
  end

  def index
    @tweets = Tweet.all.order(created_at: "DESC")
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
    # binding.pry
    if tweet.save
      render json: tweet, status: :created
    else
      # render json: { errors: tweet.errors.full_messages }, status: :unprocessable_entity
      render json: { errors: tweet.errors.keys.map { |key| [key, tweet.errors.full_messages_for(key)]}.to_h, render: 'show.json.jbuilder' }, status: :unprocessable_entity
    end
  end
  
  def show
    @current_user = current_user
    @user = User.find_by(id: @tweet.user.id)
    @nickname = current_user.nickname
    @comments = @tweet.comments.includes(:user)
    @comment = current_user.comments.new 
    @like = Like.find_by(tweet_id: params[:id], user_id: current_user.id)
    @likes = Like.all
    render 'show',formats: 'json',handlers: 'jbuilder'
  end

  def edit
    @schools = Category.where(ancestry: @tweet.tournament_id)
  end
  
  def update
    if @tweet.user_id == current_user.id || current_user.admin
      if @tweet.update(update_params) 
        head :no_content
      else
        render json: { errors: @tweet.errors.keys.map { |key| [key, @tweet.errors.full_messages_for(key)]}.to_h, render: 'show.json.jbuilder' }, status: :unprocessable_entity
      end
    end
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

  private
  
  def tweet_params
    params.permit(:image,:text,:title_info,:school_a_score,:school_b_score,:school_a_id,:school_b_id,:tournament_id).merge(user_id: current_user.id)
  end

  def update_params
    params.require(:tweet).permit(:image,:text,:title_info,:school_a_score,:school_b_score,:school_a_id,:school_b_id,:tournament_id)
  end
end