class Map < ApplicationRecord
  belongs_to :user
  belongs_to :school,class_name: 'Category', foreign_key: 'school_id'
  belongs_to :tournament,class_name: 'Category', foreign_key: 'tournament_id'
  has_many :categories
  validates :text,length: {maximum: 2000}
  # 緯度経度
  geocoded_by :address
  after_validation :geocode, if: :address_changed?
end
