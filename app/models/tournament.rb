class Tournament < ApplicationRecord
  has_many :tournament_schools
  has_many :schools,  through: :tournament_schools
end
