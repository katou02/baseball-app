class TweetsController < ApplicationController
  before_action :search_tweet,only:[:show,:destroy,:edit,:update]
  before_action :move_to_index,except: :index
  before_action :set_category, only: [:index,:new, :edit, :create, :update, :destroy]

  def index
    @tweets = Tweet.includes(:user).page(params[:page]).per(5).order("created_at DESC")
    render layout: "vue"
  end

  def new
    @tweet = Tweet.new
    respond_to do |format|
      format.html
      format.json do
        @category_children = Category.find(params[:tournament_id]).children
      end
    end
  end

  def create
    @tweet = Tweet.create(tweet_params)
    return redirect_to tweets_path if @tweet.save
    render "new"
  end

  def show
    @num=1
    @nickname = current_user.nickname
    @comments = @tweet.comments.includes(:user)
    @comment = current_user.comments.new 
    @like = Like.new
  end

  def destroy
    @tweet.destroy if @tweet.user_id == current_user.id || current_user.admin
  end

  def search
    @tweets = Tweet.search(params[:keyword])
  end

  def edit
    @category = Category.find_by(name: @tweet.tournament.name)
    @category_children = @category.children

    @category_children_array = []
    Category.where(ancestry: @category_children.first.ancestry).each do |children|
      @category_children_array << children
    end
  end
  
  def update
    @tweet.update(update_params) if @tweet.user_id == current_user.id || current_user.admin
    redirect_to action: :show
  end

  def get_category_children
    @category_children = Category.find(params[:tournament_id]).children
  end

  def search_tweet
    @tweet = Tweet.find(params[:id])
  end
  
  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end
  
  private
  def set_category
    @category_parent_array = Category.where(ancestry: nil)
  end

  def tweet_params
    params.require(:tweet).permit(:image,:text,:title_info,:school_a_score,:school_b_score,:school_a_id,:school_b_id,:tournament_id).merge(user_id: current_user.id)
  end

  def update_params
    params.require(:tweet).permit(:image,:text,:title_info,:school_a_score,:school_b_score,:school_a_id,:school_b_id,:tournament_id)
  end
end
