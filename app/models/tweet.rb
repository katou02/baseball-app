class Tweet < ApplicationRecord
  validates :title_info,length: {maximum: 30}

  belongs_to :school
end