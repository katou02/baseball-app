class CommentsController < ApplicationController
  def create
    comment = Comment.create(comment_params)
    redirect_to "/tweets/#{comment.tweet.id}"
    @tweet = comment.tweet
    @tweet.create_notification_comment!(current_user, comment.id)
  end

  def destroy
    comment = Comment.find(params[:id])
    if comment.user_id = current_user.id
      comment.destroy
      redirect_to "/tweets/#{comment.tweet.id}"
    end
  end

  private
  def comment_params
    params.permit(:text, :tweet_id).merge(user_id: current_user.id)
  end
end