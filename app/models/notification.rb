class Notification < ApplicationRecord
  default_scope->{order(created_at: :desc)}
  belongs_to :tweet,optional: true
  belongs_to :analysis,optional: true
  belongs_to :forecast,optional: true
  belongs_to :comment,optional: true
  belongs_to :comment_analysis,optional: true
  belongs_to :comment_forecast,optional: true
  belongs_to :visiter, class_name: 'User', foreign_key: 'visiter_id', optional: true
  belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true
  belongs_to :room, optional: true
  belongs_to :message, optional: true
end
