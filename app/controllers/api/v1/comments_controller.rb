class Api::V1::CommentsController < ApiController
  protect_from_forgery
  # ActiveRecordのレコードが見つからなければ404 not foundを応答する
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: 404
  end

  def index
    @comments = Comment.where(tweet_id: params[:tweet_id])
    render 'index', formats: 'json', handlers: 'jbuilder'
  end

  def create
    comment = Comment.new(comment_params)
    @tweet = comment.tweet
    if comment.save
      @tweet.create_notification_comment!(current_user, comment.id)
      render json: comment,status: :created
    else
      render json: { errors: comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      head :no_content
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id,tweet_id: params[:tweet_id])
  end
end