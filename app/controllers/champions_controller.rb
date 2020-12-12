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
    # binding.pry
    return redirect_to root_path if @champion.save
    render "new"
  end

  def show
  end

  private
  def set_category
    @category_parent_array = Category.where(ancestry: nil)
  end

  def champion_params
    params.require(:champion).permit(:tournament_id,:champion_school_id).merge(user_id: current_user.id)
  end
end
