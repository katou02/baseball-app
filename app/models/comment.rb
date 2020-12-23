class Comment < ApplicationRecord
  belongs_to :tweet
  belongs_to :user
  validates :text,presence: :true
  validates :text,length: {maximum: 300}
end
