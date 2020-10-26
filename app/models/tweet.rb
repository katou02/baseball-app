class Tweet < ApplicationRecord

  def self.search(search)
    return Tweet.all unless search
    self.where('text LIKE(?) OR title_info LIKE(?)',"%#{search}%","%#{search}%")
  end

  validates :title_info,length: {maximum: 30}
  validates :tournament_id,:school_a,:school_b,:school_a_score,:school_b_score,:text,:title_info ,presence: true
  mount_uploader :image, ImageUploader
  belongs_to :user
  has_many :comments
  has_many :categories
  has_many :likes
  has_many :liked_users,through: :likes,source: :user
  has_many :notifications,dependent: :destroy
  belongs_to :school_a,class_name: 'Category', foreign_key: 'school_a_id'
  belongs_to :school_b,class_name: 'Category', foreign_key: 'school_b_id'
  belongs_to :tournament,class_name: 'Category', foreign_key: 'tournament_id'

  def create_notification_like!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and tweet_id = ? and action = ?",current_user.id,user_id,id,"like"])
    if temp.blank?
      notification = current_user.active_notifications.new(
        tweet_id: id,
        visited_id: user_id,
        action: "like"
      )
      
      if notification.visiter_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end
end