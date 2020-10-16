class TournamentsController < ApplicationController
  def show
    @tweets = Tweet.where(tournament_id: params[:id]).includes(:user).page(params[:page]).per(5).order("created_at DESC")
  end
  
  def watch
    @analyses = Analysis.where(tournament_id: params[:id]).includes(:user).page(params[:page]).per(10).order("created_at DESC")
  end
end
