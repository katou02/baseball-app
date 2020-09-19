class School < ApplicationRecord
  has_many :tournament_schools
  has_many :tournaments, through: :tournament_schools

  validates :name,presence: true
end
