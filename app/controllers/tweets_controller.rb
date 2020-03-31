class TweetsController < ApplicationController

  before_action :search_tweet,only:[:show,:destroy,:edit,:update]
  before_action :move_to_index,except: :index

  def index
    @tweets = Tweet.order("created_at DESC").page(params[:page]).per(5)
  end

  def new
    @tweet=Tweet.new
  end

  def create
    @tweet=Tweet.create(tweet_params)
    if !@tweet.save
      render "new"
    end
  end

  def show
  end

  def destroy
    @tweet.destroy
  end

  def edit
  end

  def update
    @tweet.update(tweet_params)
  end

  def search_tweet
    @tweet = Tweet.find(params[:id])
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

  private
  def tweet_params
    params.permit(:title,:image,:text,:title_info,:school_a,:school_b,:school_a_score,:school_b_score)
  end
end
