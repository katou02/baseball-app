class ChampionsController < ApplicationController
  before_action :set_category, only:[:new,:create]

  def new
    @champion = Champion.new
    respond_to do |format|
      format.html
      format.json do
        @category_children = Category.find(params[:tournament_id]).children
      end
    end
  end

  def create
    @champion = Champion.create(champion_params)
    return redirect_to champions_path if @champion.save
    render "new"
  end

  def show
  end

  private
  def set_category
    @category_parent_array = Category.where(ancestry: nil)
  end
end
