class CommentForecast < ApplicationRecord
  belongs_to :forecast
  belongs_to :user
  has_many :notifications,dependent: :destroy
  validates :text,presence: :true
  validates :text,length: {maximum: 300}
end
