class TweetsController < ApplicationController

  before_action :search_tweet,only:[:show,:destroy,:edit,:update]
  before_action :move_to_index,except: :index

  def index
    @tweets = Tweet.includes(:user).page(params[:page]).per(5).order("created_at DESC")
  end

  def new
    @tweet=Tweet.new(tweet_params)
  end

  def create
    @tweet=Tweet.create(image: tweet_params[:image],text: tweet_params[:text],title_info: tweet_params[:title_info],school_a: tweet_params[:school_a],school_b: tweet_params[:school_b],school_a_score: tweet_params[:school_a_score],school_b_score: tweet_params[:school_b_score],user_id: current_user.id)
    if !@tweet.save
      render "new"
    end
  end

  def show
    @tweets = current_user.tweets.page(params[:page]).per(5).order("created_at DESC")
    @nickname=current_user.nickname
    @comments = @tweet.comments.includes(:user)
  end

  def destroy
    @tweet.destroy if @tweet.user_id == current_user.id
    # else
    #   redirect_to action: index
    # end
  end

  def search
    @tweets = Tweet.search(params[:keyword])
  end

  def edit
  end

  def update
    @tweet.update(tweet_params) if @tweet.user_id == current_user.id
    redirect_to action: :show
  end

  def search_tweet
    @tweet = Tweet.find(params[:id])
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

  private
  def tweet_params
    params.permit(:image,:text,:title_info,:school_a,:school_b,:school_a_score,:school_b_score,:user_id)
  end
end
