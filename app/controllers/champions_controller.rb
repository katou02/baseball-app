class ChampionsController < ApplicationController
  before_action :set_category, only:[:new,:create,:show]

  def new
    @n = 1
    @champion = Champion.new
    @tournament = params[:tournament_id]
    @school = Category.where(ancestry: @tournament)
    respond_to do |format|
      format.html
      format.json do
        @category_children = Category.find(params[:tournament_id]).children
      end
    end
  end

  def create
    @champion = Champion.create(champion_params)
    return redirect_to action: 'show',id: @champion.tournament.id if @champion.save
    render "new"
  end

  def show
    @category = Category.find(params[:id]) 
    champions = Champion.where(tournament_id: params[:id])
    @my_champion = Champion.find_by(user_id: current_user.id,tournament_id: params[:id])
    @n=0
    ranking=ranking(champions)
    graph(ranking)
  end

  def destroy
    @my_champion = Champion.find_by(user_id: current_user.id,tournament_id: params[:id])
    redirect_to action: :show if @my_champion.destroy
  end

  def ranking(champions)
    @num = []
    champion_count = champions.group(:champion_school_id).count
    # 重複が多い順に並び替え
    @num << champion_count.sort {|(k1, v1), (k2, v2)| v2 <=> v1 }
    # @num[0].slice!(5,70)
    # @num[0][n][1] 1つめのn学校,2つめは票数
    @school = []
    # 多い順に格納
    @num[0].length.times do |n|
      @school << Champion.find_by(champion_school_id: @num[0][n][0])
    end
  end

  def graph(neok)
    gon.date = []
    gon.a = []
    gon.b = []
    gon.date.push(@school)

    gon.date[0].size.times do |n|
      gon.a<<gon.date[0][n].champion_school.name
      gon.b<<@num[0][n][1]
    end
    # binding.pry
  end

  private
  def set_category
    @category_parent_array = Category.where(ancestry: nil)
  end

  def champion_params
    params.require(:champion).permit(:tournament_id,:champion_school_id).merge(user_id: current_user.id)
  end
end
