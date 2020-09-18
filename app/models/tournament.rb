class Tournament < ApplicationRecord
  has_many :school,  through: :tournament_school
  has_many :tournament_school
end
