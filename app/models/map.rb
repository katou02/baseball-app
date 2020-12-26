class Map < ApplicationRecord
  validates :text,length: {maximum: 2000}
  geocoded_by :address
  after_validation :geocode, if: :address_changed?
end
