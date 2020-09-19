class TournamentSchool < ApplicationRecord
  belongs_to :school
  belongs_to :tournament
end
