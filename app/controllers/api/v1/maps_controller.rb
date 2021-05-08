class Api::V1::MapsController < ApiController
  before_action :search_map,only:[:show,:destroy,:edit,:update]

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: 404
  end

  def new
    @school = Category.where(ancestry: params[:tournament_id])
    @tournament = Category.find_by(id: params[:tournament_id])
    render 'new', formats: 'json', handlers: 'jbuilder'
  end

  def create
    map = Map.create(map_params)
    if map.save
      render json: map, status: :created
    else
      render json: { errors: map.errors.keys.map { |key| [key, map.errors.full_messages_for(key)]}.to_h, render: 'show.json.jbuilder' }, status: :unprocessable_entity
    end
  end

  def index
    @maps = Map.where(tournament_id: params[:tournament_id]).includes(:user).order("created_at DESC")
    @id = params[:tournament_id]
    @categories = Category.where(ancestry: nil)
    @tournament = Category.find_by(id: @id)
    render 'index', formats: 'json', handlers: 'jbuilder'
  end

  def show
    render 'show',formats: 'json', handlers: 'jbuilder'
  end

  def edit
    @schools = Category.where(ancestry: @map.tournament_id)
  end
  
  def update
    if @map.user_id == current_user.id || current_user.admin
      if @map.update(update_params) 
        head :no_content
      else
        render json: { errors: @map.errors.keys.map { |key| [key, @map.errors.full_messages_for(key)]}.to_h, render: 'show.json.jbuilder' }, status: :unprocessable_entity
      end
    end
  end

  def destroy
    if @map.user_id == current_user.id || current_user.admin
      if @map.destroy
        head :no_content
      else
        render json: @map.errors, status: :unprocessable_entity
      end
    end
  end

  def search_map
    @map = Map.find(params[:id])
  end

  private

  def map_params
    params.permit(:address,:school_id,:text,:tournament_id,:image).merge(user_id: current_user.id)
  end

  def update_params
    params.permit(:address,:school_id,:text,:tournament_id,:image).merge(user_id: current_user.id)
  end
end