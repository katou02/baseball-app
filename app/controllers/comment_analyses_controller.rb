class CommentAnalysesController < ApplicationController
  def create
    comment = CommentAnalysis.create(comment_params)
    redirect_to "/analyses/#{comment.analysis.id}"
    @analysis = comment.analysis
    @analysis.create_notification_comment_analysis!(current_user, comment.id)
  end

  def destroy
    comment = CommentAnalysis.find(params[:id])
    if comment.user_id = current_user.id
      comment.destroy
      redirect_to "/analyses/#{comment.analysis.id}"
    end
  end

  private
  def comment_params
    params.require(:comment_analysis).permit(:text).merge(user_id: current_user.id,analysis_id: params[:analysis_id])
  end
end
