class Analysis < ApplicationRecord
  belongs_to :tournament,class_name: 'Category', foreign_key: 'tournament_id'
  belongs_to :school,class_name: 'Category', foreign_key: 'school_id'
  has_many :notifications, dependent: :destroy
  belongs_to :user
  has_many :comment_analyses
  has_many :categories
  validates :title,:text,:attack,:defensive,:pitcher,:comprehensive,:expectations,:school,:tournament,presence: true
  validates :title,length: {maximum: 30}

def create_notification_comment_analysis!(current_user, comment_analysis_id)
    temp_ids = CommentAnalysis.select(:user_id).where(analysis_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
        save_notification_comment_analysis!(current_user, comment_analysis_id, temp_id['user_id'])
    end
    save_notification_comment_analysis!(current_user, comment_analysis_id, user_id) if temp_ids.blank?
end

def save_notification_comment_analysis!(current_user, comment_analysis_id, visited_id)
    notification = current_user.active_notifications.new(
      analysis_id: id,
      comment_analysis_id: comment_analysis_id,
      visited_id: visited_id,
      action: 'comment_analysis'
    )
    if notification.visiter_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
 end
end
