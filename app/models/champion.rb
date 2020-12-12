class Champion < ApplicationRecord
  belongs_to :user
  belongs_to :champion_school,class_name: 'Category', foreign_key: 'champion_school_id'
  belongs_to :tournament,class_name: 'Category', foreign_key: 'tournament_id'
  validates :tournament_id,:champion_school,presence: true
end
