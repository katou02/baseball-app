class TournamentsController < ApplicationController
  before_action :set_category, except: [:average,:watch_avg] 
  before_action :set_categories, except: [:average,:watch_avg] 

  def show
    @tweets = Tweet.where(tournament_id: params[:id]).includes(:user).page(params[:page]).per(5).order("created_at DESC")
    @tweet = Tweet.find_by(tournament_id: params[:id])
  end

  def watch_ays
    @analyses = Analysis.where(tournament_id: params[:id]).includes(:user).page(params[:page]).per(5).order("created_at DESC")
    @analysis_tournament = Analysis.find_by(tournament_id: params[:id])
  end
  
  def watch_avg
    @analyses = Analysis.where(tournament_id: params[:id]).includes(:user).page(params[:page]).per(5).order("created_at DESC")
    average(@analyses)
  end

  def watch_fcs
    @forecasts = Forecast.where(tournament_id: params[:id]).includes(:user).page(params[:page]).per(5).order("created_at DESC")
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

  private
  def set_category
    @category = Category.find(params[:id])
  end

  def set_categories
    @category_parent_array = Category.where(ancestry: nil)
  end
end
