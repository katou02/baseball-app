class Comment < ApplicationRecord
  belongs_to :tweet
  belongs_to :user
  has_many :notifications,dependent: :destroy
  validates :text,presence: :true
  validates :text,length: {maximum: 300}
end
