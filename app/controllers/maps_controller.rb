class MapsController < ApplicationController

  def index
    @maps = Map.includes(:user).page(params[:page]).per(5).order("created_at DESC")
  end
  
  
  def new
    @school = Category.where(ancestry: 1)
    @tournament = Category.find_by(id: 1)
    @map = Map.new
  end
  
  def create
    @map = Map.create(map_params)
    return redirect_to maps_path if @map.save
    render "new"
  end
  
  def show
    @map = Map.find(params[:id])
    @address = @map.address
    @latitude = @map.latitude
    @longitude = @map.longitude
  end

  private

  def map_params
    params.require(:map).permit(:address,:school_id,:text,:tournament_id).merge(user_id: current_user.id)
  end
end
