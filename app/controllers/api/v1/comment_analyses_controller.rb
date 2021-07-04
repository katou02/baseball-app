class Api::V1::CommentAnalysesController < ApiController
  skip_before_action :verify_authenticity_token
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: 404
  end

  def index
    @comments = CommentAnalysis.where(analysis_id: params[:analysis_id])
    render 'index', formats: 'json', handlers: 'jbuilder'
  end

  def create
    comment = CommentAnalysis.new(comment_params)
    @analysis = comment.analysis
    if comment.save
      @analysis.create_notification_comment_analysis!(current_user, comment.id)
      render json: comment,status: :created
    else
      render json: { errors: comment.errors.keys.map { |key| [key, comment.errors.full_messages_for(key)]}.to_h, render: 'show.json.jbuilder' }, status: :unprocessable_entity
    end
  end

  def destroy
    @comment = CommentAnalysis.find(params[:id])
    if @comment.destroy
      head :no_content
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  private
  def comment_params
    params.require(:comment_analysis).permit(:text).merge(user_id: current_user.id,analysis_id: params[:analysis_id])
  end
end