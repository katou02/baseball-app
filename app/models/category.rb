class Category < ApplicationRecord
  has_many :tweets
  has_many :analyses
  has_many :forecasts
  has_many :champions
  has_ancestry
  has_many :school_a_tweets,class_name: 'Tweet',  foreign_key: 'school_a_id'
  has_many :school_b_tweets,class_name: 'Tweet',  foreign_key: 'school_b_id'
  has_many :tournament_tweets,class_name: 'Tweet',  foreign_key: 'tournament_id'
  has_many :school_analyses,class_name: 'Analysis',  foreign_key: 'school_id'
  has_many :tournament_analyses,class_name: 'Analysis',  foreign_key: 'tournament_id'
  has_many :win_school_forecasts,class_name: 'Forecast',  foreign_key: 'win_school_id'
  has_many :lose_school_forecasts,class_name: 'Forecast',  foreign_key: 'lose_school_id'
  has_many :tournament_forecasts,class_name: 'Forecast',  foreign_key: 'tournament_id'
  has_many :tournament_champions,class_name: 'Champion',  foreign_key: 'tournament_id'
end
