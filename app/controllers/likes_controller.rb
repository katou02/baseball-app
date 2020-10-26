class LikesController < ApplicationController
  def create
    @like = current_user.likes.create(tweet_id: params[:tweet_id])
    redirect_back(fallback_location: root_path)

    @tweet = Tweet.find(params[:tweet_id])
    @tweet.create_notification_by(current_uset)
    respond_to do |format|
      format.html {redirect_to request.referrer}
      format.js
    end
  end

  def destroy
    @like = Like.find_by(tweet_id: params[:tweet_id],user_id: current_user.id)
    @like.destroy
    redirect_back(fallback_location: root_path)
  end
end
