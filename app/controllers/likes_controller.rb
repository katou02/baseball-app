class LikesController < ApplicationController
  def create
    @tweet = Tweet.find(params[:tweet_id])
    @like = current_user.likes.build(tweet_id: params[:tweet_id])
    @like.save
    # @like = current_user.likes.create(tweet_id: params[:tweet_id])
    # redirect_back(fallback_location: root_path)
    # @tweet.create_notification_like!(current_user)
    # render :like
  end

  def destroy
    @tweet = Tweet.find(params[:tweet_id])
    @like = Like.find_by(tweet_id: params[:tweet_id], user_id: current_user.id)
    @like.destroy
    # @like = Like.find_by(tweet_id: params[:tweet_id],user_id: current_user.id)
    # @like.destroy
    # redirect_back(fallback_location: root_path)
  end
end
