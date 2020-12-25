class CommentForecast < ApplicationRecord
  belongs_to :forecast
  belongs_to :user
  validates :text,presence: :true
  validates :text,length: {maximum: 300}
end
