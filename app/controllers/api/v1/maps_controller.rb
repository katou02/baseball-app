class Api::V1::MapsController < ApiController
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: 404
  end

  def new
    @school = Category.where(ancestry: params[:tournament_id])
    @tournament = params[:tournament_id]
    # binding.pry
    render 'new', formats: 'json', handlers: 'jbuilder'
  end

  def index
    @maps = Map.where(tournament_id: params[:tournament_id]).includes(:user).order("created_at DESC")
    @id = params[:tournament_id]
    @categories = Category.where(ancestry: nil)
    @tournament = Category.find_by(id: @id)
    render 'index', formats: 'json', handlers: 'jbuilder'
  end

  def show
    @map = Map.find(params[:id])
    render 'show',formats: 'json', handlers: 'jbuilder'
  end
end