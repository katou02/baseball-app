class TweetsController < ApplicationController

  def index
    @tweets = Tweet.order("created_at DESC").page(params[:page]).per(5)
  end

  def new
  end

  def create
    Tweet.create(tweet_params)
  end

  def show
    @tweet = Tweet.find(params[:id])
  end

  private
  def tweet_params
    params.permit(:title,:image,:text,:title_info,:school_a,:school_b)
  end
end
