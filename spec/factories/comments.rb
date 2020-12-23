FactoryBot.define do
  factory :comment do
    text { "テキスト" }
    association :tweet,factory: :tweet
    association :user,factory: :user
  end
end