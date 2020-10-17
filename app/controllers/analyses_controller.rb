class AnalysesController < ApplicationController
  before_action :set_category, only:[:index,:new,:create]
  def index
    @analyses = Analysis.includes(:user).page(params[:page]).per(10).order("created_at DESC")
  end

  def new
    @analysis = Analysis.new
    respond_to do |format|
      format.html
      format.json do
        @category_children = Category.find(params[:tournament_id]).children
      end
    end
  end

  def create
    @analysis = Analysis.create(analysis_params)
    render "new" unless @analysis.save
  end

  private
  def set_category
    @category_parent_array = Category.where(ancestry: nil)
  end

  def analysis_params
    params.require(:analysis).permit(:text,:tournament_id,:school_id,:attack,:defensive,:pitcher,:comprehensive).merge(user_id: current_user.id)
  end
end
