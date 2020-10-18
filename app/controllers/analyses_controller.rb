class AnalysesController < ApplicationController
  before_action :set_category, only:[:index,:new,:create,:edit,:update]
  before_action :search_analysis,only:[:destroy,:edit,:update]
  before_action :move_to_index,except: :index
  
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

  def destroy
    @analysis.destroy if @analysis.user_id == current_user.id
    redirect_to action: :index if @analysis.destroy
  end

  def edit
    @category = Category.find_by(name: @analysis.tournament.name)
    @category_children = @category.children

    @category_children_array = []
    Category.where(ancestry: @category_children.first.ancestry).each do |children|
      @category_children_array << children
    end
  end

  def update
    @analysis.update(analysis_params) if @analysis.user_id == current_user.id
    redirect_to action: :index
  end

  def search_analysis
    @analysis = Analysis.find(params[:id])
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

  private
  def set_category
    @category_parent_array = Category.where(ancestry: nil)
  end

  def analysis_params
    params.require(:analysis).permit(:text,:tournament_id,:school_id,:attack,:defensive,:pitcher,:comprehensive).merge(user_id: current_user.id)
  end
end
