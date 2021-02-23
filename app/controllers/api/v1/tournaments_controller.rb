class Api::V1::TournamentsController < ApiController
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: 404
  end
  
  def show
    @tweets = Tweet.where(tournament_id: params[:id]).includes(:user).order("created_at DESC")
    # @tweets = Tweet.all
    @tweet = Tweet.find_by(tournament_id: params[:id])
    render 'show', formats: 'json', handlers: 'jbuilder'
  end
end