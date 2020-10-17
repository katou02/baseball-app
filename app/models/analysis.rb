class Analysis < ApplicationRecord
  belongs_to :school,class_name: 'Category', foreign_key: 'school_id'
  belongs_to :user
  has_many :categories
  validates :text,:attack,:defensive,:pitcher,:comprehensive,:school,:tournament_id,presence: true
end
