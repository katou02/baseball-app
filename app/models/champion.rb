class Champion < ApplicationRecord
  belongs_to :user
  belongs_to :champion_school,class_name: 'Category', foreign_key: 'school_a_id'
  belongs_to :tournament,class_name: 'Category', foreign_key: 'tournament_id'
end
