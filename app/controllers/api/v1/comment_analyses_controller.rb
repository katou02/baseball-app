class Api::V1::CommentAnalysesController < ApiController
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
      render json: { errors: comment.errors.full_messages }, status: :unprocessable_entity
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