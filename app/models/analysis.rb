class Analyses < ApplicationRecord
  belongs_to :tournament,class_name: 'Category', foreign_key: 'tournament_id'
  belongs_to :category
end
