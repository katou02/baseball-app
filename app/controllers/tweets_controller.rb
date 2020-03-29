class TweetsController < ApplicationController

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
    @tweet = Tweet.find(params[:id])
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy
  end

  def edit
    @tweet = Tweet.find(params[:id])
  end

  def update
    tweet = Tweet.find(params[:id])
    tweet.update(tweet_params)
  end

  private
  def tweet_params
    params.permit(:title,:image,:text,:title_info,:school_a,:school_b,:school_a_score,:school_b_score)
  end
end
