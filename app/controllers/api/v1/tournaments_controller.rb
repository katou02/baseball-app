class Api::V1::TournamentsController < ApiController
  def show
    @tweets = Tweet.where(tournament_id: params[:id]).includes(:user).page(params[:page]).per(5).order("created_at DESC")
    @tweet = Tweet.find_by(tournament_id: params[:id])
    render 'show', formats: 'json', handlers: 'jbuilder'
  end
end