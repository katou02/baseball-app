class TweetsController < ApplicationController

  before_action :search_tweet,only:[:show,:destroy,:edit,:update]
  before_action :move_to_index,except: :index
  before_action :set_category, only: [:new, :edit, :create, :update, :destroy]

  def index
    @tweets = Tweet.includes(:user).page(params[:page]).per(5).order("created_at DESC")
    @tournaments = Tournament.all
  end

  def new
    @tweet=Tweet.new
    respond_to do |format|
      format.html
      format.json do
      @category_children = Category.find(params[:tournament_id]).children
      end
    end
  end

  def create
    @tweet=Tweet.create(image: tweet_params[:image],text: tweet_params[:text],title_info: tweet_params[:title_info],school_a: tweet_params[:school_a],school_b: tweet_params[:school_b],school_a_score: tweet_params[:school_a_score],school_b_score: tweet_params[:school_b_score],user_id: current_user.id,tournament_id: tweet_params[:tournament_id])
  end

  def show
    @tweets = current_user.tweets.page(params[:page]).per(5).order("created_at DESC")
    @nickname=current_user.nickname
    @comments = @tweet.comments.includes(:user)
  end

  def destroy
    @tweet.destroy if @tweet.user_id == current_user.id
  end

  def search
    @tweets = Tweet.search(params[:keyword])
  end

  def edit
    @tweets = Tweet.find(params[:id])
  end

  def update
    @tweet.update(tweet_params) if @tweet.user_id == current_user.id || current_user.admin
    redirect_to action: :show
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
    params.permit(:image,:text,:title_info,:school_a,:school_b,:school_a_score,:school_b_score,:user_id,:tournament_id)
  end
end
