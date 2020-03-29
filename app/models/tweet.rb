class Tweet < ApplicationRecord
  validates :title_info,length: {maximum: 30}
  validates :school_a,:school_b,:school_a_score,:school_b_score,:text ,presence: true
  validates :school_a_score,:school_b_score, numericality: true
end