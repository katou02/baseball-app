class Map < ApplicationRecord
  belongs_to :user
  has_many :categories
  belongs_to :school,class_name: 'Category', foreign_key: 'school_id'
  validates :text,length: {maximum: 2000}
  geocoded_by :address
  after_validation :geocode, if: :address_changed?
end
