class Api::V1::ChampionsController < ApiController
  def show
    @category = Category.find(params[:id]) 
    champions = Champion.where(tournament_id: params[:id])
    @my_champion = Champion.find_by(user_id: current_user.id,tournament_id: params[:id])
    @n=0
    ranking=ranking(champions)
    # graph(ranking)
    date = []
    @schools = []
    @vote = []
    date.push(@school)

    date[0].size.times do |n|
      @schools<<date[0][n].champion_school.name
      @vote<<@num[0][n][1]
    end
# binding.pry
    render 'show', formats: 'json', handlers: 'jbuilder'
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

  # def graph(neok)
  #   date = []
  #   a = []
  #   b = []
  #   date.push(@school)

  #   date[0].size.times do |n|
  #     a<<date[0][n].champion_school.name
  #     b<<@num[0][n][1]
  #   end
  #   # binding.pry
  # end
end