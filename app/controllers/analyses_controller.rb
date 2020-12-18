class AnalysesController < ApplicationController
  before_action :set_category, only:[:index,:new,:create,:edit,:update]
  before_action :search_analysis,only:[:destroy,:edit,:update,:show]
  before_action :move_to_index,except: :index
  
  def index
    @analyses = Analysis.includes(:user).page(params[:page]).per(5).order("created_at DESC")
    render layout: "vue"
  end

  def show
    @user = User.find_by(id: @analysis.user.id)
    @nickname = current_user.nickname
    @comments = @analysis.comment_analyses.includes(:user)
    @comment = current_user.comment_analyses.new
    @num = 1
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
    return redirect_to analyses_path if @analysis.save
    render "new"
  end

  def destroy
    @analysis.destroy if @analysis.user_id == current_user.id || current_user.admin
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
    @analysis.update(update_params) if @analysis.user_id == current_user.id || current_user.admin
    redirect_to action: :show
  end

  def search_analysis
    @analysis = Analysis.find(params[:id])
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

  def search
    @analyses = Analysis.search(params[:keyword]).includes(:user).page(params[:page]).per(5).order("created_at DESC")
  end

  private
  def set_category
    @category_parent_array = Category.where(ancestry: nil)
  end

  def analysis_params
    params.require(:analysis).permit(:title,:text,:tournament_id,:school_id,:attack,:defensive,:pitcher,:comprehensive,:expectations).merge(user_id: current_user.id)
  end

  def update_params
    params.require(:analysis).permit(:title,:text,:tournament_id,:school_id,:attack,:defensive,:pitcher,:comprehensive,:expectations)
  end
end
