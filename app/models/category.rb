class Category < ApplicationRecord
  has_many :tweets
  has_ancestry
end
