class Like < ApplicationRecord
  belongs_to :tweet
  belongs_to :user
  validates_uniqueness_of :tweet_id,scope: :user_id
  scope :filter_by_post, ->(tweet_id) { where(tweet_id: tweet_id) if tweet_id }
end
