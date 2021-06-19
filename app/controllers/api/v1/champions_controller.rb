class Api::V1::ChampionsController < ApiController
  skip_before_action :verify_authenticity_token
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: 404
  end
  
  def show
    if current_user.present?
      @current_user = current_user
      @my_champion = Champion.find_by(user_id: current_user.id,tournament_id: params[:id])
    end
    @category = Category.find(params[:id]) 
    champions = Champion.where(tournament_id: params[:id])
    @select_schools = Category.where(ancestry: params[:id])
    # binding.pry
    @n=0
    ranking=ranking(champions)
    # graph(ranking)
    date = []
    @schools = []
    @vote = []
    date.push(@school)

    date[0].size.times do |n|
      # 学校
      @schools<<date[0][n].champion_school.name
      # 票数
      @vote<<@num[0][n][1]
    end
    render 'show', formats: 'json', handlers: 'jbuilder'
  end

  def create
    champion = Champion.create(champion_params)
    if champion.save
      render json: champion, status: :created
    else
      render json: { errors: champion.errors.keys.map { |key| [key, champion.errors.full_messages_for(key)]}.to_h, render: 'show.json.jbuilder' }, status: :unprocessable_entity
    end
  end

  def ranking(champions)
    @num = []
    #集計する
    champion_count = champions.group(:champion_school_id).count
    # 重複が多い順に並び替え
    @num << champion_count.sort {|(k1, v1), (k2, v2)| v2 <=> v1 }
    # @num = [[[n,m],[n,m]]]
    # nが学校 mが票数
    @school = []
    # 多い順に格納
    @num[0].length.times do |n|
      # 学校を入れている
      @school << Champion.find_by(champion_school_id: @num[0][n][0])
    end
  end

  def destroy
    @my_champion = Champion.find_by(user_id: current_user.id,tournament_id: params[:id])
    if (@my_champion.user_id == current_user.id) && @my_champion.destroy
      head :no_content
    else
      render json: @my_champion.errors, status: :unprocessable_entity
    end
  end

  private

  def champion_params
    params.require(:champion).permit(:tournament_id,:champion_school_id).merge(user_id: current_user.id)
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