class Tweet < ApplicationRecord

  def self.search(search)
    return Tweet.all unless search
    self.where('text LIKE(?) OR title_info LIKE(?)',"%#{search}%","%#{search}%")
  end

  validates :title_info,length: {maximum: 30}
  validates :tournament_id,:school_a,:school_b,:school_a_score,:school_b_score,:text,:title_info ,presence: true
  mount_uploader :image, ImageUploader
  belongs_to :user
  has_many :tournaments
  has_many :comments
  has_many :categories
  belongs_to :school_a,class_name: 'Category', foreign_key: 'school_a_id'
  belongs_to :school_b,class_name: 'Category', foreign_key: 'school_b_id'
end