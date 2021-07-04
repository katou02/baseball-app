class CommentAnalysis < ApplicationRecord
  belongs_to :analysis
  belongs_to :user
  has_many :notifications,dependent: :destroy
  validates :text,presence: :true
  validates :text,length: {maximum: 300}
end
