class Forecast < ApplicationRecord
  has_many :categories
  belongs_to :user
  belongs_to :win_school,class_name: 'Category', foreign_key: 'win_school_id'
  belongs_to :lose_school,class_name: 'Category', foreign_key: 'lose_school_id'
  belongs_to :tournament,class_name: 'Category', foreign_key: 'tournament_id'
end
