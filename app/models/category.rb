class Category < ApplicationRecord
  has_many :tweets
  has_ancestry

  has_many :school_as_tweets,class_name: 'Tweet',  foreign_key: 'school_as_id'
  has_many :school_bs_tweets,class_name: 'Tweet',  foreign_key: 'school_bs_id'
end
