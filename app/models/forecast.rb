class Forecast < ApplicationRecord
  has_many :categories
  has_many :comment_forecasts
  has_many :notifications, dependent: :destroy
  belongs_to :user
  belongs_to :win_school,class_name: 'Category', foreign_key: 'win_school_id'
  belongs_to :lose_school,class_name: 'Category', foreign_key: 'lose_school_id'
  belongs_to :tournament,class_name: 'Category', foreign_key: 'tournament_id'
  validates :win_school,:lose_school,:text,:round,:tournament,:probability,presence: true

  def create_notification_comment_forecast!(current_user, comment_forecast_id)
    temp_ids = CommentForecast.select(:user_id).where(forecast_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment_forecast!(current_user, comment_forecast_id, temp_id['user_id'])
    end
    save_notification_comment_forecast!(current_user, comment_forecast_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment_forecast!(current_user, comment_forecast_id, visited_id)
    notification = current_user.active_notifications.new(
      forecast_id: id,
      comment_forecast_id: comment_forecast_id,
      visited_id: visited_id,
      action: 'comment_forecast'
    )
    if notification.visiter_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end
