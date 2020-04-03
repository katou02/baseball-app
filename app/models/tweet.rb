class Tweet < ApplicationRecord
  validates :title_info,length: {maximum: 30}
  validates :school_a,:school_b,:school_a_score,:school_b_score,:text,:title_info ,presence: true
  validates :school_a_score,:school_b_score, numericality: true
  mount_uploader :image, ImageUploader
end