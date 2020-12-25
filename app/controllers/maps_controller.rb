class MapsController < ApplicationController

  def index
  end

  def new
    @school = Category.where(ancestry: 1)
    @map = Map.new
  end

  def create
    @map = Map.create(map_params)
    return redirect_to maps_path if @map.save
    render "new"
  end

  def show
    @map = Map.find_by(id: 1)
    @address = @map.address
    @latitude = @map.latitude
    @longitude = @map.longitude
  end

  private

  def map_params
    params.require(:map).permit(:address,:school_id)
  end
end
