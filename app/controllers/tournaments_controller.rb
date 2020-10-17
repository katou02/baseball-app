class TournamentsController < ApplicationController
  def show
    @tweets = Tweet.where(tournament_id: params[:id]).includes(:user).page(params[:page]).per(5).order("created_at DESC")
  end

  def watch
    @analyses = Analysis.where(tournament_id: params[:id]).includes(:user).page(params[:page]).per(10).order("created_at DESC")
    average(@analyses)
    # binding.pry
  end
  
  def average(num)
    sum = []
    num.each do |analysis|
      sum << {
        name: analysis.school.name,attack_num: analysis.attack.ord,
        defense_num: analysis.defensive.ord,pitch_num: analysis.pitcher.ord
      }
    end
    
    @avgs = sum.group_by{|x| x[:name]}
    .map{|k,x| {name: k, attack_num: x.sum(0.0){|y| y[:attack_num]}/x.size,defense_num: x.sum(0.0){|y| y[:defense_num]}/ x.size,pitch_num: x.sum(0.0){|y| y[:pitch_num]}/ x.size}}.to_a
  end
end
