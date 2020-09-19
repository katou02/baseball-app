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

  def show
    @tweets = Tweet.where(tournament_id: params[:id]).includes(:user).page(params[:page]).per(5).order("created_at DESC")
  end

  private
  def name_params
    params.require(:tournament).permit(:name)
  end
end
