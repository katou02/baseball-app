class CommentAnalysis < ApplicationRecord
  belongs_to :analysis
  belongs_to :user
  validates :text,presence: :true
  validates :text,length: {maximum: 300}
end
