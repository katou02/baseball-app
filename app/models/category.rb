class Category < ApplicationRecord
  has_many :tweets
  has_ancestry
  has_many :school_a_tweets,class_name: 'Tweet',  foreign_key: 'school_a_id'
  has_many :school_b_tweets,class_name: 'Tweet',  foreign_key: 'school_b_id'
  has_many :tournament_tweets,class_name: 'Tweet',  foreign_key: 'tournament_id'
end
