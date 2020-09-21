class Category < ApplicationRecord
  has_many :tournaments
  has_ancestry 
end
