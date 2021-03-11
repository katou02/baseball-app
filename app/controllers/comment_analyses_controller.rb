class CommentAnalysesController < ApplicationController
  def create
    # redirect_to "/analyses/#{comment.analysis.id}"
    # comment = CommentAnalysis.create(comment_params)
    # @analysis = comment.analysis
    # @analysis.create_notification_comment_analysis!(current_user, comment.id)
    @analysis = Analysis.find(params[:analysis_id])
    @num = 1
    @comment = @analysis.comment_analyses.build(comment_params)
    # @comment.user_id = current_user.id
    @comment.save
    render :index
  end

  def destroy
    @comment = CommentAnalysis.find(params[:id])
    @analysis = Analysis.find(params[:analysis_id])
    @num = 1
    if @comment.user_id = current_user.id
      @comment.destroy
      render :index
    end
  end

  private
  def comment_params
    params.require(:comment_analysis).permit(:text).merge(user_id: current_user.id,analysis_id: params[:analysis_id])
  end
end
