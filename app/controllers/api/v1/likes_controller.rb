class Api::V1::LikesController < ApiController
  skip_before_action :verify_authenticity_token

  def index
    render json: Like.filter_by_post(params[:tweet_id]).select(:id, :user_id, :tweet_id)
  end

  def create
    current_user.likes.create(likes_params)
    @tweet = Tweet.find(params[:tweet_id])
    @tweet.create_notification_like!(current_user) if @tweet.user_id != current_user.id
  end

  def destroy
    current_user.likes.find(params[:id]).destroy!
    head :ok
  end

  private

  def likes_params
    params.permit(:tweet_id)
  end
end