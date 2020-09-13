class TournamentsController < ApplicationController
  def new
    @tournament = Tournament.new
  end

  def create
    @tournament = Tournament.create(name: name_params[:name])
    
    if @tournament.save
      redirect_to action: :new
    else
      render "new"
    end
  end

  private
  def name_params
    params.require(:tournament).permit(:name)
  end
end
