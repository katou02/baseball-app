class Analysis < ApplicationRecord
  belongs_to :tournament,class_name: 'Category', foreign_key: 'tournament_id'
  belongs_to :school,class_name: 'Category', foreign_key: 'school_id'
  belongs_to :category
end
