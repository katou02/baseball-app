class Tournament < ApplicationRecord
  has_many :tournament_schools
  has_many :schools,  through: :tournament_schools
  belongs_to :category
  validates :name,presence: true,uniqueness: true
end
