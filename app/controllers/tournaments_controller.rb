class TournamentsController < ApplicationController
  def show
    @tweets = Tweet.where(tournament_id: params[:id]).includes(:user).page(params[:page]).per(5).order("created_at DESC")
    @tweet = Tweet.find_by(tournament_id: params[:id])
  end

  def watch
    @analysis = Category.find(params[:id])
    @analyses = Analysis.where(tournament_id: params[:id]).includes(:user).page(params[:page]).per(5).order("created_at DESC")
    @analysis_tournament = Analysis.find_by(tournament_id: params[:id])
  end
  
  def watch_avg
    @analyses = Analysis.where(tournament_id: params[:id]).includes(:user).page(params[:page]).per(5).order("created_at DESC")
    average(@analyses)
  end

  def watch_fcs
    @forecasts = Forecast.where(tournament_id: params[:id]).includes(:user).page(params[:page]).per(5).order("created_at DESC")
    @forecast = Forecast.find_by(tournament_id: params[:id])
  end
  
  def average(num)
    sum = []
    num.each do |analysis|
      sum << {
        name: analysis.school.name,attack_num: analysis.attack.ord,
        defense_num: analysis.defensive.ord,pitch_num: analysis.pitcher.ord,total_num: analysis.comprehensive.ord
      }
    end
    @avgs = sum.group_by{|x| x[:name]}
    .map{|k,x| {name: k, attack_num: x.sum(0.0){|y| y[:attack_num]}/x.size,defense_num: x.sum(0.0){|y| y[:defense_num]}/ x.size,pitch_num: x.sum(0.0){|y| y[:pitch_num]}/ x.size,total_num: x.sum(0.0){|y| y[:total_num]}/ x.size}}.to_a
  end
end
