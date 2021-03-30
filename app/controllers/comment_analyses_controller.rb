class CommentAnalysesController < ApplicationController
  def create
    @analysis = Analysis.find(params[:analysis_id])
    @num = 1
    @comment = @analysis.comment_analyses.build(comment_params)
    @comment.save
    render :comment
  end

  def destroy
    @comment = CommentAnalysis.find(params[:id])
    @analysis = Analysis.find(params[:analysis_id])
    @num = 1
    if @comment.user_id = current_user.id
      @comment.destroy
      render :comment
    end
  end

  private
  def comment_params
    params.require(:comment_analysis).permit(:text).merge(user_id: current_user.id,analysis_id: params[:analysis_id])
  end
end
