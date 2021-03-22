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

  def watch_ays
    @analyses = Analysis.where(tournament_id: params[:id]).includes(:user).order("created_at DESC")
    @analysis_tournament = Analysis.find_by(tournament_id: params[:id])
    render 'watch_ays', formats: 'json', handlers: 'jbuilder'
  end

  def watch_fcs
    @forecasts = Forecast.where(tournament_id: params[:id]).includes(:user).order("created_at DESC")
    @category = Category.find(params[:id])
    render 'watch_fcs', formats: 'json', handlers: 'jbuilder'
  end

  def category
    @category = Category.where(ancestry: nil)
    render 'category',formats: 'json',handlers: 'jbuilder'
  end
end