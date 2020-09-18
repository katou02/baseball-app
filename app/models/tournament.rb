class Tournament < ApplicationRecord
  has_many :tournament_schools
  has_many :schools,  through: :tournament_schools

  validates :name,presence: true,uniqueness: true
end
