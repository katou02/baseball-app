class Tweet < ApplicationRecord

  def self.search(search)
    return Tweet.all unless search
    Tweet.where('school_a LIKE(?) OR school_b LIKE(?) OR text LIKE(?) OR title_info LIKE(?)', "%#{search}%","%#{search}%","%#{search}%","%#{search}%")
  end

  validates :title_info,length: {maximum: 30}
  validates :school_a,:school_b,:school_a_score,:school_b_score,:text,:title_info ,presence: true
  validates :school_a_score,:school_b_score, numericality: true
  mount_uploader :image, ImageUploader
  belongs_to :user
  belongs_to :tournament
  has_many :comments
end