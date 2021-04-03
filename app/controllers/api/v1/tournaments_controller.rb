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
  
  def watch_avg
    @analyses = Analysis.where(tournament_id: params[:id]).includes(:user)
    average(@analyses)
    render 'watch_avg', formats: 'json', handlers: 'jbuilder'
  end

  def average(num)
    sum = []
    num.each do |analysis|
      sum << {
        name: analysis.school.name,attack_num: analysis.attack,defense_num: analysis.defensive,
        pitch_num: analysis.pitcher,total_num: analysis.comprehensive,expectations_num:analysis.expectations
      }
    end
    @avgs = sum.group_by{|x| x[:name]}
    .map{|k,x| {name: k, attack_num: x.sum(0.0){|y| y[:attack_num]}/x.size,defense_num: x.sum(0.0){|y| y[:defense_num]}/ x.size,pitch_num: x.sum(0.0){|y| y[:pitch_num]}/ x.size,total_num: x.sum(0.0){|y| y[:total_num]}/ x.size,
                expectations_num: x.sum(0.0){|y| y[:expectations_num]}/x.size}}.to_a
  end
end