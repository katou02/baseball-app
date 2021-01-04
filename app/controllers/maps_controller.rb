class MapsController < ApplicationController
  before_action :search_map,only:[:show,:destroy]

  def index
    @maps = Map.where(tournament_id: params[:tournament_id]).includes(:user).page(params[:page]).per(5).order("created_at DESC")
  end
  
  
  def new
    @school = Category.where(ancestry: params[:tournament_id])
    @tournament = params[:tournament_id]
    @map = Map.new
  end
  
  def create
    @map = Map.create(map_params)
    return redirect_to action: 'index',tournament_id: @map.tournament.id if @map.save
    render "new"
  end
  
  def show
    @address = @map.address
    @latitude = @map.latitude
    @longitude = @map.longitude
  end

  def destroy
    @map.destroy if @map.user_id == current_user.id || current_user.admin
    redirect_to action: 'index',tournament_id: @map.tournament.id if @map.destroy
  end

  def search_map
    @map = Map.find(params[:id])
  end

  private

  def map_params
    params.require(:map).permit(:address,:school_id,:text,:tournament_id).merge(user_id: current_user.id)
  end
end
