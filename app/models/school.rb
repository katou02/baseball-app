class School < ApplicationRecord
  has_many :tournament, through: :tournament_school
  has_many :tournament_school
end
