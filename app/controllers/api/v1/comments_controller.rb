class Api::V1::CommentsController < ApiController
  skip_before_action :verify_authenticity_token
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
      if current_user.id != @tweet.user_id
        @tweet.create_notification_comment!(current_user, comment.id)
      end
      render json: comment,status: :created
    else
      render json: { errors: comment.errors.keys.map { |key| [key, comment.errors.full_messages_for(key)]}.to_h, render: 'show.json.jbuilder' }, status: :unprocessable_entity
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